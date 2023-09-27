Ext.define('Tualo.PaperVote.lazy.involvement.Viewport', {
    extend: 'Ext.panel.Panel',
    requires: [
        //'Tualo.PaperVote.lazy.involvement.ManualGrid',
        'Tualo.PaperVote.lazy.involvement.models.Viewport',
        'Tualo.PaperVote.lazy.involvement.controller.Viewport'

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
