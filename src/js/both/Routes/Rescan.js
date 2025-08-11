
Ext.define('Tualo.routes.Routes.PaperVoteRescan', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'papervote/rescan',
                    path: '#papervote/rescan'
                }
            ]
        }
    },
    url: 'papervote/rescan(/:wahlscheinstatus/:abgabetyp)',
    handler: {
        action: function (values) {

            if (typeof values.wahlscheinstatus == 'undefined') {
                values.wahlscheinstatus = 2;
            }
            if (typeof values.abgabetyp == 'undefined') {
                values.abgabetyp = 0;
            }
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Rescan', {
                wahlscheinstatus: values.wahlscheinstatus,
                abgabetyp: values.abgabetyp
            });

        },
        before: function (values, action) {

            action.resume();
        }
    }
});

