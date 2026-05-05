
Ext.define('Tualo.routes.Routes.PaperVotePagination', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'papervote/pagination',
                    path: '#papervote/pagination'
                }
            ]
        }
    },
    url: 'papervote/pagination',
    handler: {
        action: function () {

            Ext.getApplication().addView('Tualo.PaperVote.lazy.pagination.Viewport');
        },
        before: function (action) {


            action.resume();
        }
    }
});