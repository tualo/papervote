Ext.define('Tualo.PaperVote.lazy.controller.Combine', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_combine',
    onBoxReady: function(){
        
    },
    onInitialIdentChange: async function(field, newValue, oldValue, eOpts){
        console.log('onInitialIdentChange',field, newValue, oldValue, eOpts);
        let res =await fetch('/papervote/identnummer/'+newValue).then( (response) => response.json() );
        console.log(res);
    }
});