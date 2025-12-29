Ext.define('Tualo.PaperVote.lazy.involvement.controller.Viewport', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.cmp_wm_beteiligung_viewport',
  onWahlbeteiligungBerichtLoad: function (store, records) {
    this.getViewModel().getStore('wahlbeteiligung_bericht_formel').load();
  },
  onWahlbeteiligungBerichtFormelLoad: function (store, records) {
    this.getViewModel().getStore('wahlbeteiligung_bericht_abgabetyp').load();
  },
  onWahlbeteiligungBerichtAbgabetypLoad: function (store, records) {
    this.getViewModel().getStore('abgabetyp').load();
  },
  onAbgabetypLoad: function (store, records) {
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

        me.getViewModel().set('typ', record.get('id'));
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
        typ: this.getViewModel().get('typ'),
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
      dataIndex: 'use_name',
      flex: 1,
      sortable: true
    });
    fields.push({ name: 'use_name', type: 'string' });


    var wahlbeteiligung_bericht = this.getViewModel().getStore('wahlbeteiligung_bericht').getRange();
    var wahlbeteiligung_bericht_formel = this.getViewModel().getStore('wahlbeteiligung_bericht_formel').getRange();
    var wahlbeteiligung_bericht_abgabetyp = this.getViewModel().getStore('wahlbeteiligung_bericht_abgabetyp').getRange();
    var abgabetyp = this.getViewModel().getStore('abgabetyp')
    var ohne_wahlberechtigten = this.getViewModel().getStore('ohne_wahlberechtigten').getRange();


    wahlbeteiligung_bericht.forEach(function (record) {
      if (record.get('aktiv') == 1) {
        var dataIndex = 'wb_' + record.get('id');//.replace('|','_');
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

        wahlbeteiligung_bericht_abgabetyp.forEach(function (abgabetyp_record) {
          if (
            (abgabetyp_record.get('aktiv') == true) &&
            (abgabetyp_record.get('bericht_id') == record.get('id'))
          ) {
            var dataIndex = 'wb_' + abgabetyp_record.get('bericht_id') + '_' + abgabetyp_record.get('abgabetyp');//.replace('|','_');

            // findRecord ( fieldName, value, [startIndex], [anyMatch], [caseSensitive], [exactMatch] )
            var r = abgabetyp.findRecord('id', abgabetyp_record.get('abgabetyp'), 0, false, false, true);

            var headerName = record.get('name') + ' (' + r.get('name') + ')';

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
      }
    });



    wahlbeteiligung_bericht_formel.forEach(function (record) {
      if (record.get('aktiv') == 1) {

        var dataIndex = 'f' + record.get('id');//.replace('|','_');
        var headerName = record.get('name');

        var nenner = JSON.parse(record.get('nenner'));
        var teiler = JSON.parse(record.get('teiler'));

        columns.push({
          header: headerName,
          dataIndex: dataIndex,
          sortable: true,
          xtype: 'numbercolumn',
          format: '0.000',
          align: 'right' //,
          //summaryRenderer: Ext.util.Format.numberRenderer('0.000')
        });

        var fn = (nenner, teiler) => {
          return function (data) {
            var nenner_summe = 0;
            var teiler_summe = 0;
            var result = 0;

            nenner.forEach(function (n) {
              if (n != null && n.id && data['wb_' + n.id]) {
                nenner_summe += data['wb_' + n.id];
              }
            });

            teiler.forEach(function (t) {
              if (t != null && t.id && data['wb_' + t.id]) {
                teiler_summe += data['wb_' + t.id];
              }
            });

            if (nenner_summe && teiler_summe) {
              result = nenner_summe / teiler_summe;
            }
            return result * 100; // Return percentage
          }
        }
        fields.push({
          name: dataIndex, type: 'float',
          calculate: fn(nenner, teiler)
        });
      }
    });

    //console.log(this.getViewModel().get('abgabetyp'));

    var store = Ext.create('Ext.data.Store', {
      fields: fields,
      pageSize: 500,
      proxy: {
        type: 'ajax',
        url: './papervote/involvement/reporting',

        extraParams: {
          typ: this.getViewModel().get('typ'),
          base: this.getViewModel().get('base'),//request.base,
          //abgabetyp: this.getViewModel().get('abgabetyp'),//request.base,
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
