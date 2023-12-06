Ext.define('Tualo.PaperVote.lazy.controller.Combine', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_combine',
    onBoxReady: function(){
        
    },
    onInitialIdentChange: function(field, newValue, oldValue, eOpts){
        let me = this,
            vm = me.getViewModel();
        console.log('onInitialIdentChange',field, newValue, oldValue, eOpts);
        me.checkIdent(newValue);
        
    },
    checkIdent: async function(identnummer){
        let me = this,
            vm = me.getViewModel(),
            res = null;
        console.log('onInitialIdentChange',field, newValue, oldValue, eOpts);
        try{
            vm.set('inProgress',true);
            res =await fetch('./papervote/identnummer/'+identnummer).then( (response) => response.json() );
            if (res.success){
                vm.set('initial_ident',identnummer);
                vm.set('voterData',res.data);
                vm.set('hasError',false);
                vm.set('errorMessage','');
            }else{
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