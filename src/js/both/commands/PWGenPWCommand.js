
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

    await me.gatteringData(0);
    await me.loopPWHashRange(0);
    me.saveExcel();
    return true;

  },
  gatteringData: function(){
    let me = this,
      range = me.records,
      index = 0;
    return new Promise((resolve) => {
      loopPWRange(0, resolve);
//      resolve();
    })
  },

  loopPWRange: function (index, cb) {
    let me = this,
        range = me.records,
        progressbar_data = me.getComponent('form').getComponent('progressbar_data');
      
        if (index < range.length) {
          range[index].set('password',me.password[index]);
          range[index].set('wahlscheinnummer',me.wahlschein[index]);
          range[index].set('username',me.username[index]);
          progressbar_data.updateProgress((index + 1) / range.length);

          setTimeout(function () {
            //c onsole.log('setTimeout',index);
            me.loopPWRange(++index, cb);
          }, 1);
        } else {
          cb();
          //me.saveExcel();
        }
        index++;
  },

  /*
  gatteringData: function () {
    let me = this;
    return new Promise((resolve) => {
      me.loopPWRange(0, resolve);
    })
  },

  loopPWRange: function (index, cb) {
    let me = this,
      progressbar_unique = me.getComponent('form').getComponent('progressbar_unique'),
      progressbar_data = me.getComponent('form').getComponent('progressbar_data'),
      progressbar_save = me.getComponent('form').getComponent('progressbar_save'),
      ws = '',
      idx = 0,
      range = me.records;

    console.log(index, range.length);

    if (index < range.length) {



      ws = me.plainPassword(8, me.passwordChars);
      range[index].set('password', ws);

      ws = me.plainPassword(8, me.wahlscheinChars);
      while (typeof me.wahlschein[ws] != 'undefined') {
        ws = me.plainPassword(8, me.wahlscheinChars);
        idx++;
        if (idx > 10000) throw Error('Zu lange');
      }
      range[index].set('wahlscheinnummer', ws);
      me.wahlschein[ws] = ws; idx = 0;

      ws = me.plainPassword(8, me.usernameChars);
      while (typeof me.username[ws] != 'undefined') {
        ws = me.plainPassword(8, me.usernameChars);
        idx++;
        if (idx > 10000) throw Error('Zu lange');
      }
      range[index].set('username', ws);
      me.username[ws] = ws; idx = 0;


      progressbar_data.updateProgress((index + 1) / range.length);

      setTimeout(function () {
        //c onsole.log('setTimeout',index);
        me.loopPWRange(++index, cb);
      }, 1);

    } else {
      cb();
      //me.saveExcel();
    }
  },
  passwordChars: 'ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789',
  usernameChars: 'ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789',
  wahlscheinChars: '1234567890',
  */
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
  loopPWHashRange: async function (index) {
    let me = this,
      block_size = 250,
      progressbar_save = me.getComponent('form').getComponent('progressbar_save')
      ;
    try {
      while (index < me.records.length) {
        progressbar_save.updateProgress((index + 1) / me.records.length);
        let pw_list = me.records.slice(index, index + block_size);
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
        me.records.store.sync();
        index += block_size;
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

    progressbar_save.updateProgress(1);
  },

  loopSaveRange: async function (index) {
    let me = this,
      progressbar_unique = me.getComponent('form').getComponent('progressbar_unique'),
      progressbar_data = me.getComponent('form').getComponent('progressbar_data'),
      progressbar_save = me.getComponent('form').getComponent('progressbar_save'),
      ws = '',
      idx = 0,
      range = me.saving;
    //c onsole.log(index,range.length);

    if (index < range.length) {


      progressbar_save.updateProgress((index + 1) / range.length);
      try {
        let pw_list = range.slice
        let r = await (await fetch('./pwgen/bcrypt', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            password: range[index].password
          })
        })).json();
        range[index].pwhash = r.pwhash;
        me.loopSaveRange(++index);
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
      /*
      Tualo.Ajax.request({
          //showWait: true,
          timeout: 10*60000,
          url: './pwgen/setpw',
          params: range[index],
          json: function(o){
              if (o.success){
                setTimeout(function(){
                  me.loopSaveRange(++index);
              },1);
                
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
      */

    } else {
      me.fireEvent('completed');
    }
  },


  plainPassword: function (length, allowed) {
    var result = '';
    var allowedChars = allowed.split('');
    var min = 0;
    var max = allowedChars.length - 1;
    var cnt = 0;
    while (result.length < length) {
      result += allowedChars[Math.round(Math.random() * (max - min) + min)];
    }
    return result;
  },

  getNextText: function () {
    return 'Erzeugen';
  },

  /*
  buttons: [
    {
      text: 'Schliessen',
      handler: function (btn) {
        btn.up('pwgen_pw_command').fireEvent('cancled');
      }
    },
    {
      text: 'Verarbeiten',
      handler: function (btn) {
        var me = btn.up('pwgen_pw_command');
        me.run(me.list);
      }
    }
  ]*/
});
