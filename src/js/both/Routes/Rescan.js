
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
    url: 'papervote/rescan(\/:{typ}\/:{wahlscheinstatus}\/:{abgabetyp})',
    handler: {
        action: function (values) {
            console.log('action Tualo.routes.Routes.PaperVoteRescan', arguments);
            if (typeof values.wahlscheinstatus == 'undefined') {
                values.wahlscheinstatus = 2;
            }
            if (typeof values.abgabetyp == 'undefined') {
                values.abgabetyp = 0;
            }
            if (typeof values.typ == 'undefined') {
                values.typ = 'wahlscheinnnummer';
            }
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Rescan', {
                wahlscheinstatus: values.wahlscheinstatus,
                abgabetyp: values.abgabetyp,
                typ: values.typ
            });

        },
        before: function (values, action) {
            console.log('before Tualo.routes.Routes.PaperVoteRescan', arguments);
            action.resume();
        }
    }
});

