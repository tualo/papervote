
Ext.define('Tualo.routes.PaperVote', {
    url: 'papervote',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.Viewport');
        },
        before: function (action) {
            action.resume();
        }
    }
});