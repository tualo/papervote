Ext.define('Tualo.PaperVote.commands.Import', {


    statics:{
        glyph: 'cogs',
        title: 'Importieren',
        tooltip: 'Importieren'
      },
      extend: 'Ext.panel.Panel',
      alias: ['widget.wm_pwgen_importcmd'],
      requires:[
        'Tualo.PaperVote.commands.models.Import',
        'Tualo.PaperVote.commands.controller.Import'
      ],
      controller: 'wm_pwgen_importcmd',
      viewModel: {
          type: 'wm_pwgen_importcmd'
      },
  
      layout: 'fit',
      listeners: {
        boxReady: 'onBoxReady'
      },
      items: [
        {
          xtype: 'panel',
          layout: 'card',
          itemId: 'wizzard',
          bodyPadding: '25px',
          defaults: {
              border: false
          },
          items: [
              {
                  
                  id: 'card-0',
                  xtype: 'panel',
                  itemId: 'uploadCard',
                  layout: {
                      type: 'vbox',
                      pack: 'start',
                      align: 'stretch'
                  },
                  items: [
                    {
                      xtype: 'panel',
                      bind:{
                        html: '<h2>Daten hochladen</h2><p>Schritt 1 von 4</p><p>Bitte wählen Sie eine Datei aus, welche hochgeladen werden soll</p><p>Beachten Sie die Datei darf nicht größer als {uploadSizeText} sein.</p>',
                      }
                    },
                    {
                        xtype: 'form',
                        itemId: 'uploadForm',
                        items: [{
                          xtype: 'filefield',
                          name: 'userfile',
                          fieldLabel: 'Datei',
                          labelWidth: 50,
                          msgTarget: 'side',
                          allowBlank: false,
                          anchor: '100%',
                          buttonText: 'Datei auswählen ...'
                      }],
                    }
                  ]
              },
              {
  
                  id: 'card-1',
                  xtype: 'panel',
                  itemId: 'analyseCard',
                  layout: {
                      type: 'vbox',
                      pack: 'start',
                      align: 'stretch'
                  },
  
                  items: [
                    {
                      xtype: 'panel',
                      bind:{
                        html: '<h2>Tabellenprüfen</h2><p>Schritt 2 von 4</p><p>Die Tabellenblätter werden nun geprüft. Dies kann je nach Größe einige Zeit in Anspruch nehmen.</p>'
                      }
                    },
                    {
                      xtype: 'panel',
                      itemId: 'analyseCardF1',
                      layout: {
                        type: 'vbox',
                        align: 'center',
                        pack: 'center'
                      },
                      items: [
                        {
                          xtype: 'panel',
                          bind:{
                            html: 'Tabellenblatt: {sheetname}'
                          }
                        },
                        {
                          xtype: 'progressbar',
                          itemId: 'analyseCardSheetProgress',
                          width: 300
                        }
                      ]
                    },
                    {
                      xtype: 'panel',
                      itemId: 'analyseCardF2',
                      layout: {
                        type: 'vbox',
                        align: 'center',
                        pack: 'center'
                      },
                      items: [
                        {
                          xtype: 'panel',
                          bind:{
                            html: 'Spalten: {columnname}'
                          }
                        },
                        {
                          xtype: 'progressbar',
                          itemId: 'analyseCardColumnProgress',
                          width: 300
                        }
                      ]
                    }
                  ]
  
              },
  
  
  
              {
  
                id: 'card-2',
                xtype: 'panel',
                itemId: 'columnsCard',
                layout: {
                    type: 'vbox',
                    pack: 'start',
                    align: 'stretch'
                },
  
                items: [
                  {
                    xtype: 'panel',
                    bind:{
                      html: '<h2>Tabellenprüfen</h2><p>Schritt 3 von 4</p><p>Spaltenzuweisung</p>'
                    }
                  },
                  {
                    xtype: 'panel',
                    itemId: 'columnsGridPanel',
                    layout: 'fit',
                    height: 400,
                    items: [
                      {
                        xtype: 'grid',
                        itemId: 'columnsGrid',
                        height: 400,
                        store: {
                          type: 'json',
                          autoLoad: true,
                          proxy: {
                            type: 'ajax',
                            url: './pwgen/ds',
                            reader: {
                                type: 'json',
                                rootProperty: 'data'
                            }
                          },
                          fields: [ 
                            {name: 'excel_column', type: 'string'}, 
                            {name: 'excel_header', type: 'string'}, 
                            {name: 'data_type', type: 'string'}, 
                            {name: 'is_new', type: 'boolean'}, 
                            {name: 'column_name', type: 'string'}, 
                            {name: 'contains_null', type: 'boolean'}, 
                            {name: 'unique', type: 'boolean'}, 
                            {name: 'variation_count', type: 'number'}, 
                            {name: 'length', type: 'number'}, 
                            {name: 'fktable', type: 'boolean', default: true}
                          ]
                        },
                        columns: [
                          {
                            dataIndex: 'excel_column',
                            header: 'Excel-Spalte'
                          },
                          {
                            dataIndex: 'excel_header',
                            header: 'Excel-Überschrift'
                          },
                          {
                            dataIndex: 'data_type',
                            header: 'Datentyp'
                          },
                          {
                            dataIndex: 'is_new',
                            header: 'ist Neu'
                          },
                          {
                            dataIndex: 'column_name',
                            header: 'Tabellen-Spalte'
                          },
                          {
                            dataIndex: 'contains_null',
                            header: 'Enthält Null'
                          },
                          {
                            dataIndex: 'unique',
                            header: 'Eineindeutig'
                          },
                          {
                            dataIndex: 'variation_count',
                            xtype: 'numbercolumn',
                            header: 'Variationen'
                          },
                          {
                            dataIndex: 'length',
                            xtype: 'numbercolumn',
                            header: 'Zeichen'
                          },
                          {
                            dataIndex: 'fktable',
                            xtype: 'checkcolumn',
                            header: 'Referenztabelle'
                          }
                        ]
                      }
                    ]
                  }
                ]
              },
              {
  
                id: 'card-2',
                xtype: 'panel',
                itemId: 'importCard',
                layout: {
                    type: 'vbox',
                    pack: 'start',
                    align: 'stretch'
                },
  
                items: [
                  {
                    xtype: 'panel',
                    bind:{
                      html: '<h2>Tabellenprüfen</h2><p>Schritt 4 von 4</p><p>Import</p>'
                    }
                  },
                    {
                        xtype: 'progressbar',
                        itemId: 'importCardColumnProgress',
                        width: 300
                    }
                ]
              },
              {
                  id: 'card-4',
                  html: '<h1>Congratulations!</h1><p>Step 3 of 3 - Complete</p>'
              }
          ],
          
          bbar: ['->',
                {
                    itemId: 'card-prev',
                    text: '&laquo; Zurück',
                    handler: 'showPrevious',
                    /*
                    bind: {
                      disabled: '{prevDisabled}'
                    },
                    */
                    disabled: true
                },
                {
                    itemId: 'card-next',
                    text: 'Weiter &raquo;',
                    bind: {
                      disabled: '{nextDisabled}'
                    },
                    handler: 'showNext'
                }
          ],
  
          
      
  
  
        }
      ],
      loadRecord: function(record,records,selectedrecords){
        this.record = record;
        this.records = records;
        this.selectedrecords = selectedrecords;
    
      },
      /*
      buttons: [
        {
          text: 'Schliessen',
          handler: function(btn){
            btn.up('cmp_pwgen_import_command').fireEvent('cancled');
          }
        },
        {
          text: 'Importieren',
          handler: function(btn){
            /*
            var me = btn.up('cmp_pwgen_import_command'),
            vals = btn.up('cmp_pwgen_import_command').getComponent('syncform').getForm().getValues();
            Tualo.Ajax.request({
              showWait: true,
              url: './dssetup/rmcache',
              scope: this,
              json: function(o){
                btn.up('ds_rmcache_command').fireEvent('cancled');
              }
            })
            * /
          }
        }
      ]
      */
      
  });
