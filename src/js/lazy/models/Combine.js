Ext.define('Tualo.PaperVote.lazy.models.Combine', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_combine',
    data:{
        currentCardIndex: 0,
        initial_ident: null,
        voterData: null,
    },
    formulas: {
        prevDisabled: function(get){
            if (get('currentCardIndex')==0) return true;
            return false;
        },
        nextDisabled: function(get){
            if ((get('currentCardIndex')==1) &&( Ext.isEmpty( get('initial_ident') ) )) return true;

            return get('currentCardIndex')<0;
        },
        currentCard: function(get){
            return  'card-'+ get('currentCardIndex');
        }
    }
});