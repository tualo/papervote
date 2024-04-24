Ext.define('Tualo.PaperVote.lazy.models.Blockdocument', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_lazy_blockdocument',
    data: {
      modell: 'Handerfassung',
      regiogruppe: 'Zustellung',
      sortiergang: 'rest',
      count: 0
    },
    formulas: {
      ftitle: function(get){
        return 'Rücklauf ('+get('count')+')';
      }
    },
    stores: {
      
    }
  });