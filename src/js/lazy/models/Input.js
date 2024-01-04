Ext.define('Tualo.PaperVote.lazy.models.Input', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_input',
    data: {
      modell: 'Handerfassung',
      regiogruppe: 'Zustellung',
      sortiergang: 'rest',
      blocknumber: '',
      
      useident: false,
      list_length: 1,
      count: 0
    },
    formulas: {
      ftitle: function(get){
        let txt='',typ='Rücklauf per Wahlscheinnummer';
        if (get('useident')){
          typ= 'Rücklauf per Identnummer';
        }
        
        if (get('list_length')>1) txt=' - Listenerfassung '+' ('+get('count')+')';
        return typ+txt+' | Aktueller Block: '+get('blocknumber');
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
  