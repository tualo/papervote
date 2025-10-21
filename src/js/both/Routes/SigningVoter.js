
Ext.define('Tualo.routes.Routes.SigningVoter', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'papervote/signingvoter',
                    path: '#papervote/signingvoter'
                }
            ]
        }
    },
    url: 'papervote/signingvoter(\/:{typ}\/:{wahlscheinstatus}\/:{abgabetyp})',
    handler: {
        action: function (values) {
            console.log('action Tualo.routes.Routes.PaperVoteSigningVoter', arguments);
            if (typeof values.wahlscheinstatus == 'undefined') {
                values.wahlscheinstatus = 2;
            }
            if (typeof values.abgabetyp == 'undefined') {
                values.abgabetyp = 2;
            }
            if (typeof values.typ == 'undefined') {
                values.typ = 'wahlscheinnummer';
            }
            Ext.getApplication().addView('Tualo.PaperVote.lazy.SigningVoter', {
                wahlscheinstatus: values.wahlscheinstatus,
                abgabetyp: values.abgabetyp,
                typ: values.typ
            });

        },
        before: function (values, action) {
            console.log('before Tualo.routes.Routes.PaperVoteSigningVoter', arguments);
            action.resume();
        }
    }
});

