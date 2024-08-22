/*
Ext.define('Ext.ActionSheet', {
    title: 'Grund',
    extend: 'Ext.window.Window',
    height: 400,
    width: 400,
    modal: true,
    layout: {
        type: 'vbox',
        pack: 'start',
        align: 'stretch'
    },

    / *items: {  // Let's put an empty grid in just to illustrate fit layout
        xtype: 'grid',
        border: false,
        columns: [{header: 'World'}],                 // One header just for show. There's no data,
        store: Ext.create('Ext.data.ArrayStore', {}) // A dummy empty data store
    }* /
});
*/
Ext.define('Tualo.PaperVote.lazy.Logic', {
    extend: 'Ext.Component',
    //mixins: ['Ext.mixin.Observable'],
    startingState: 'warteAufWB',
    typen_index: 0,
    blocknumber: '0',
    transit: function(toState, event) {
        this.FSM.transit(toState, event);
    },
    allowTransit: function(transition, action, action2, events, clobberable) {
        this.FSM.allowTransit(transition, action, action2, events, clobberable);
    },
    wahlscheinstatusHash: {},
    wbliste: [],
    wbhash: {},
    FORCEBLOCKCODE: false,
    liste: function(scope) {
        return function() {
            var values = scope.form.getValues();

            if (scope.checkReload(values._read_barcode)) {
                if (values._read_barcode.substring(0, 2) === 'FC') {

                    scope.setze(scope)();
                } else {

                    scope.lese(scope)();
                }
            }
        }
    },
    leseleeren: function(scope) {
        return function() {
            var values = scope.form.getValues();
            if (scope.checkReload(values._read_barcode)) {
                scope.last_message = "Leeren wird erwartet.";
                scope.transit('WBFehler');
            }
        }
    },
    lese: function(scope) {
        return async function() {
            var values = scope.form.getValues();

            if (scope.checkReload(values._read_barcode)) {

                if (values._read_barcode.substring(0,3)=='FC7'){
                    scope.last_message = ""+values._read_barcode;//.substring(3);
                    scope.transit('useBlock');
                }else{

                    if ((scope.FORCEBLOCKCODE===true)&&(scope.blocknumber=='0')){
                        console.log('-----');
                        scope.last_message = "Bitte geben Sie zuerst den Block an";
                        scope.transit('WBFehler');

                    }else{

                            try{
                            let url = (scope.useident===true)?('./papervote/identnummer/'+values._read_barcode):('./papervote/wahlschein/'+values._read_barcode);
                            let o = await (await fetch(url)).json()
                            if (o.success) {
                                var _x=JSON.stringify(o),dataindex=0;
                                o.data.forEach(function(itm){
                                    var _xo = JSON.parse(_x);
                                    _xo.data=itm;
                                    scope.successRead(_xo,++dataindex,o.data.length);
                                });
                            } else {
                                o.data.forEach(function(itm){
                                    scope.wbliste=[itm.wahlschein_ridx].concat(scope.wbliste);
                                    scope.wbhash[itm.wahlschein_ridx]=itm;
                                });
                                scope.fireEvent('loaded', scope, '',o.data[0]);
                                scope.last_message = o.msg;
                                scope.transit('WBFehler');
                            }
                        } catch (e) {
                            scope.last_message = e;
                            scope.transit('WBFehler');
                        }
                    }
                }
            }
        }
    },
    successRead: function(o,dataindex,resultrows) {
        var me = this;
        me.last_message = '';
        me.typen_index = 0;
        me.dataSet = [];
        var reset = false;
        if (dataindex==1)me.hasOldError=false;

        me.typen = [];
        var typen = me.model.getStore('wahltyp').getRange();
        var status = me.model.getStore('wahlscheinstatus').getRange();
        var use_typen = [];
        var text = 'unbekannt';
        console.log('successRead',typen,'dataindex',dataindex,'hasOldError',me.hasOldError);

        typen.forEach(function(record) {
            
            if ( o.data.hasOwnProperty(record.get('feld'))  
                && (o.data.wahltyp_ridx == record.get('ridx'))
            ){
            

            console.log(record.get('name'),record.get('feld'));
            

              if (!Ext.isEmpty(o.data[record.get('stimmzettelfeld')])){
                var st = o.data[record.get('feld')];
                if ((st != '-1|0') && (st != '1|0') && (st != '6|0')) {
                    reset = true;
                }

                me.typen.push({
                    ridx: record.get('ridx'),
                    feld: record.get('feld'),
                    name: record.get('name')
                });
                status.forEach(function(statusRecord) {
                    if (st == statusRecord.get('ridx')) {
                        text = statusRecord.get('name');
                    }
                });
              }
            }
        });

        console.log('successRead',me.typen);
        // doppeltefassung verhindern.
        if (me.wbliste.indexOf(o.data.wahlschein_ridx)>=0){
          if (me.wbliste.length === me.list_length) {
              me.transit('warteAufStatus');
          } else {
              me.transit('warteAufStatusOderWB');
          }
        }else{

          me.wbliste=[o.data.wahlschein_ridx].concat(me.wbliste);
          //me.wbliste.push(o.data.wahlschein_ridx);
          me.wbhash[o.data.wahlschein_ridx]=o.data;
          me.fireEvent('loaded', me, '',o.data);
          if (me.list_length === 1) {
              if (reset == true) {

//                me.last_message = "*"+( ( typeof me.wahlscheinstatusHash[o.data.wahlscheinstatus]=='string' )?me.wahlscheinstatusHash[o.data.wahlscheinstatus]:'nicht bekannter Statuscode ('+o.data.wahlscheinstatus+')' )+'*';
                me.last_message = me.getTanText(o.data).join(',')+'.';
                me.last_message += (o.data.abgabetyp == '2|0')?' (Online)':' (Brief)';
                me.last_message += ' ('+o.data.blocknumber+')';

                me.transit('warteAufTAN');
              } else {
                  me.transit('warteAufStatus');
              }
          } else {
              if ((reset === false)  && (me.hasOldError === true)){
                if (resultrows==dataindex){
                    me.transit('WBFehler');
                }
              }
              
              if (reset === true) {
                  me.last_message += "Der Berechtigte wurde bereits erfasst *"+( ( typeof me.wahlscheinstatusHash[o.data.wahlscheinstatus]=='string' )?me.wahlscheinstatusHash[o.data.wahlscheinstatus]:'nicht bekannter Statuscode ('+o.data.wahlscheinstatus+')' )+'*.';
                  me.last_message += (o.data.abgabetyp == '2|0')?' (Online)':' (Brief)';
                  me.last_message += ' ('+o.data.blocknumber+')';

                  if (resultrows==dataindex){
                    me.transit('WBFehler');
                  }else{
                    // Fehler merken
                    me.hasOldError = true;
                    me.transit('warteAufStatusOderWB');
                 }
              } else {
                  if (me.wbliste.length === me.list_length) {
                      me.transit('warteAufStatus');
                  } else {
                      me.transit('warteAufStatusOderWB');
                  }
              }
          }
        }

    },
    dataSet: [],

    getTanText: function(o){
        var scope = this;
        var typen = scope.model.getStore('wahltyp').getRange();
        var status = scope.model.getStore('wahlscheinstatus');
        var text = [];
        try{
            typen.forEach(function(rec){
                if (!Ext.isEmpty(o[rec.get('stimmzettelfeld')])
                && (o.wahltyp_ridx == rec.get('ridx'))
                ){
                    var txt = status.findRecord('ridx',o[rec.get('feld')],0,false,false,true);
                    if (Ext.isEmpty(txt)){
                        txt = 'unbekannter Statuscode ('+o[rec.get('feld')]+') ';
                    }else{
                        txt = txt.get('name');
                    }
                    text.push(rec.get('name')+': '+txt);
                }
            });
        }catch(e){
            console.log(e);
        }
        return text;

    },

    checkReload: function(code) {
        if (code === 'FC208') {
            this.fireEvent('reload',  '');
            return false;
        }
        return true;
    },
    reload: function() {
      //  window.document.location.reload();
    },
    tan: function(scope) {
        return async function() {
            var values = scope.form.getValues();
            if (scope.checkReload(values._read_barcode)) {

                try {
                    let url = './papervote/return/tan/'+scope.wbliste[0]+'/'+values._read_barcode;
                    let o = await (await fetch(url)).json();
                    if (o.success) {
                        scope.transit('warteAufStatus');
                    } else {
                        scope.last_message = o.msg;
                        scope.transit('warteAufTAN');
                    }
                } catch (e) {
                    scope.last_message = e;
                    scope.transit('WBFehler');
                }

                
            }
        }
    },
    grund: function(scope) {
        return function() {}
    },
    setze: function(scope) {
      return this._setze.bind(scope)
    },
    _setze: function(){
      var scope = this;
      var me = scope;
      var typen = scope.model.getStore('wahltyp').getRange();
      var status = scope.model.getStore('wahlscheinstatus').getRange();
      var values = scope.form.getValues();
      if (scope.checkReload(values._read_barcode)) {
          var statusItem;
          status.forEach(function(statusRecord){
            if (values._read_barcode == statusRecord.get('barcode')) {
              statusItem = statusRecord;
            }
          });

          if (typeof statusItem === 'undefined') {
              scope.last_message = 'Der Statuscode ist nicht bekannt';
              scope.transit('WBFehler');
          } else {
              scope.dataSet.push({
                  feld: scope.typen[scope.typen_index].feld,
                  status: statusItem.get('ridx')
              });
              scope.lastsavesatte = statusItem.get('name');

              var list = [];
              var d = list.length;

              var status_grund = scope.model.getStore('wahlscheinstatus_grund').getRange();
              /*
              var o = {};
              o[me.typen[scope.typen_index].feld] = status.name;
              */
              //scope.form.setValues(o);
              var xid = Ext.id();
              var list = [];
              list.push({
                  xtype: 'textfield',
                  id: xid,
                  label: 'Code:',
                  value: '',
                  autoCapitalize: false,
                  listeners: {
                      scope: scope,
                      specialkey: function(t, e, opt) {
                          var scope = this;
                          if (e.browserEvent.keyCode == 13 || e.browserEvent.keyCode == 10) {
                              e.stopEvent();
                              t.getEl().blur();
                              var bc = t.getValue();
                              t.setValue('');

                              status_grund.forEach(function(statusgrundRecord){
                                if (statusgrundRecord.get('barcode')==bc){
                                  try {
                                      var o = {};
                                      o[scope.typen[scope.typen_index].feld] = statusItem.get('name') + ' (' + statusgrundRecord.get('name') + ')';
                                      scope.dataSet[scope.typen_index].grund = statusgrundRecord.get('ridx');
                                      scope.btnActionSheet.hide();
                                      scope._nextStatus()
                                  } catch (e) {
                                      console.log(e);
                                  }
                                }
                              });

                          }
                      }
                  }
              });
              list.push({
                  xtype: 'panel',
                  html: ' ',
                  height: 20
              });
              var d = list.length;

              status_grund.forEach(function(statusgrundRecord){
                  if (statusgrundRecord.get('wahlscheinstatus') === statusItem.get('ridx')) {
                      list.push({
                          text: statusgrundRecord.get('name'),
                          idx:  statusgrundRecord.get('ridx'),
                          xtype: 'button',
                          scope: scope,
                          handler: function(grund, status) {
                              return function(b) {
                                  try {
                                    //alert(b);
                                      var o = {};
                                      o[me.typen[this.typen_index].feld] = status.get('name') + ' (' + grund.get('ridx') + ')';
                                      //this.form.setValues(o);

                                      this.dataSet[this.typen_index].grund = grund.get('ridx');
                                      this.btnActionSheet.hide();
                                      this._nextStatus()
                                  } catch (e) {
                                      console.log(e);
                                  }
                              }
                          }(statusgrundRecord, statusItem)
                      });
                  }
              });

              if (list.length == d) {
                  scope._nextStatus();
              } else {

                  scope.fireEvent('message', scope, 'Bitte scannen Sie einen Grund');
                  scope.fireEvent('state', scope, 'warning');

                  scope.transit('warteAufGrund');
                  scope.btnActionSheet = new Ext.ActionSheet({
                      items: list
                  });
                  Ext.Viewport.add(scope.btnActionSheet);
                  scope.btnActionSheet.show(true);
                  Ext.getCmp(xid).focus();

              }


          }
      }
    },
    getSaveText: function(){
        var scope = this;
        var typen = scope.model.getStore('wahltyp');
        var status = scope.model.getStore('wahlscheinstatus');
        var text = [];
        try{
            this.lastdataSet.forEach(function(statusrec){
                text.push(/*typen.findRecord('feld',statusrec['feld'],0,false,false,true).get('name')+': '+*/status.findRecord('ridx',statusrec['status'],0,false,false,true).get('name'))
            });
        }catch(e){
            console.log(e);
        }
        return text;

    },
    _nextStatus: async function() {
        var scope = this;
        scope.typen_index++;
        /*
        if (scope.typen_index < scope.typen.length) {
            scope.last_message = '';
            scope.transit('warteAufStatus');
        } else {
            */
            scope.typen_index = 0;
            scope.last_message = '';

            let url = './papervote/return/save';
            let params = {
                status: Ext.JSON.encode(scope.dataSet),
                liste: Ext.JSON.encode(scope.wbliste),
                blocknumber: scope.blocknumber,
                useident: (scope.useident===true)?'1':'0'
            };
            try{
                let o = await (await fetch(url,{
                    method: 'POST',
                    body: JSON.stringify(params)
                })).json();

                if (o.success) {
                    try {
                        scope.lastwbliste = scope.wbliste;
                        scope.lastdataSet = scope.dataSet;
                        
                        scope.wbliste=[];
                        scope.wbhash={};

    //                              scope.fireEvent('loaded', scope, '',{});
                    scope.transit('warteAufWB');
                    } catch (e) {

                    }
                } else {
                    scope.last_message = o.msg;
                    scope.transit('WBFehler');
                }
            } catch (e) {

                scope.last_message = e;
                scope.transit('WBFehler');
            }

            
    },

    initLogic: async function(size) {
        var me = this;
        this.list_length = size;

        this.FSM = Ext.create('Tualo.PaperVote.lazy.ReturnFSM', {
            startingState: this.startingState
        });

        let res = await (await fetch('./papervote/return/setup')).json();
        if ( res.success === false){
            scope.fireEvent('message', scope, res.msg + ' Scannen Sie *Leeren*.');
            scope.fireEvent('refocus', scope, '');
            scope.fireEvent('state', scope, 'error');
            return;
        }
        if (!Ext.isEmpty(res.data.FORCEBLOCKCODE)){
            if(res.data.FORCEBLOCKCODE.daten=='1'){
                me.FORCEBLOCKCODE = true;
            }
        }

        this.allowTransit('einlesen => WBFehler', null, function(scope) {
            return function() {
                console.log(scope.last_message);
                scope.fireEvent('message', scope, scope.last_message + ' Scannen Sie *Leeren*.');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('state', scope, 'error');
                scope.wbliste = [];
                scope.wbhash = {};

            }
        }(this));


        


        this.allowTransit('einlesen => useBlock', null, function(scope) {
            return function() {
                console.log('useBlock',scope.last_message);
                scope.blocknumber=scope.last_message;
                scope.fireEvent('blockchanged', scope, scope.blocknumber);
                scope.fireEvent('refocus', scope, '');
                scope.transit('warteAufWB');
            }
        }(this));
        this.fireEvent('blockchanged', this, this.blocknumber);

        this.allowTransit('warteAufStatusOderWB => warteAufStatus', null, ()=>{});
        this.allowTransit('warteAufStatusOderWB => warteAufStatusOderWB', null, ()=>{});
        this.allowTransit('WBFehler => WBFehler', null, ()=>{});

        

        this.allowTransit('warteAufStatusOderWB => WBFehler', null, function(scope) {
            return function() {
                console.log(scope.last_message);
                scope.fireEvent('message', scope, 'Für mindestens einen Wahltyp ist eine Beteiligung verzeichnet, scannen Sie *Leeren*.');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('state', scope, 'error');
            }
        }(this))
        
        ;

        this.allowTransit('warteAufStatus => WBFehler', null, function(scope) {
            return function() {
                console.log(scope.last_message);
                scope.fireEvent('message', scope, ' Scannen Sie *Leeren*.');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('state', scope, 'error');
            }
        }(this));
        this.allowTransit('WBFehler =>  einlesen', null, this.leseleeren(this));

        this.allowTransit('warteAufWB => einlesen', null, this.lese(this));

        this.allowTransit('useBlock => warteAufWB', null, function(scope) {
            return function() {
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('message', scope, 'Scannen Sie einen Berechtigten.');
            }
        });

        this.allowTransit('warteAufStatus => einlesen', null, this.setze(this));
        this.allowTransit('warteAufStatusOderWB => einlesen', null, this.liste(this));
        this.allowTransit('warteAufTAN => einlesen', null, this.tan(this));
        this.allowTransit('einlesen => warteAufGrund', null, this.grund(this));
        this.allowTransit('warteAufGrund => warteAufWB', null, function(scope) {
            return function() {
                scope.fireEvent('state', scope, '');
                scope.fireEvent('refocus', scope, '');
                //scope.fireEvent('reset',scope,'');
                scope.fireEvent('saved', scope, '');
                scope.fireEvent('message', scope, 'Scannen Sie einen Berechtigten.');
            }
        }(this));

        this.allowTransit('warteAufGrund => warteAufStatus', null, function(scope) {
            return function() {
                scope.fireEvent('state', scope, 'ok');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('message', scope, 'Scannen Sie den Status f&uuml;r die ' + scope.typen[scope.typen_index].name);
            }
        }(this));
        this.allowTransit('einlesen => warteAufWB', null, function(scope) {
            return function() {
                scope.fireEvent('state', scope, '');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('saved', scope, '');
                scope.fireEvent('message', scope, 'Scannen Sie einen Berechtigten.');
            }
        }(this));
        this.allowTransit('einlesen => warteAufStatusOderWB', null, function(scope) {
            return function() {
                scope.fireEvent('state', scope, 'ok');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('message', scope, 'Scannen Sie einen Berechtigten oder den Status');// f&uuml;r die ' + scope.typen[scope.typen_index].name);
            }
        }(this));
        this.allowTransit('einlesen => warteAufStatus', null, function(scope) {
            return function() {
                scope.fireEvent('state', scope, 'ok');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('message', scope, 'Scannen Sie den Status ');// f&uuml;r die ' + scope.typen[scope.typen_index].name);
            }
        }(this));
        this.allowTransit('einlesen => warteAufTAN', null, function(scope) {
            return function() {
                scope.fireEvent('state', scope, 'yellow');
                scope.fireEvent('refocus', scope, '');
                scope.fireEvent('message', scope, scope.last_message + ' Scannen Sie eine freie TAN, um mit diesem Berechtigten fortzufahren.');
            }
        }(this));
        this.fireEvent('refocus', this, '');
    }
});
