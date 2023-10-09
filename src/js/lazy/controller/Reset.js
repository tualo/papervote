Ext.define('Tualo.PaperVote.lazy.controller.Reset', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.cmp_wm_reset_viewport',

  onBoxReady: function(){
    console.log(this.getViewModel().getStore('list'));

  },

  onTanReset: function(){
    Ext.MessageBox.confirm('TANs - Reset','Möchten Sie wirklich die TANs zurücksetzen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          url: './papervote/reset/tan',
          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  },
  onRuecklaufReset: function(){
    Ext.MessageBox.confirm('Rücklauf - Reset','Möchten Sie wirklich den Rücklauf zurücksetzen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          url: './papervote/reset/ruecklauf',
          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  },
  onStimmenReset: function(){
    Ext.MessageBox.confirm('Stimmenauszählung - Reset','Möchten Sie wirklich Stimmenauszählung löschen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          url: './papervote/reset/zaehldaten',

          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  },
  onBerechtigtenReset: function(){
    Ext.MessageBox.confirm('Berechtigten - Reset','Möchten Sie wirklich alle Berechtigten löschen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          timeout: 600000,
          url: './papervote/reset/wahlberechtigte',

          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  },
  onZeichnungsberechtigtenReset: function(){
    Ext.MessageBox.confirm('Zeichnungsberechtigten - Reset','Möchten Sie wirklich alle Zeichnungsberechtigten löschen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          url: './papervote/reset/wahlzeichnungsberechtigter',

          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  },
  onKandidatenReset: function(){
    Ext.MessageBox.confirm('Kandidaten - Reset','Möchten Sie wirklich alle Kandidaten löschen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          url: './papervote/reset/kandidaten',

          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  },
  onOnlinekandidatenReset: function(){
    Ext.MessageBox.confirm('Onlinekandidaten - Reset','Möchten Sie wirklich alle Onlinekandidaten löschen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          url: './papervote/reset/onlinekandidaten',

          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  },
  onWahlgruppenReset: function(){
    Ext.MessageBox.confirm('Wahlgruppen und Bezirke - Reset','Möchten Sie wirklich alle Wahlgruppen und Bezirke löschen?',function(btn){
      if (btn=='yes'){
        Tualo.Ajax.request({
          showWait: true,
          url: './papervote/reset/wahlgruppen',

          json: function(o){
            Ext.MessageBox.alert('Reset',o.msg);
          }
        });
      }
    },this);
  }
});

//WVD_DM_16_022
