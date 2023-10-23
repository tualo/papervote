Ext.define('Tualo.PaperVote.commands.Export', {
    statics: {
      glyph: 'magic',
      title: 'Export',
      tooltip: 'Export'
    },
    extend: 'Ext.panel.Panel',
    alias: 'widget.papervote_export_command',
    layout: 'fit',
    items: [
      {
        xtype: 'form',
        itemId: 'ds_batch_commandform',
        bodyPadding: '25px',
        items: [
          {
            xtype: 'label',
            text: 'Durch Klicken auf *Abrufen* wir eine ZIP aller Daten erstellt.',
          }
        ]
      }
    ],
    loadRecord: function (record, records, selectedrecords, view) {
      this.record = record;
      this.records = records;
      this.selectedrecords = selectedrecords;
      this.view = view;
      console.log('loadRecord', arguments);
    },
    getNextText: function () {
      return 'Abrufen';
    },
    run: async function () {
        let config = {
            url: './papervote/export/all',
            scope: this,
            showWait: true,
            timeout: 300000
        };
        Tualo.Ajax.download(config);
      return null;
    }
  });
  