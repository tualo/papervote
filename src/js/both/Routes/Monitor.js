
Ext.define('Tualo.routes.Routes.PaperVoteMonitor', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'papervote/monitor',
                    path: '#papervote/monitor'
                }
            ]
        }
    },
    url: 'papervote/monitor',
    handler: {
        action: function () {
            Ext.getApplication().addView('Tualo.PaperVote.lazy.monitor.Viewport');


        },
        before: function (action) {

            action.resume();

        }
    }
});
