Ext.define('Tualo.PaperVote.lazy.models.Rescan', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.cmp_wm_nachzaehlung_viewport',
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