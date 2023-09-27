Ext.define('Tualo.PaperVote.lazy.models.Input', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_input',
    data: {
      modell: 'Handerfassung',
      regiogruppe: 'Zustellung',
      sortiergang: 'rest',
      blocknumber: '',
      
      count: 0
    },
    formulas: {
      ftitle: function(get){
        return 'Rücklauf ('+get('count')+') | Aktueller Block: '+get('blocknumber');
      }
    },
    stores: {
        
      wahlscheinstatus: {
        autoLoad: false,
        type: 'wahlscheinstatus_store',
        listeners: {
          load: 'onWahlscheinstatusLoad'
        }
      },
      datalist: {
        type: 'store',
        fields: ['waehler','zeichnungsberechtigter'],
        listeners: {
          add: 'onListAdd',
          remove: 'onListRemove'
        }
      },
      wahlscheinstatus_grund: {
        autoLoad: false,
        type: 'wahlscheinstatus_grund_store'
      },
      wahltyp: {
        autoLoad: false,
        type: 'wahltyp_store',
        listeners: {
          load: 'onWahltypLoad'
        }
      },
      wzbruecklauffelder: {
        autoLoad: false,
        type: 'wzbruecklauffelder_store'
      },
      ruecklauffelder: {
        autoLoad: false,
        type: 'ruecklauffelder_store',
        listeners: {
          load: 'onRuecklauffelderLoad'
        }
      }
      
    }
  });
  