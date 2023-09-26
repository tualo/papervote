
Ext.define('Tualo.routes.PaperVote', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote_return',
                    path: '#papervote/return'
                }
            ]
        }
    }, 
    url: 'papervote/return',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.Viewport');
        },
        before: function (action) {
            action.resume();
        }
    }
});


Ext.define('Tualo.routes.PaperVote', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote_counting',
                    path: '#papervote/counting'
                }
            ]
        }
    }, 
    url: 'papervote/counting',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.counting.Viewport');
        },
        before: function (action) {
            action.resume();
        }
    }
});