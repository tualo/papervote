Ext.define('Tualo.PaperVote.commands.ExportByTable', {
    statics: {
        glyph: 'file-archive',
        title: 'Export by Table',
        tooltip: 'Export by Table'
    },
    extend: 'Ext.panel.Panel',
    alias: 'widget.papervote_export_table_command',
    layout: 'fit',
    items: [
        {
            xtype: 'form',
            itemId: 'ds_batch_commandform',
            bodyPadding: '25px',
            items: [
                {
                    xtype: 'label',
                    text: 'Durch Klicken auf *Abrufen* wird eine ZIP aller Daten der ausgewählten Tabelle erstellt.',
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
            url: './papervote/export/' + this.record.get('__table_name'),
            scope: this,
            showWait: true,
            timeout: 300000
        };
        Tualo.Ajax.download(config);
        return null;
    }
});
