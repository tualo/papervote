Ext.define('Tualo.PaperVote.lazy.controller.Dashboard', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_dashboard',
    onBoxReady: function(){
        
        this.getView().add(Ext.create('Tualo.PaperVote.lazy.Input'));
    }
});