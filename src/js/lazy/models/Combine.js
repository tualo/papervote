Ext.define('Tualo.PaperVote.lazy.models.Combine', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_combine',
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