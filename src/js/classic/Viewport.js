Ext.Loader.setPath('Tualo.PaperVote.lazy', './jspapervote');

Ext.define('Tualo.PaperVote.Viewport', {
    extend: "Ext.panel.Panel",
    controller: 'paperviewportcontroller',
    viewModel: {
        type:'paperviewportmodel',
    },
    listeners: {
        boxready: 'onBoxReady'
    },
    layout: 'fit',
    html: 'papervote **',
});