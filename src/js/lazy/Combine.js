Ext.define('Tualo.PaperVote.lazy.Combine', {
    extend: "Ext.panel.Panel",
    requires: [
        'Tualo.PaperVote.lazy.controller.Combine',
        'Tualo.PaperVote.lazy.models.Combine',
        'Ext.layout.container.Card'
    ],
    controller: 'papervote_combine',
    viewModel: {
        type:'papervote_combine',
    },
    listeners: {
        boxready: 'onBoxReady'
    },
    layout: 'card',
    bodyPadding: 25,
    bbar: ['->',
        {
            itemId: 'card-prev',
            text: '&laquo; Zurück',
            handler: 'showPrevious',
            bind:{
                disabled: '{prevDisabled}'
            }
        },
        {
            itemId: 'card-next',
            text: 'Weiter &raquo;',
            handler: 'showNext',
            bind:{
                disabled: '{nextDisabled}'
            }
        }
    ],
    items: [
        {
            id: 'card-0',
            html: '<h2>Wählerkombinationen erstellen</h2><p>Klicken Sie auf weiter, um eine Wählerkombination zu erstellen</p>'
        },
        {
            id: 'card-1',
            xtype: 'form',
            items: [
                {
                    xtype: 'panel',
                    html: '<h2>Wählerkombinationen erstellen</h2><p>Klicken Sie auf weiter, um eine Wählerkombination zu erstellen</p>'
                },
                {
                    xtype: 'textfield',
                    fieldLabel: 'führende Identnummer',
                    name: 'initial_ident',
                    allowBlank: false,
                    listeners: {
                        change: 'onInitialIdentChange'
                    },

                    bind: {
                        value: '{initial_ident}'
                    }
                }
            ]
        },
    ]
});