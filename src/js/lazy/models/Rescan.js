Ext.define('Tualo.PaperVote.lazy.models.Rescan', {
  extend: 'Ext.app.ViewModel',
  alias: 'viewmodel.cmp_wm_nachzaehlung_viewport',
  data: {
    count: 0,
    wahlscheinstatus: null,
    abgabetyp: null,
    wahlscheinstatusText: null,
    abgabetypText: null,
    typ: 'wahlscheinnummer'
  },
  formulas: {
    ftitle: function (get) {
      //return 'Nacherfassung von ' + get('wahlscheinstatusText') + ' und ' + get('abgabetypText') + ' (' + ((get('typ') == 'wahlberechtigter') ? 'Wahlberechtigter' : 'Wahlschein') + ')';
      return 'Nacherfassung von  ' + ((get('typ') == 'wahlberechtigter') ? 'Wahlberechtigter' : 'Wahlschein') + ' der  ' + get('abgabetypText') + ' mit dem Status ' + get('wahlscheinstatusText') + '';
    }
  },
  stores: {
    wahlscheinstatus: {
      autoLoad: true,
      remoteFilter: false,
      pageSize: 10000,
      type: 'wahlscheinstatus_store',
      listeners: {
        load: 'onWahlscheinstatusLoad'
      }
    },
    abgabetyp: {
      autoLoad: true,
      remoteFilter: false,
      pageSize: 10000,
      type: 'abgabetyp_store',
      listeners: {
        load: 'onAbgabetypLoad'
      }
    },

  }
});