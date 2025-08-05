

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

        view_protokoll_erwartet: {
            autoLoad: true,
            remoteFilter: false,
            pageSize: 10000,
            type: 'view_protokoll_erwartet_store'
        },
        view_kandidaten_stimmenanzahl: {
            autoLoad: true,
            remoteFilter: true,
            pageSize: 10000,
            type: 'view_kandidaten_stimmenanzahl_store',
            listeners: {
                load: 'onMonitorStoreLoad'
            }
        },

        /*

        view_stimmenanzahl_ranking_los_monitor_list_gruppen: {
            autoLoad: true,
            remoteFilter: false,
            pageSize: 10000,
            // type: 'store',
            type: 'view_stimmenanzahl_ranking_los_monitor_list_gruppen_store'
        },
        view_stimmenanzahl_ranking_los_monitor_list: {
            autoLoad: true,
            remoteFilter: false,
            pageSize: 10000,
            // type: 'store',
            type: 'view_stimmenanzahl_ranking_los_monitor_list_store'
        },

        view_stimmenanzahl_ranking_los_monitor: {
            autoLoad: true,
            remoteFilter: true,
            pageSize: 10000,
            // type: 'store',
            type: 'view_stimmenanzahl_ranking_los_monitor_store',
            listeners: {
                load: 'onMonitorStoreLoad'
            }
        }
            */
    }
});
