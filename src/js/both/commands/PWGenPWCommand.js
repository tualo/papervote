
Ext.define('Tualo.PaperVote.commands.WMPWGenPWCommand', {
  statics: {
    glyph: 'cogs',
    title: 'Daten generieren',
    tooltip: 'Daten generieren'
  },
  extend: 'Ext.panel.Panel',
  alias: ['widget.pwgen_pw_command'],
  requires: [
    'Ext.exporter.excel.Xlsx',
    'Ext.grid.plugin.Exporter'
  ],
  plugins: {
    gridexporter: true
  },
  layout: 'fit',
  items: [
    {
      xtype: 'form',
      itemId: 'form',
      bodyPadding: '25px',
      items: [
        {
          xtype: 'label',
          text: 'Unique-Daten ermitteln.',
        }, {
          xtype: 'progressbar',
          itemId: 'progressbar_unique',
          disabled: true,
          text: ' '
        },
        {
          xtype: 'label',
          text: 'Daten erzeugen.',
        }, {
          xtype: 'progressbar',
          itemId: 'progressbar_data',
          disabled: true,
          text: ' '
        },
        {
          xtype: 'label',
          text: 'Hashes erzeugen.',
        }, {
          xtype: 'progressbar',
          itemId: 'progressbar_save',
          disabled: true,
          text: ' '
        }
      ]
    }
  ],
  loadRecord: function (record, records, selectedrecords, parent) {
    this.record = record;
    this.records = records;

    this.list = Ext.getCmp(this.calleeId).getComponent('list')
    this.store = this.list.getStore();
    this.selectedrecords = selectedrecords;
    let me = this;

  },


  run: async function (list) {
    let me = this,
      progressbar_unique = me.getComponent('form').getComponent('progressbar_unique'),
      progressbar_data = me.getComponent('form').getComponent('progressbar_data'),
      progressbar_save = me.getComponent('form').getComponent('progressbar_save'),
      range = me.records;

    progressbar_unique.wait({
      interval: 500, //bar will move fast!
      duration: 150000,
      increment: 15,
      text: 'Updating...',
      scope: this,
      fn: function () {
      }
    });

    let o = await (await fetch('./pwgen/new_unique')).json();
    console.log(o);
    progressbar_unique.reset();
    progressbar_unique.updateProgress(1);
    progressbar_unique.updateText(' ');
    me.wahlschein = o.wahlschein;
    me.username = o.username;
    me.password = o.password;
    me.current = 0;
    me.blocksize = 250;
    await me.loopPWRange();
    
    
    return true;

  },
  

  loopPWRange: async function () {
    let me = this,
        range = me.records,
        i=0,
        progressbar_data = me.getComponent('form').getComponent('progressbar_data');
      
        if (me.current < range.length) {
          range[0].store.suspendEvents(true);
          while(i<me.blocksize && me.current < range.length){
            range[me.current].set('password',me.password[me.current].val);
            range[me.current].set('wahlscheinnummer',me.wahlschein[me.current].val);
            range[me.current].set('username',me.username[me.current].val);
            me.current++;
            i++;
          }

          range[0].store.resumeEvents();
          progressbar_data.updateProgress((me.current + 1) / range.length);

          await me.loopPWHashRange();
          await me.loopPWRange();
        } else {
        }
  },

  loopPWHashRange: async function () {
    let me = this,
      block_size = 250,
      progressbar_save = me.getComponent('form').getComponent('progressbar_save')
      ;
    try {
      while (me.current < me.records.length) {
        progressbar_save.updateProgress((me.current + 1) / me.records.length);
        let pw_list = me.store.getModifiedRecords();;
        let pws_list = pw_list.map((item) => {
          return {
            id: item.get('__id'),
            password: item.get('password')
          }
        });

        let r = await (await fetch('./pwgen/bcrypt', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            passwords: pws_list
          })
        })).json();
        
        r.data.forEach((item) => {
          let rec = me.store.findRecord('__id', item.id);
          rec.set('pwhash', item.pwhash);
          rec.set('wahlscheinstatus', '1|0');

        });

        await me.singleSync();
      }
    } catch (e) {
      console.log(e);
      Ext.toast({
        html: "Es ist ein Fehler aufgetreten: ",
        title: 'Fehler',
        width: 400,
        align: 't',
        iconCls: 'fa fa-warning'
      });
    }

    //progressbar_save.updateProgress(1);
  },

  saveExcel: function () {
    let me = this;


    let btncfg = {
      type: 'excel07',
      ext: 'xlsx',
      includeGroups: true,
      includeSummary: true
    };

    var cfg = Ext.merge({
      title: 'PWGen Datenexport',
      fileName: 'Datenexport' + '.' + (btncfg.ext || btncfg.type)
    }, btncfg);
    me.list.saveDocumentAs(cfg);



  },

  singleSync: function(){
    let me = this;
    return new Promise((resolve) => {
      me.store.sync({
        callback: resolve
      });
    })
  },

  getNextText: function () {
    return 'Erzeugen';
  },


});
