Ext.define('Tualo.PaperVote.lazy.counting.models.Viewport', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_counting',
    data: {
        
    },
    stores: {
        stimmzettel: {
            autoLoad: true,
            remoteFilter: false,
            pageSize: 10000,
            type: 'stimmzettel_store'
        },
        stimmzettelgruppen: {
            autoLoad: true,
            remoteFilter: false,
            pageSize: 10000,
            type: 'stimmzettelgruppen_store'
        },
        kandidaten: {
            autoLoad: true,
            remoteFilter: false,
            pageSize: 10000,
            type: 'kandidaten_store'
        },
        
        list:{
            type: 'store',
            fields: [
                'stimmzettel',
                'stimmzettelnr',
                'stimmzettelgruppe',
                'stapel',
                'kandidat',
                'typ',
                'state',
                'code',
                'name',
                'kandidatridx'
            ],
            listeners: {
                add: 'onListAdd',
                remove: 'onListRemove'
            }
        }
    }
});
  