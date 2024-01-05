Ext.define('Tualo.PaperVote.commands.StatusImportCommand', {
    statics:{
      glyph: 'cogs',
      title: 'Verarbeiten',
      tooltip: 'Verarbeiten'
    },
    extend: 'Ext.panel.Panel',
    alias: ['widget.wm_wb_importcmd','widget.cmp_wm_ruecklauf_import_command'],
    requires:[
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
            },{
              itemId: 'progress',
              xtype: 'progressbar',
              text: 'Verarbeitung ...'
            }
          ]
        }
      ],
      loadRecord: function(record,records,selectedrecords){
        this.record = record;
        this.records = records;
        this.selectedrecords = selectedrecords;
        let me = this;
      },
      run: function(list){
    
        let me = this;
    
          Tualo.Ajax.request({
            showWait: true,
            timeout: 10*60000,
            url: './cmp_wm_ruecklauf/wmstatusimport',
            params: {
              
            },
            json: function(o){
              if (o.success){
                me.fireEvent('completed');
              }else{
                Ext.toast({
                  html: o.msg,
                  title: 'Fehler',
                  width: 400,
                  align: 't',
                  iconCls: 'fa fa-warning'
               });
              }
            }
          });
    
    
    
      },
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
  });
  