Ext.define('Tualo.PaperVote.lazy.Dashboard', {
    extend: "Ext.panel.Panel",
    requires: [
        'Tualo.PaperVote.lazy.controller.Dashboard',
        'Tualo.PaperVote.lazy.models.Dashboard',
    ],
    controller: 'papervote_dashboard',
    viewModel: {
        type:'papervote_dashboard',
    },
    listeners: {
        boxready: 'onBoxReady'
    },
    layout: 'fit',
    html: 'papervote lazy ***',
});