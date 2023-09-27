Ext.define('Tualo.PaperVote.lazy.users.Viewport', {
    extend: 'Ext.panel.Panel',
    requires: [
        'Ext.panel.Panel',
        'Tualo.PaperVote.lazy.users.ManualGrid',
        'Tualo.PaperVote.lazy.users.models.Viewport',
        'Tualo.PaperVote.lazy.users.controller.Viewport'

    ],
    layout: 'fit',
    controller: 'cmp_wm_beteiligung_viewport',
    viewModel: {
        type: 'cmp_wm_beteiligung_viewport'
    },
    listeners: {
      boxready: 'onBoxReady'
    },
    bind: {
      title: '{title}'
    },
    tbar: [
      {
          text: 'Excelauswertung',
          handler: 'onExcelClick'
      },
      {
          text: 'Flatfile',
          handler: 'onFlatFileClick'
      },'-',
      {
          text: 'Eingabe WB ohne Zuordnung',
          handler: 'onOhneWBClick'
      },'->',
      {
          text: 'Code - PDF',
          handler: 'onCodePDFClick'
      }
    ],
    items: [

    ]
});
