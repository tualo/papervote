
Ext.define('Tualo.routes.Routes.PaperVoteInvolvement', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'papervote/involvement',
                    path: '#papervote/involvement'
                }
            ]
        }
    },
    url: 'papervote/involvement',
    handler: {
        action: function () {

            Ext.getApplication().addView('Tualo.PaperVote.lazy.involvement.Viewport');
        },
        before: function (action) {

            if (Ext.ClassManager.getNameByAlias('store.wahltyp_store') == '') {
                Ext.toast('Wahltyp Store not found, please check your configuration');
                action.stop();
                return;
            }
            if (Ext.ClassManager.getNameByAlias('store.wahlbeteiligung_bericht_store') == '') {
                Ext.toast('Wahlbeteiligung Bericht Store not found, please check your configuration');
                action.stop();
                return;
            }


            if (Ext.ClassManager.getNameByAlias('store.wahlbeteiligung_bericht_formel_store') == '') {
                Ext.toast('Wahlbeteiligung Bericht Formel Store not found, please check your configuration');
                action.stop();
                return;
            }


            if (Ext.ClassManager.getNameByAlias('store.view_ohne_wahlberechtigten_store') == '') {
                Ext.toast('Ohne Wahlberechtigten Store not found, please check your configuration');
                action.stop();
                return;
            }
            action.resume();
        }
    }
});
