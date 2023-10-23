Ext.define('Tualo.PaperVote.commands.BarcodeImages', {
    statics: {
      glyph: 'magic',
      title: 'Barcodebilder',
      tooltip: 'Barcodebilder'
    },
    extend: 'Ext.panel.Panel',
    alias: 'widget.papervote_barcode_command',
    layout: 'fit',
    items: [
      {
        xtype: 'form',
        itemId: 'ds_batch_commandform',
        bodyPadding: '25px',
        items: [
          {
            xtype: 'label',
            text: 'Durch Klicken auf *Erzeugen* werden alle Barcodebilder neu erzeugt.',
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
      return 'Erzeugen';
    },
    run: async function () {
        let url = './images/createbarcodeimages';
        let o = await (await fetch(url)).json()
      return null;
    }
  });
  