Ext.define('Tualo.PaperVote.lazy.Combine', {
    extend: "Ext.panel.Panel",
    requires: [
        'Tualo.PaperVote.lazy.controller.Combine',
        'Tualo.PaperVote.lazy.models.Combine',
    ],
    controller: 'papervote_combine',
    viewModel: {
        type:'papervote_combine',
    },
    listeners: {
        boxready: 'onBoxReady'
    },
    layout: 'fit',
    html: 'papervote combine lazy ***',
});