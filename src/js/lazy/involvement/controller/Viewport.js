Ext.define('Tualo.PaperVote.lazy.involvement.controller.Viewport', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.cmp_wm_beteiligung_viewport',
  onWahlbeteiligungBerichtLoad: function (store, records) {
    this.getViewModel().getStore('wahlbeteiligung_bericht_formel').load();
  },
  onWahlbeteiligungBerichtFormelLoad: function (store, records) {
    this.getViewModel().getStore('ohne_wahlberechtigten').load();
  },
  onOhneWahlberechtigtenlLoad: function (store, records) {
    console.log(records);
    this.createGrid();
  },
  onWahltypLoad: function (store, records) {
    var me = this,
      view = this.getView(),
      typ = (view.typ) ? view.typ : 1;

    records.forEach(function (record) {
      if (typ == record.get('id')) {

        me.getViewModel().set('ridx', record.get('ridx'));
        me.getViewModel().set('typ_name', record.get('name'));
        me.getViewModel().set('disabled', false);


        me.getViewModel().getStore('wahlbeteiligung_bericht').load({
          params: {
            filters: "[{\"aktiv\":\"1\"}]"
          }
        });
      }
    });

  },
  onBoxReady: function () {
    let me = this,
      view = me.getView(),
      abgabetyp = (view.abgabetyp) ? view.abgabetyp : null,
      testdaten = (view.testdaten) ? view.testdaten : null,
      base = (view.base) ? view.base : null
      ;
    me.getViewModel().getStore('wahltyp').load();
    if (base) this.getViewModel().set('base', base);
    if (abgabetyp) this.getViewModel().set('abgabetyp', abgabetyp);
    if (testdaten) this.getViewModel().set('testdaten', testdaten);

  },
  onFlatFileClick: function () {

    let config = {
      url: './ds/wahlschein_flatfile/export',
      scope: this,
      showWait: true,
      timeout: 300000,
      params: {
        limit: 10000000,
      }
    };
    Tualo.Ajax.download(config);
    /*
        Ext.MessageBox.wait('Bitte warten...','Bericht wird erstellt');
        console.log('timeout',600000);
        Ext.Ajax.request({
            url: './index.php',
            timeout: 600000,
            params: {
              typ: this.getViewModel().get('ridx'),
              base: this.getViewModel().get('base'),//request.base,
              abgabetyp: this.getViewModel().get('abgabetyp'),//request.base,
              testdaten: this.getViewModel().get('testdaten'),//request.base,
              join_fld: '',//request.join_fld,
              p: 'ajax/flatfile'
            },
            success: function(f, a){
                Ext.MessageBox.hide();
                var o = Ext.JSON.decode(f.responseText);
                if (o.data.file != '') {
                    Ext.tualo.window.DownloadManager.notify_download(o.file);
                }else{
                    Ext.MessageBox.alert('Fehler','Die R&uuml;ckgabe war fehlerhaft.');
                }
            },
            failure: function(f){
                Ext.MessageBox.hide();
                Ext.MessageBox.alert('Fehler '+f.responseText);
            }
        });
        */
  },
  onCodePDFClick: function () {
    /*
      window.open('./index.php?'+'sid='+sid+'&p=ajax/statuscodes&cmp=cmp_wm_ruecklauf&TEMPLATE=NO');
      if (false){
          Ext.MessageBox.wait('Bitte warten...','Bericht wird erstellt');
          Ext.Ajax.request({
              url: './index.php',
              params: {
                  TEMPLATE: 'NO',
                  sid: sid,

                  cmp: 'cmp_wm_ruecklauf',
                  p: 'ajax/statuscodes'
              },
              timeout: 90000,
              success: function(f, a){
                  Ext.MessageBox.hide();
                  var o = Ext.JSON.decode(f.responseText);
                  if (o.data.file != '') {
                    Ext.tualo.window.DownloadManager.notify_download(o.data.file);
                  }else{
                      Ext.MessageBox.alert('Fehler','Die R&uuml;ckgabe war fehlerhaft.');
                  }
              },
              failure: function(f){
                  Ext.MessageBox.hide();
                  Ext.MessageBox.alert('Fehler '+f.responseText);
              }
          });
      }
    */
  },
  onOhneWBClick: function () {
    var me = this;
    var window = Ext.create("Ext.tualo.Window", {
      title: "Eingabe Wahlbeteiligung ohne Zuordnung von Berechtigten",
      layout: 'fit',
      items: [Ext.create('Tualo.PaperVote.lazy.users.ManualGrid', {
        component: 'cmp_wm_beteiligung',
        ohne_wahlberechtigten: this.getViewModel().getStore('ohne_wahlberechtigten').getRange()
      })],
      buttons: [
        {
          text: 'Abbrechen',
          handler: function (btn) {
            btn.up().up().close();
          }
        }
      ],
      listeners: {
        scope: me,
        close: function () {
          var me = this;
          me.grid.store.load();
        }
      }
    });
    window.resizeMe();
    window.show();

  },
  onExcelClick: function () {

    let config = {
      url: './papervote/involvement/reporting/export',
      scope: this,
      showWait: true,
      timeout: 300000,
      params: {
        limit: 10000000,
        typ: this.getViewModel().get('ridx'),
        base: this.getViewModel().get('base'),//request.base,
        abgabetyp: this.getViewModel().get('abgabetyp'),//request.base,
        testdaten: this.getViewModel().get('testdaten'),//request.base,

      }
    };

    Tualo.Ajax.download(config);

  },
  createGrid: function () {
    var fields = new Array();
    var columns = new Array();
    columns.push({
      header: 'Stimmzettel',
      dataIndex: 'stimmzettel_name',
      flex: 1,
      sortable: true
    });
    fields.push({ name: 'stimmzettel', type: 'string' });


    var wahlbeteiligung_bericht = this.getViewModel().getStore('wahlbeteiligung_bericht').getRange();
    var wahlbeteiligung_bericht_formel = this.getViewModel().getStore('wahlbeteiligung_bericht_formel').getRange();
    var ohne_wahlberechtigten = this.getViewModel().getStore('ohne_wahlberechtigten').getRange();


    wahlbeteiligung_bericht.forEach(function (record) {
      if (record.get('aktiv') == 1) {
        var dataIndex = 'b' + record.get('id');//.replace('|','_');
        var headerName = record.get('name');

        columns.push({
          header: headerName,
          dataIndex: dataIndex,
          sortable: true,
          xtype: 'numbercolumn',
          flex: 1,
          format: '0,000',
          align: 'right',
          summaryType: 'sum',
          summaryRenderer: Ext.util.Format.numberRenderer('0,000')
        });
        fields.push({ name: dataIndex, type: 'int' });
      }
    });



    wahlbeteiligung_bericht_formel.forEach(function (record) {
      if (record.get('aktiv') == 1) {

        var dataIndex = 'f' + record.get('id');//.replace('|','_');
        var headerName = record.get('name');

        columns.push({
          header: headerName,
          dataIndex: dataIndex,
          sortable: true,
          xtype: 'numbercolumn',
          format: '0.000',
          align: 'right' //,
          //summaryRenderer: Ext.util.Format.numberRenderer('0.000')
        });
        fields.push({ name: dataIndex, type: 'float' });
      }
    });

    var store = Ext.create('Ext.data.Store', {
      fields: fields,
      pageSize: 500,
      proxy: {
        type: 'ajax',
        url: './papervote/involvement/reporting',

        extraParams: {
          typ: this.getViewModel().get('ridx'),
          base: this.getViewModel().get('base'),//request.base,
          abgabetyp: this.getViewModel().get('abgabetyp'),//request.base,
          testdaten: this.getViewModel().get('testdaten'),//request.base,
        },
        reader: {
          type: 'json',
          root: 'data'
        }
      }
    });
    store.load();

    this.grid = Ext.create('Ext.grid.Panel', {
      store: store,
      columns: columns,
      dockedItems: [
        {
          dock: 'bottom',
          xtype: 'pagingtoolbar',
          displayInfo: true
        }
      ]
    });
    this.view.add(this.grid);
  }
});

//WVD_DM_16_022
