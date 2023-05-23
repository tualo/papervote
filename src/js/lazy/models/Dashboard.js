Ext.define('Tualo.PaperVote.lazy.models.Dashboard', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_dashboard',
    data:{
        saving: false,
        initialized: false,
        record: null
    },
    formulas: {
        disabled: function(get){
            return Ext.isEmpty(get('record')) || get('saving');
        }
    }
});