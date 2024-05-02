Ext.define('Tualo.PaperVote.lazy.controller.OpticalScan', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_opticalscan',

    
    onBoxReady: function () {
        var me = this;
        console.log('box ready');
        
        var store = me.getViewModel().getStore('papervote_optical');
        store.load();
       
    },
    onPapervoteOpticalLoad: function (store, records, successful, operation, eOpts) {
        console.log('store loaded',records);
        var me = this;
        me.getView().down('#docs').getStore().loadData(records);
    },
    onPapervoteOpticalResultLoad: function (store, records, successful, operation, eOpts) {
        console.log('store loaded',records);
        var me = this;
        me.getView().down('#marks').getStore().loadData(records);
    },
    onSelect:  function( grid, record, index, eOpts ){
        var me = this;
        //me.getView().down('#image').setSrc('./papervote/opticalimagesvg/'+record.get('pagination_id'));
        fetch('./papervote/opticalimagesvg/'+record.get('pagination_id')).then(function(response){
            return response.text();
        }).then(function(data){
            me.getView().down('#image').setHtml(data);
        });
        
        console.log('select',record);
        var store = me.getViewModel().getStore('view_papervote_optical_result');
        store.load({
            params: {
              filter: Ext.JSON.encode([{ property: 'pagination_id', value: record.get('pagination_id'), operator: 'eq' }])
            }
          });

    },
    onSelectCandidate:  function( grid, record, index, eOpts ){
        var me = this;
        console.log('select candidate',record);
    }
  });