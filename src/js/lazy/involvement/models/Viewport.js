Ext.define('Tualo.PaperVote.lazy.involvement.models.Viewport', {
  extend: 'Ext.app.ViewModel',
  alias: 'viewmodel.cmp_wm_beteiligung_viewport',
  data: {
    typ_name: 'Unbekannt',
    wahltyp__ridx: '',
    testdaten: 0,
    base: 'stimmzettel_default'
  },
  formulas: {
    title: function (get) {
      return 'Beteiligung >> ' + get('typ_name')
    }
  },
  stores: {
    wahltyp: {
      autoLoad: false,
      type: 'wahltyp_store',
      listeners: {
        load: 'onWahltypLoad'
      }
    },
    wahlbeteiligung_bericht: {
      autoLoad: false,
      type: 'wahlbeteiligung_bericht_store',
      listeners: {
        load: 'onWahlbeteiligungBerichtLoad'
      }
    },
    wahlbeteiligung_bericht_formel: {
      autoLoad: false,
      type: 'wahlbeteiligung_bericht_formel_store',
      listeners: {
        load: 'onWahlbeteiligungBerichtFormelLoad'
      }
    },
    ohne_wahlberechtigten: {
      autoLoad: false,
      type: 'view_ohne_wahlberechtigten_store',
      listeners: {
        load: 'onOhneWahlberechtigtenlLoad'
      }
    }
  }
});
