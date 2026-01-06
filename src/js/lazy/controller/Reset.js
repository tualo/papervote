Ext.define('Tualo.PaperVote.lazy.controller.Reset', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.cmp_wm_reset_viewport',

  onBoxReady: function () {
    console.log(this.getViewModel().getStore('list'));

  },

  onTanReset: function () {
    Ext.MessageBox.confirm('TANs - Reset', 'Möchten Sie wirklich die TANs zurücksetzen?', async function (btn) {
      if (btn == 'yes') {
        let o = await this.getData('./papervote/reset/tan');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onRuecklaufReset: function () {
    Ext.MessageBox.confirm('Rücklauf - Reset', 'Möchten Sie wirklich den Rücklauf zurücksetzen?', async function (btn) {
      if (btn == 'yes') {
        let o = await this.getData('./papervote/reset/ruecklauf');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onStimmenReset: function () {
    Ext.MessageBox.confirm('Stimmenauszählung - Reset', 'Möchten Sie wirklich Stimmenauszählung löschen?', async function (btn) {
      if (btn == 'yes') {
        let o = await this.getData('./papervote/reset/zaehldaten');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onBerechtigtenReset: function () {
    Ext.MessageBox.confirm('Berechtigten - Reset', 'Möchten Sie wirklich alle Berechtigten löschen?', async function (btn) {
      if (btn == 'yes') {
        let o = await this.getData('./papervote/reset/wahlberechtigte');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onZeichnungsberechtigtenReset: function () {
    Ext.MessageBox.confirm('Zeichnungsberechtigten - Reset', 'Möchten Sie wirklich alle Zeichnungsberechtigten löschen?', async function (btn) {
      if (btn == 'yes') {
        let o = await this.getData('./papervote/reset/wahlzeichnungsberechtigter');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onKandidatenReset: function () {
    Ext.MessageBox.confirm('Kandidaten - Reset', 'Möchten Sie wirklich alle Kandidaten löschen?', async function (btn) {
      if (btn == 'yes') {
        let o = await this.getData('./papervote/reset/kandidaten');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onOnlinekandidatenReset: function () {
    Ext.MessageBox.confirm('Onlinekandidaten - Reset', 'Möchten Sie wirklich alle Onlinekandidaten löschen?', async function (btn) {
      if (btn == 'yes') {

        let o = await this.getData('./papervote/reset/onlinekandidaten');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onWahlgruppenReset: function () {
    Ext.MessageBox.confirm('Wahlgruppen und Bezirke - Reset', 'Möchten Sie wirklich alle Wahlgruppen und Bezirke löschen?', async function (btn) {
      if (btn == 'yes') {

        let o = await this.getData('./papervote/reset/wahlgruppen');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },
  onOnlinewahlReset: function () {
    Ext.MessageBox.confirm('Onlinewahl - Reset', 'Möchten Sie wirklich die Onlinewahl löschen?', async function (btn) {
      if (btn == 'yes') {

        let o = await this.getData('./papervote/reset/onlinewahl');
        Ext.MessageBox.alert('Reset', o.msg);

      }
    }, this);
  },



  getData: async function (url) {

    try {
      const response = await fetch(url);
      if (!response.ok) {
        console.error(`Response status: ${response.status}`);
        const result = await response.json();
        return result;
      }

      const result = await response.json();
      return result;
    } catch (error) {
      console.error(error.message);
      return { success: false, msg: error.message };
    }
    return false;
  }
});

//WVD_DM_16_022


