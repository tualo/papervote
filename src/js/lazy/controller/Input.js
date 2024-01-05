Ext.define('Tualo.PaperVote.lazy.controller.Input', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.papervote_input',
  onBlur: function (fld) {
    var el = document.getElementById(fld.id + '-inputEl');
    el.style.backgroundColor = 'rgb(155,0,0)';
  },
  onFocus: function (fld) {
    var el = document.getElementById(fld.id + '-inputEl');
    el.style.backgroundColor = 'rgb(255,255,255)';
  },
  scrollIntoView: function (store, records, index) {
    /*
    var grid=this.lookupReference('centerlist'),
        gridview = grid.getView(),
        scroller = gridview.getScrollable(),
        store = grid.getStore(),
        sr = store.getRange();
    scroller.scrollTo(null, sr.length*50, true);
    */
  },
  onListAdd: function (store, records, index, eOpts) {
    Ext.Function.defer(this.scrollIntoView, 500, this, [store, records, index]);
  },
  onListRemove: function (store, records, index, isMove, eOpts) {
    Ext.Function.defer(this.scrollIntoView, 500, this, [store, records, index]);
  },
  onBoxReady: function () {
    var me = this;


    var wahlscheinstatusStore = me.getViewModel().getStore('wahlscheinstatus');
    wahlscheinstatusStore.load();
    var wahltypStore = me.getViewModel().getStore('wahltyp');
    wahltypStore.load({
      params: {
        filter: Ext.JSON.encode([{ property: 'wahltyp__aktiv', value: '1', operator: 'eq' }])
      }
    });


    var wahlscheinstatusGrundStore = me.getViewModel().getStore('wahlscheinstatus_grund');
    wahlscheinstatusGrundStore.load();

    var ruecklauffelderStore = me.getViewModel().getStore('ruecklauffelder');
    ruecklauffelderStore.load({
      params: {
        filter: Ext.JSON.encode([{ property: 'ruecklauffelder__aktiv', value: '1', operator: 'eq' }])
      }
    });

    var wzbruecklauffelderStore = me.getViewModel().getStore('wzbruecklauffelder');
    wzbruecklauffelderStore.load({
      params: {
        filter: Ext.JSON.encode([{ property: 'wzbruecklauffelder__aktiv', value: '1', operator: 'eq' }])
      }
    });



    me.logic = Ext.create('Tualo.PaperVote.lazy.Logic', {
      form: me.lookupReference('bcForm'),
      model: me.getViewModel()
    });

    me.logic.useident = false;

    var list_length = 1;
    if (this.view.request && this.view.request.list_length) {
      list_length = parseInt(this.view.request.list_length);
    }

    if (this.view && this.view.list_length) {
      list_length = parseInt(this.view.list_length);
    }

    if (this.view && this.view.useident && (this.view.useident == '1')) {
      me.logic.useident = true;
    }

    if (this.view.request && this.view.request.useident) {
      if (this.view.request.useident == '1') {
        me.logic.useident = true;
      }
    }


    console.log('list_length', list_length);
    console.log('useident', me.logic.useident);

    me.getViewModel().set('list_length', list_length);
    me.getViewModel().set('useident', me.logic.useident);

    this.logic.on('blockchanged', function (o, number) {
      me.getViewModel().set('blocknumber', number);
    });
    me.logic.initLogic(list_length);




    this.logic.on('refocus', function (o, msg) {
      var field = me.lookupReference('barcode');
      field.setValue('');
      field.focus();
    }, this);

    this.logic.on('message', function (o, msg) {
      var field = me.lookupReference('message');
      field.setHtml(msg);
    }, this);

    this.logic.on('reload', function () {
      me.logic.wbliste = [];
      me.logic.wbhash = {};
      me.logic.fireEvent('loaded', me.logic, '', {});
      me.logic.fireEvent('state', me.logic, '');
      me.logic.fireEvent('message', me.logic, 'Scannen Sie einen Berechtigten.');
      var field = me.lookupReference('barcode');
      field.setValue('');
      field.focus();
      me.logic.initLogic(list_length);

    }, this);

    this.logic.on('loaded', function (o, msg, object) {
      console.log('loaded', object);

      me.addContent(object);

      if (me.savedMask) {
        me.savedMask.hide();
      }

    }, this);

    this.logic.on('saved', function (o, msg, object) {
      console.log('saved', object); 
      me.savedMask = Ext.toast({
        html: me.Logic.getSaveText().join(', ') + ' ' + ' um ' + (Ext.util.Format.date(new Date(), 'H:i\'s')),
        title: 'Gespeichert',
        width: 300,
        align: 't',
        autoCloseDelay: 30000
      });
      me.savedMask.show();

      me.view.on('destroy', function () {
        console.log('destroy');
        try {
          /*
          me.Logic.wbliste=[];
          me.Logic.wbhash={};
          me.Logic.fireEvent('loaded', scope, '',{});
          */
          me.savedMask.hide();
        } catch (e) {
        }
      });

      me.view.on('hide', function () {
        console.log('hide');
        try {
          me.savedMask.hide();
        } catch (e) {
        }
      });

      var field = me.lookupReference('barcode');
      field.focus();


    }, this);

    this.logic.on('state', function (o, state) {
      var ampel = false;
      if (me.view.getHeader()) { ampel = me.view.getHeader().getEl(); }

      var basicColor = '#4C9EDE';// ampel.getStyle("background-color");

      if (state == '') {
        ampel && ampel.setStyle("background-color", basicColor);
        me.disableButtons(true);
      }
      if (state == 'ok') {
        ampel && ampel.setStyle("background-color", "green");
        me.disableButtons(false);
      }
      if (state == 'error') {
        ampel && ampel.setStyle("background-color", "red");
        me.disableButtons(true);
        try {
          var audio = new Audio('./papervote/sounds/sms-alert-2-daniel_simon.mp3');
          audio.play();
        } catch (e) { }
      }
      if (state == 'yellow') {
        ampel && ampel.setStyle("background-color", "rgb(255,99,71)");
        me.disableButtons(true);
        try {
          var audio = new Audio('./papervote/sounds/sms-alert-1-daniel_simon.mp3');
          audio.play();
        } catch (e) { }
      }
    }, this);


    me.logic.wbliste = [];
    me.logic.wbhash = {};
    var field = me.lookupReference('barcode');
    field.setValue('');
    field.focus();
  },
  addContent: function (data) {
    var me = this;
    try {
      var ruecklauffelderStore = me.getViewModel().getStore('ruecklauffelder');
      var liste = ruecklauffelderStore.getRange();
      var wzbruecklauffelderStore = me.getViewModel().getStore('wzbruecklauffelder');
      var wzbliste = wzbruecklauffelderStore.getRange();
      console.log('>>>>>>', liste, data, wzbliste, me.logic.wbliste);
      var table = [];
      me.lookupReference('centerlist').getStore().removeAll();
      me.logic.wbliste.forEach(function (wbridx) {
        var dataItem = me.logic.wbhash[wbridx];
        var columns = [];
        var html = '';
        liste.forEach(function (ruecklaufRecord) {
          if (Ext.isEmpty(dataItem[ruecklaufRecord.get('ruecklauffelder__column_name')])) {
            html += '<br/>';
          } else {
            html += '<span>' + dataItem[ruecklaufRecord.get('ruecklauffelder__column_name')] + '</span><br/>';
          }
        });
        columns.push(html);
        html = '';
        console.log('>>>>>>', dataItem);

        dataItem.wahlzeichnungsberechtigter.forEach(function (wbzx) {
          wzbliste.forEach(function (wzbRecord) {
            var k = wzbRecord.get('wzbruecklauffelder__column_name');
            console.log(k);
            k = k.replace('wahlzeichnungsberechtigter__', '');
            console.log(k, wbzx);

            if (typeof wbzx[k] != 'undefined') {
              html += '<span>' + wbzx[k] + '</span><br/>';
            }
          });
          html += '<br>';
        })


        columns.push(html);
        table.push(columns);
      });
      //centerlist
      me.lookupReference('centerlist').getStore().loadData(table);
      me.getViewModel().set('count', me.lookupReference('centerlist').getStore().getCount());
      //me.getView().setTitle('Rücklauf ('++')');

      //me.getViewModel().set('count',me.lookupReference('centerlist').getStore().getCount());
    } catch (e) {
      console.trace(e);
    }
  },
  disableButtons: function (state) {
    var me = this;
    me.ctrls.forEach(function (id) {
      Ext.getCmp(id).setDisabled(state);
    });
  },
  onKeyup: function (t, e, opt) {

    if (e.browserEvent.keyCode == 13 || e.browserEvent.keyCode == 10) {
      e.stopEvent();
      var v = t.getValue().replace(/[^0-9]/g, "");
      // DV Code Trick!
      if ((v.substring(0, 2) == 'FC') || (isNaN(v.substr(2)) === false)) {
        t.el.dom.blur();
        this.logic.transit('einlesen');
      } else {
        t.setValue("");
        t.focus();
      }
    }
  },
  onWahltypLoad: function (store, records) {

  },
  onRuecklauffelderLoad: function (store, records) {

  },
  onWahlscheinstatusLoad: function (store, records) {
    var me = this;
    var buttonDock = me.lookupReference('buttonDock');
    me.ctrls = [];

    buttonDock.removeAll();
    Ext.util.CSS.createStyleSheet('.mbutton span{ color: #fff; font-weight: bold; text-shadow: 0px 0px 1px #000; }');
    records.forEach(function (item) {
      if (item.get('wahlscheinstatus__aktiv') == '1') {
        if (item.get('wahlscheinstatus__barcode') != '') {
          ctrl = Ext.create('Ext.button.Button', {
            text: item.get('wahlscheinstatus__name'),
            handler: me.handleFC(item.get('wahlscheinstatus__barcode'), item.get('wahlscheinstatus__ridx')),
            cls: 'mbutton',
            style: {
              borderRadius: '10px',
              //textShadow: '0px 0px 1px #ffffff',
              //textColor: '#fff',
              //fontWeight: 'bold',
              backgroundColor: item.get('wahlscheinstatus__farbe')
            }
          });
          buttonDock.add(ctrl);
          me.ctrls.push(ctrl.id);
        }
      }
      me.logic.wahlscheinstatusHash[item.get('wahlscheinstatus__ridx')] = item.get('wahlscheinstatus__name');
      me.logic.fireEvent('state', me.logic, ''); // initialy send empty state
      me.logic.fireEvent('message', me.logic, 'Bitte scannen Sie einen Wahlberechtigten'); // initialy send empty state
    });

    buttonDock.add(Ext.create('Ext.toolbar.Fill', {}));
    buttonDock.add(Ext.create('Ext.button.Button', {
      text: 'Leeren',
      handler: me.handleFC('FC208', ''),
      cls: 'mbutton',
      style: {
        borderRadius: '10px',
        /*
        textShadow: '0px 0px 1px #ffffff',
        textColor: '#000',
        fontWeight: 'bold',
        */
        backgroundColor: '#ddd'
      }
    }));
  },
  handleFC: function (fc, ridx) {
    var me = this;
    return function () {
      var field = me.lookupReference('barcode');
      field.setValue(fc);
      me.logic.transit('einlesen');
    }
  }
});