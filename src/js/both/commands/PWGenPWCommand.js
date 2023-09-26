
Ext.define('Tualo.PaperVote.commands.WMPWGenPWCommand', {
    statics:{
      glyph: 'cogs',
      title: 'Daten generieren',
      tooltip: 'Daten generieren'
    },
    extend: 'Ext.panel.Panel',
    alias: ['widget.pwgen_pw_command'],
    requires:[
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
            },{
              xtype: 'progressbar',
              itemId: 'progressbar_unique',
              disabled: true,
              text: 'Verarbeitung läuft ...'
            },
            {
                xtype: 'label',
                text: 'Daten erzeugen.',
            },{
            xtype: 'progressbar',
            itemId: 'progressbar_data',
            disabled: true,
            text: 'Verarbeitung läuft...'
            },
            {
                xtype: 'label',
                text: 'Daten speichern.',
            },{
            xtype: 'progressbar',
            itemId: 'progressbar_save',
            disabled: true,
            text: 'Speicherung läuft...'
            }
          ]
        }
      ],
      loadRecord: function(record,records,selectedrecords,parent){
        this.record = record;
        this.records = records;

        this.list = Ext.getCmp(this.calleeId).getComponent('list')
        
        this.selectedrecords = selectedrecords;
        let me = this;
      },
      run: function(list){
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
            fn: function(){
            }
        });
        Tualo.Ajax.request({
            showWait: true,
            timeout: 10*60000,
            url: './pwgen/unique',
            params: {
              
            },
            json: function(o){
                if (o.success){
                  //me.fireEvent('completed');
                  progressbar_unique.reset();
                  progressbar_unique.updateProgress(1);
                  progressbar_unique.updateText('Done!');
                  me.wahlschein=o.wahlschein;
                  me.username=o.username;
                  setTimeout(function(){
                      me.saving=[];
                    me.loopPWRange(0);
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
    
    
    
      },
      loopPWRange: function(index){
        let me = this,
        progressbar_unique = me.getComponent('form').getComponent('progressbar_unique'),
        progressbar_data = me.getComponent('form').getComponent('progressbar_data'),
        progressbar_save = me.getComponent('form').getComponent('progressbar_save'),
        ws='',
        idx=0,
        range = me.records;
        //c onsole.log(index,range.length);

        if (index<range.length){



          //if(range[index].get('password')!=null){
            ws = me.plainPassword(8,me.passwordChars);
            range[index].set('password',ws);
          //}
          //if(range[index].get('wahlscheinnummer')!=null){
            ws = me.plainPassword(8,me.wahlscheinChars);
            while(typeof me.wahlschein[ws]!='undefined'){
                ws = me.plainPassword(8,me.wahlscheinChars);
                idx++;
                if(idx>10000) throw Error('Zu lange');
            }
            range[index].set('wahlscheinnummer',ws);
            me.wahlschein[ws]=ws; idx=0;
          //}

          //if(range[index].get('username')!=null){
            ws = me.plainPassword(8,me.usernameChars);
            while(typeof me.username[ws]!='undefined'){
                ws = me.plainPassword(8,me.usernameChars);
                idx++;
                if(idx>10000) throw Error('Zu lange');
            }
            range[index].set('username',ws);
            me.username[ws]=ws; idx=0;
          //}
          /*
          co nsole.log({
            prefix: '',
            password: range[index].get('password'),
            username: range[index].get('username'),
            id: range[index].get('id'),
            wahlscheinnummer: range[index].get('wahlscheinnummer')
          })
          */

          me.saving.push({
            prefix: '',
            password: range[index].get('password'),
            username: range[index].get('username'),
            identnummer: range[index].get('identnummer'),
            stimmzettel: range[index].get('stimmzettel'),
            wahlscheinnummer: range[index].get('wahlscheinnummer')
          });

          /*

            // USERNAME
            if(range[index].get('view_pwgen_new_documents__vv')!=null){
                ws = me.plainPassword(8,me.wahlscheinChars);
                while(typeof me.wahlschein[ws]!='undefined'){
                    ws = me.plainPassword(8,me.wahlscheinChars);
                    idx++;
                    if(idx>10000) throw Error('Zu lange');
                }
                range[index].set('view_pwgen_new_documents__vv_wahlscheinnummer',ws);
                me.wahlschein[ws]=ws; idx=0;
            }

            if(range[index].get('view_pwgen_new_documents__ra')!=null){
                ws = me.plainPassword(8,me.wahlscheinChars);
                while(typeof me.wahlschein[ws]!='undefined'){
                    ws = me.plainPassword(8,me.wahlscheinChars);
                    idx++;
                    if(idx>10000) throw Error('Zu lange');
                }
                range[index].set('view_pwgen_new_documents__ra_wahlscheinnummer',ws);
                me.wahlschein[ws]=ws; idx=0;
            }

            // USERNAME
            if(range[index].get('view_pwgen_new_documents__vv')!=null){
                ws = me.plainPassword(8,me.usernameChars);
                while(typeof me.username[ws]!='undefined'){
                    ws = me.plainPassword(8,me.usernameChars);
                    idx++;
                    if(idx>10000) throw Error('Zu lange');
                }
                range[index].set('view_pwgen_new_documents__vv_username',ws);
                me.username[ws]=ws; idx=0;
            }

            if(range[index].get('view_pwgen_new_documents__ra')!=null){
                ws = me.plainPassword(8,me.usernameChars);
                while(typeof me.wahlschein[ws]!='undefined'){
                    ws = me.plainPassword(8,me.usernameChars);
                    idx++;
                    if(idx>10000) throw Error('Zu lange');
                }
                range[index].set('view_pwgen_new_documents__ra_username',ws);
                me.username[ws]=ws; idx=0;
            }

            

            // Passwords
            if(range[index].get('view_pwgen_new_documents__ra')!=null){
                ws = me.plainPassword(8,me.passwordChars);
                range[index].set('view_pwgen_new_documents__ra_password',ws);
            }

            if(range[index].get('view_pwgen_new_documents__vv')!=null){
                ws = me.plainPassword(8,me.passwordChars);
                range[index].set('view_pwgen_new_documents__vv_password',ws);
            }
            
            if(range[index].get('view_pwgen_new_documents__vv')!=null){
                me.saving.push({
                    prefix: 'vv',
                    password: range[index].get('view_pwgen_new_documents__vv_password'),
                    username: range[index].get('view_pwgen_new_documents__vv_username'),
                    id: range[index].get('view_pwgen_new_documents__vv_id'),
                    wahlscheinnummer: range[index].get('view_pwgen_new_documents__vv_wahlscheinnummer')
                });
            }
            if(range[index].get('view_pwgen_new_documents__ra')!=null){
                me.saving.push({
                    prefix: 'ra',
                    password: range[index].get('view_pwgen_new_documents__ra_password'),
                    username: range[index].get('view_pwgen_new_documents__ra_username'),
                    id: range[index].get('view_pwgen_new_documents__ra_id'),
                    wahlscheinnummer: range[index].get('view_pwgen_new_documents__ra_wahlscheinnummer')
                });
            }

            c onsole.log('range',index,range[index]);
            */

            progressbar_data.updateProgress((index+1)/range.length);
            
            setTimeout(function(){
                //c onsole.log('setTimeout',index);
                me.loopPWRange(++index);
            },1);
        }else{
            me.saveExcel();
        }
      },
      passwordChars: 'ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789',
      usernameChars: 'ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789',
      wahlscheinChars: '1234567890',

      saveExcel: function(){
        let me = this,
        progressbar_unique = me.getComponent('form').getComponent('progressbar_unique'),
        progressbar_data = me.getComponent('form').getComponent('progressbar_data'),
        progressbar_save = me.getComponent('form').getComponent('progressbar_save'),
        ws='',
        idx=0,
        range = me.records;
        //c onsole.log('saveExcel');
        

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
        me.loopSaveRange(0);


      },

      loopSaveRange: function(index){
        let me = this,
        progressbar_unique = me.getComponent('form').getComponent('progressbar_unique'),
        progressbar_data = me.getComponent('form').getComponent('progressbar_data'),
        progressbar_save = me.getComponent('form').getComponent('progressbar_save'),
        ws='',
        idx=0,
        range = me.saving;
        //c onsole.log(index,range.length);

        if (index<range.length){
            

            progressbar_save.updateProgress((index+1)/range.length);
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

            
        }else{
            me.fireEvent('completed');
        }
      },


      plainPassword: function(length,allowed){
        var result='';
        var allowedChars = allowed.split('');
        var min = 0;
        var max = allowedChars.length-1;
        var cnt = 0;
        while(result.length<length){
          result+= allowedChars[Math.round(Math.random() * (max - min) + min)];
        }
        return result;
      },
      

      buttons: [
        {
          text: 'Schliessen',
          handler: function(btn){
            btn.up('pwgen_pw_command').fireEvent('cancled');
          }
        },
        {
          text: 'Verarbeiten',
          handler: function(btn){
            var me = btn.up('pwgen_pw_command');
            me.run(me.list);
          }
        }
      ]
  });
  