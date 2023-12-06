Ext.define('Tualo.PaperVote.lazy.controller.Combine', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_combine',
    onBoxReady: function(){
        let me = this,
            vm = me.getViewModel(),
            ruecklauffelderStore = vm.getStore('ruecklauffelder');

      ruecklauffelderStore.load({
        params:{
          filter: Ext.JSON.encode([{property:'aktiv',value:'1',operator:'eq'}])
        }
      });

    },
    onInitialIdentChange: function(field, newValue, oldValue, eOpts){
        let me = this,
            vm = me.getViewModel();
        console.log('onInitialIdentChange',field, newValue, oldValue, eOpts);
        me.checkIdent(newValue);
        
    },

    getNameHtml: function(dataItem){
        let me = this,
            html = '',
            vm = me.getViewModel(),
            ruecklauffelderStore = vm.getStore('ruecklauffelder');
        ruecklauffelderStore.getRange().forEach(function(ruecklauffeld){
            if (Ext.isEmpty(dataItem[ruecklauffeld.get('column_name')])){
                html += '<br/>';
              }else{
                html += '<span>'+dataItem[ruecklauffeld.get('column_name')]+'</span><br/>';
              }

        });
        return html;
    },


    checkIdent: async function(identnummer){
        let me = this,
            vm = me.getViewModel(),
            res = null,
            dataItem = null,
            html = '';
        try{
            vm.set('inProgress',true);
            res =await fetch('./papervote/identnummer/'+identnummer).then( (response) => response.json() );
            if (res.success){
                dataItem = res.data[0];
                vm.set('initial_ident',identnummer);
                vm.set('voterData',dataItem);
                vm.set('hasError',false);
                vm.set('errorMessage','');
                html = me.getNameHtml(dataItem);
                if(dataItem.kombiniert != identnummer){
                    vm.set('hasError',true);
                    vm.set('errorMessage','Die Identnummer ist bereits kombiniert!');
                }
                vm.set('voterHtml',html);
            }else{
                vm.set('voterHtml','nicht gefunden!');
                vm.set('voterData',null);
                vm.set('hasError',true);
                vm.set('errorMessage',res.message);
            }
        }catch(e){
            vm.set('hasError',true);
            vm.set('errorMessage',e.message);
        }finally{
            vm.set('inProgress',false);
        }
    },

    onListIdentChange: function(field, newValue, oldValue, eOpts){
        let me = this,
            vm = me.getViewModel(),
            list = newValue.replace(/[^0-9]/g,' ').replace(/\s\s/g,' ').split(' '),
            identListStore = vm.getStore('identList');
            
        identListStore.removeAll();
        list.forEach(function(identnummer){
            identListStore.add({identnummer:identnummer,status:false});
        });

        identListStore.getRange().forEach(async function(rec){
            let res = await fetch('./papervote/identnummer/'+rec.get('identnummer')).then( (response) => response.json() );
            if (res.success){
                dataItem = res.data[0];
                let html = me.getNameHtml(dataItem);
                rec.set('name',html);
                if(
                    (dataItem.kombiniert == identnummer) &&
                    (dataItem.wahlscheinstatus=='1|0')
                ){
                    rec.set('status',true);
                    

                }else if (dataItem.kombiniert != identnummer)
                {
                    rec.set('status',false);
                    rec.set('message','Die Identnummer ist bereits kombiniert!');
                }else if (dataItem.wahlscheinstatus=='1|0')
                {
                    rec.set('status',false);
                    rec.set('message','Die Identnummer hat bereits einen Status ungleich unbekannt!');
                }
            }else{
                rec.set('status',false);
                rec.set('message',res.msg);
            }
        });
        
    },

    showNext: function () {
        this.doCardNavigation(1);
    },

    showPrevious: function (btn) {
        this.doCardNavigation(-1);
    },

    doCardNavigation: function (incr) {
        let me = this,
            l = me.getView().getLayout(),
            i = l.activeItem.id.split('card-')[1],
            next = parseInt(i, 10) + incr,
            vm = me.getViewModel();

        l.setActiveItem(next);
        vm.set('currentCardIndex', next );
        
    }
});