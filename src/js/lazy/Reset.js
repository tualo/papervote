Ext.define('Tualo.PaperVote.lazy.Reset', {
  extend: 'Ext.panel.Panel',

  layout: {
    type: 'vbox',
    align: 'stretch'
  },
  
  requires: [
    'Tualo.PaperVote.lazy.models.Reset',
    'Tualo.PaperVote.lazy.controller.Reset'
  ],
  
  alias: 'widget.cmp_wm_reset_viewport',
  controller: 'cmp_wm_reset_viewport',
  viewModel: {
    type: 'cmp_wm_reset_viewport'
  },
  listeners: {
    boxReady: 'onBoxReady'
  },
   
  title: 'Datenreset',
  bodyPadding: '25px',
  items: [
     
    {
      xtype: 'button',
      text: 'Tannummern - Reset',
      handler: 'onTanReset',
      margin: '10px'
    },
    {
      xtype: 'button',
      text: 'Rücklauf - Reset',
      handler: 'onRuecklaufReset',
      margin: '10px'
    },
    {
      xtype: 'button',
      text: 'Stimmenauszählung - Reset',
      handler: 'onStimmenReset',
      margin: '10px'
    },
    {
      xtype: 'button',
      text: 'Berechtigten - Reset',
      handler: 'onBerechtigtenReset',
      margin: '10px'
    },
    {
      xtype: 'button',
      text: 'Zeichnungsberechtigten - Reset',
      handler: 'onZeichnungsberechtigtenReset',
      margin: '10px'
    },
    {
      xtype: 'button',
      text: 'Kandidaten - Reset',
      handler: 'onKandidatenReset',
      margin: '10px'
    },
    {
      xtype: 'button',
      text: 'Wahlgruppen/ Wahlbezirk - Reset',
      handler: 'onWahlgruppenReset',
      margin: '10px'
    },
    {
      xtype: 'button',
      text: 'Onlinekandidaten - Reset',
      handler: 'onOnlinekandidatenReset',
      margin: '10px'
    }

  ]
})
