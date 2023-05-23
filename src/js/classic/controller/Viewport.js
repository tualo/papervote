Ext.define('Tualo.PaperVote.controller.Viewport', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.paperviewportcontroller',
    onBoxReady: function(){
        this.getView().add(Ext.create('Tualo.PaperVote.lazy.Dashboard'));
    }
});