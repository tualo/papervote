

Ext.define('Tualo.PaperVote.lazy.monitor.models.Viewport', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.cmp_wm_wahlausschuss_mon',
    data: {
        loopTimeout: 15
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
        
        view_stimmenanzahl_ranking_los_monitor_list:{
            autoLoad: true,
            remoteFilter: false,
            pageSize: 10000,
            type: 'view_stimmenanzahl_ranking_los_monitor_list_store'
        },
        
        view_stimmenanzahl_ranking_los_monitor:{
            autoLoad: true,
            remoteFilter: true,
            pageSize: 10000,
            type: 'view_stimmenanzahl_ranking_los_monitor_store',
            listeners: {
                load: 'onMonitorStoreLoad'
            }
        }
    }
});
  