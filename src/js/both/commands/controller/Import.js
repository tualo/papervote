Ext.define('Tualo.PaperVote.commands.controller.Import', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.wm_pwgen_importcmd',


    onBoxReady: function(){
        var me = this;
        // console.log('uploadsettings start',me,me.getViewModel().get('uploadSize'));
        // max-size="2000"
        Tualo.Ajax.request({
          url: './pwgen/uploadsettings',
          json: function(o){
            me.getViewModel().set('uploadSize',o.max_size);
            me.getViewModel().set('uploadSizeText',Ext.util.Format.fileSize(me.getViewModel().get('uploadSize')));
            //console.log('uploadsettings',o,me.getViewModel().get('uploadSize'));
          }
        })
    },

    testSheets: function(index,o){
      var me = this,
        view = me.getView(),
        wizzard = view.getComponent('wizzard'),
        card = wizzard.getComponent('analyseCard'),
        progress = card.getComponent('analyseCardF1').getComponent('analyseCardSheetProgress'),
        model = me.getViewModel();
      console.log('testSheets',index,o,progress);
      if ((index<o.sheets.length)){
        model.set('sheetname',o.sheets[index]);
        progress.updateProgress( (index+1)/o.sheets.length );
        //me.getViewModel().set('nextDisabled',false);
        me.testSheetsColumns(0,o.sheetsconfig[o.sheets[index]][1],function(){
          me.testSheets(++index,o);
        });
      }else{
        me.doCardNavigation(1);
        //me.getViewModel().set('nextDisabled',false);
        me.createColumns(function(){});
        console.log('done *',me.getViewModel().get('nextDisabled'));
      }
      
    },

    testSheetsColumns: function(index,columns,cb){
      console.log('testSheetsColumns',index,columns);
      var me = this,
        view = me.getView(),
        wizzard = view.getComponent('wizzard'),
        card = wizzard.getComponent('analyseCard'),
        progress = card.getComponent('analyseCardF2').getComponent('analyseCardColumnProgress'),
        ccard = wizzard.getComponent('columnsCard'),
        columnsGrid = ccard.getComponent('columnsGridPanel').getComponent('columnsGrid'),
        model = me.getViewModel(),
        excel_header="",
        excel_column="",
        column_name="";
         
        
        

      if ((index<100)&&(index < Object.keys(columns).length )){

        column_name = columns[Object.keys(columns)[index]].toLowerCase().replace("ä",'ae').replace("ö",'oe').replace("ü",'ue').replace("ß",'ss').replace(/[^\x61-\x7A0-9]/g, "_");
        excel_column = Object.keys(columns)[index];
        excel_header =  columns[Object.keys(columns)[index]];

        model.set('columnname', Object.keys(columns)[index] + ' ( '+columns[Object.keys(columns)[index]] + ')' );
        progress.updateProgress( (index+1)/Object.keys(columns).length );
        Tualo.Ajax.request({
          url: './pwgen/testcolumn',
          scope: this,
          timeout: 300000,
          showWait: true,
          params: {
            sheetname: model.get('sheetname'),
            column: Object.keys(columns)[index]
          },
          json: function(o){
              if (o.success==false){
                var msg = "";
                try{ msg = o.msg; }catch(e){};
                Ext.toast({
                  html: "<h3>Fehler beim Verarbeiten</h3><p>Bitte prüfen Sie die Datei, diese konnte nicht verarbeitet werden.</p><p>"+msg+"</p>",
                  title: 'Fehler',
                  width: 400,
                  align: 't'
              });
            }else{

              var store = columnsGrid.getStore(),
                record = store.findRecord( 'column_name', column_name, 0, false, false, true );
                if (record){
                  record.set({
                    'excel_column': excel_column,
                    'excel_header': excel_header,
                    'data_type': o.info.type,
                    'contains_null': o.info.contains_null,
                    'unique': o.info.unique,
                    'column_name': column_name,
                    'variation_count': o.info.variation_count,
                    'length': o.info.length,
                    //'fktable': ((o.info.variation_count / o.info.variation_length)<0.05)?true:false
                  });
                }else{
                  console.log(excel_column,excel_header,o.info.type);
                  store.add({
                    'excel_column': excel_column,
                    'excel_header': excel_header,
                    'data_type': o.info.type,
                    'contains_null': o.info.contains_null,
                    'is_new': true,
                    'unique': o.info.unique,
                    'column_name': column_name,
                    'variation_count': o.info.variation_count,
                    'length': o.info.length,
                    'fktable': ((o.info.variation_count / o.info.variation_length)<0.05)?true:false
                  });
                }
              setTimeout(function(){

                console.log('testSheetsColumns',++index,columns);
                this.testSheetsColumns(index++,columns,cb);

              }.bind(this),1);
            }
          }
        })

        
      }else{
        cb();
      }
      
    },

    createColumns: function(cb){
      var me = this,
        view = me.getView(),
        wizzard = view.getComponent('wizzard'),
        card = wizzard.getComponent('analyseCard'),
        progress = card.getComponent('analyseCardF2').getComponent('analyseCardColumnProgress'),
        ccard = wizzard.getComponent('columnsCard'),
        columnsGrid = ccard.getComponent('columnsGridPanel').getComponent('columnsGrid'),
        model = me.getViewModel(),
        store = columnsGrid.getStore(),
        range = store.getRange(),
        data = [];
      
      range.forEach( function(item){
        data.push(item.data);
      } );
      console.log(data);

      Tualo.Ajax.request({
        url: './pwgen/createcolumns',
        scope: this,
        timeout: 300000,
        showWait: false,
        params: {
          data: JSON.stringify(data)
        },
        json: function(o){
            if (o.success==false){
              var msg = "";
              try{ msg = o.msg; }catch(e){};
              Ext.toast({
                html: "<h3>Fehler beim Verarbeiten</h3><p>Bitte prüfen Sie die Datei, diese konnte nicht verarbeitet werden.</p><p>"+msg+"</p>",
                title: 'Fehler',
                width: 400,
                align: 't'
            });
          }else{
            cb();
          }
        }
      })
    },

    importData: function(cb){
        var me = this,
        view = me.getView(),
        wizzard = view.getComponent('wizzard'),
        card = wizzard.getComponent('analyseCard'),
        progress = card.getComponent('analyseCardF2').getComponent('analyseCardColumnProgress'),
        ccard = wizzard.getComponent('columnsCard'),
        columnsGrid = ccard.getComponent('columnsGridPanel').getComponent('columnsGrid');

        Tualo.Ajax.request({
            url: './pwgen/createcolumns',
            scope: this,
            timeout: 300000,
            showWait: false,
            params: {
              data: JSON.stringify(data)
            },
            json: function(o){
                if (o.success==false){
                  var msg = "";
                  try{ msg = o.msg; }catch(e){};
                  Ext.toast({
                    html: "<h3>Fehler beim Verarbeiten</h3><p>Bitte prüfen Sie die Datei, diese konnte nicht verarbeitet werden.</p><p>"+msg+"</p>",
                    title: 'Fehler',
                    width: 400,
                    align: 't'
                });
              }else{
                cb();
              }
            }
          })
    },
    showNext: function() {
      var me = this,
        view = me.getView(),
        wizzard = view.getComponent('wizzard'),
        card = wizzard.getComponent('uploadCard'),
        form = card.getComponent('uploadForm').getForm(),
        incr = 1,
        l = wizzard.getLayout(),
        i = l.activeItem.id.split('card-')[1],
        next = parseInt(i, 10) + incr;

        if (i==0 && next==1){
          if(form.isValid()) {
              form.submit({
                  url: './pwgen/upload',
                  timeout: 300000,
                  waitMsg: 'Hochladen der Datei...',
                  scope: this,
                  success: function(fp, o) {
                      console.log('./pwgen/upload',o);
                      me.doCardNavigation(1);
                      me.testSheets(0,o.result);

                  },
                  failure: function(o,res){
                    var msg = "";
                    try{ msg = res.result.msg; }catch(e){};
                    Ext.toast({
                        html: "<h3>Datei konnte nicht hochgeladen werden</h3><p>Bitte prüfen Sie die Datei, diese konnte nicht verarbeitet werden.</p><p>"+msg+"</p>",
                        title: 'Fehler',
                        width: 400,
                        align: 't'
                    });
                  }
              });
          }
        }else if(i==2 && next==3){
          //me.getViewModel().set('nextDisabled',true);
          me.createColumns(function(){
            //me.getViewModel().set('nextDisabled',false);
            me.doCardNavigation(1);
          });
        }else{
          me.doCardNavigation(1);
        }
    },

    showPrevious: function(btn) {
      var me = this,
        view = me.getView(),
        wizzard = view.getComponent('wizzard'),
        card = wizzard.getComponent('uploadCard');
        me.doCardNavigation(-1);
    },

    doCardNavigation: function(incr) {
      var me = this,
          view = me.getView(),
          wizzard = view.getComponent('wizzard'),
            l = wizzard.getLayout(),
            i = l.activeItem.id.split('card-')[1],
            next = parseInt(i, 10) + incr;

        l.setActiveItem(next);

        wizzard.down('#card-prev').setDisabled(next === 0);
        wizzard.down('#card-next').setDisabled(next === 3);
    }
});
  