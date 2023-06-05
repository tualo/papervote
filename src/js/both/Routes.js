
Ext.define('Tualo.routes.PaperVote', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote',
                    path: '#papervote'
                }
            ]
        }
    }, 
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