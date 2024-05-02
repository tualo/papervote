Ext.define('Tualo.PaperVote.lazy.models.OpticalScan', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_opticalscan',
    data: {

      count: 0
    },
    formulas: {
      ftitle: function(get){
        let txt='',typ='Prüfung per Stimmzettel';
        return typ+txt+'';
      }
    },
    stores: {
        
        papervote_optical: {
          autoLoad: false,
          type: 'papervote_optical_store',
          listeners: {
            load: 'onPapervoteOpticalLoad'
          }
        },

        view_papervote_optical_result: {
          autoLoad: false,
          type: 'view_papervote_optical_result_store',
          listeners: {
            load: 'onPapervoteOpticalResultLoad'
          }
        },
      
    }
  });
  