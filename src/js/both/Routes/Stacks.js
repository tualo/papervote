
Ext.define('Tualo.routes.Routes.PaperVoteStacks', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'papervote/stacks',
                    path: '#papervote/stacks'
                }
            ]
        }
    },
    url: 'papervote/stacks',
    handler: {
        action: function () {

            Ext.getApplication().addView('Tualo.PaperVote.lazy.stacks.Viewport');
        },
        before: function (action) {


            action.resume();
        }
    }
});