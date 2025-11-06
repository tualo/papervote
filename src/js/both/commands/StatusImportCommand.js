Ext.define('Tualo.PaperVote.commands.StatusImportCommand', {
  statics: {
    glyph: 'cogs',
    title: 'Verarbeiten',
    tooltip: 'Verarbeiten'
  },
  extend: 'Ext.panel.Panel',
  alias: ['widget.wm_wb_importstatuscmd', 'widget.cmp_wm_ruecklauf_import_command'],
  requires: [
  ],

  layout: 'fit',
  items: [
    {
      xtype: 'form',
      itemId: 'form',
      bodyPadding: '25px',
      items: [
        {
          xtype: 'label',
          text: 'Importe verarbeiten.',
        }, {
          itemId: 'progress',
          xtype: 'progressbar',
          text: 'Verarbeitung ...'
        }
      ]
    }
  ],
  loadRecord: function (record, records, selectedrecords) {
    this.record = record;
    this.records = records;
    this.selectedrecords = selectedrecords;
    let me = this;
  },

  getNextText: function () {
    return 'Erzeugen';
  },
  run: async function () {
    let url = './papervote/involvement/wmstatusimport';
    let o = await (await fetch(url, {
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    })).json()
    if (o.success) {
      //me.fireEvent('completed');
    } else {
      Ext.toast({
        html: o.msg,
        title: 'Fehler',
        width: 400,
        align: 't',
        iconCls: 'fa fa-warning'
      });
    }
    return null;
  }
  /*
    buttons: [
      {
        text: 'Schliessen',
        handler: function(btn){
          btn.up('cmp_wm_ruecklauf_import_command').fireEvent('cancled');
        }
      },
      {
        text: 'Verarbeiten',
        handler: function(btn){
          var me = btn.up('cmp_wm_ruecklauf_import_command');
          me.run(me.list);
        }
      }
    ]
    */
});
