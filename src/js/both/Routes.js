
Ext.define('Tualo.routes.PaperVoteReturn', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/return',
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


Ext.define('Tualo.routes.PaperVoteCounting', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/counting',
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



Ext.define('Tualo.routes.PaperVoteReset', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/reset',
                    path: '#papervote/reset'
                }
            ]
        }
    }, 
    url: 'papervote/reset',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Reset');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});