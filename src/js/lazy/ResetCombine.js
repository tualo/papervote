Ext.define('Tualo.PaperVote.lazy.ResetCombine', {
    extend: "Ext.panel.Panel",
    requires: [
        'Tualo.PaperVote.lazy.controller.ResetCombine',
        'Tualo.PaperVote.lazy.models.ResetCombine',
        'Ext.layout.container.Card'
    ],
    controller: 'papervote_resetcombine',
    viewModel: {
        type:'papervote_resetcombine',
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
            
            handler: 'showNext',
            bind:{
                text: '{nextText}',
                disabled: '{nextDisabled}'
            }
        }
    ],
    items: [
        {
            id: 'card-0',
            html: '<h2>Wählerkombinationen zurücksetzen</h2><p>...</p>'
        },
        {
            id: 'card-1',
            xtype: 'form',
            items: [
                {
                    xtype: 'panel',
                    html: '<h2>Wählerkombinationen zurücksetzen</h2><p>Klicken Sie auf weiter, um eine Wählerkombination zu entfernen</p>'
                },
                {
                    xtype: 'textfield',
                    labelAlign: 'top',
                    width: '100%',
                    fieldLabel: 'Identnummer',
                    name: 'initial_ident',
                    allowBlank: false,
                    listeners: {
                        change: 'onInitialIdentChange'
                    },

                    bind: {
                        value: '{initial_ident}'
                    }
                },
                {
                    xtype: 'panel',
                    bind: {
                        html: '<h3>Wähler</h3>{voterHtml}'
                    }
                },
                {
                    xtype: 'panel',
                    bind: {
                        html: '{voterStatusHtml}'
                    }
                },
            ]
        }
    ]
});