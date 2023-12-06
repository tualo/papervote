Ext.define('Tualo.PaperVote.lazy.controller.Combine', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_combine',
    onBoxReady: function(){
        
    },
    onInitialIdentChange: async function(field, newValue, oldValue, eOpts){
        console.log('onInitialIdentChange',field, newValue, oldValue, eOpts);
        let res =await fetch('/papervote/identnummer/'+newValue).then( (response) => response.json() );
        console.log(res);
    },

    showNext: function () {
        this.doCardNavigation(1);
    },

    showPrevious: function (btn) {
        this.doCardNavigation(-1);
    },

    doCardNavigation: function (incr) {
        let me = this,
            l = me.getLayout(),
            i = l.activeItem.id.split('card-')[1],
            next = parseInt(i, 10) + incr,
            vm = me.getViewModel();

        l.setActiveItem(next);
        vm.set('currentCardIndex', next );
        
    }
});