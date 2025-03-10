Ext.define('Tualo.PaperVote.lazy.input.models.UI', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_input_ui',
    data: {
        blocknumber: '',
        useident: false,
        forceblocknumber: true,
        list_length: 1,
        count: 0
    },
    formulas: {
        ftitle: function (get) {
            let txt = '', typ = 'Rücklauf per Wahlscheinnummer';
            if (get('useident')) {
                typ = 'Rücklauf per Identnummer';
            }

            if (get('list_length') > 1) txt = ' - Listenerfassung ' + ' (' + get('count') + ')';
            return typ + txt + ' | Aktueller Block: ' + get('blocknumber');
        }
    },
    stores: {

        wahlscheinstatus: {
            autoLoad: false,
            type: 'wahlscheinstatus_store',
            listeners: {
                load: 'onWahlscheinstatusLoad'
            }
        },

        wahlscheinstatus_offline_erlaubt: {
            autoLoad: true,
            type: 'wahlscheinstatus_offline_erlaubt_store'
        },
        abgabetyp_offline_erlaubt: {
            autoLoad: true,
            type: 'abgabetyp_offline_erlaubt_store'
        },


        datalist: {
            type: 'store',
            fields: ['id', 'html'],
            listeners: {
                add: 'onListAdd',
                remove: 'onListRemove'
            }
        },
        wahlscheinstatus_grund: {
            autoLoad: true,
            type: 'wahlscheinstatus_grund_store'
        },
        wahltyp: {
            autoLoad: true,
            type: 'wahltyp_store',
            listeners: {
                load: 'onWahltypLoad'
            }
        },
        wzbruecklauffelder: {
            autoLoad: true,
            type: 'wzbruecklauffelder_store'
        },
        ruecklauffelder: {
            autoLoad: true,
            type: 'ruecklauffelder_store',
            listeners: {
                load: 'onRuecklauffelderLoad'
            }
        }

    }
});
