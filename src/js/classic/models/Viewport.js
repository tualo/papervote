Ext.define('Tualo.PaperVote.models.Viewport', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.paperviewportmodel',
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