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
                    labelAlign: 'top',
                    width: '100%',
                    fieldLabel: 'führende Identnummer',
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
        },
        {
            id: 'card-2',
            xtype: 'form',
            items: [
                {
                    xtype: 'panel',
                    html: '<h2>Wählerkombinationen erstellen</h2><p>Fügen Sie nun alle Identnummern ein, welche mit der führenden Identnummer kombiniert werden sollen.</p>'
                },
                {
                    xtype: 'textarea',
                    labelAlign: 'top',
                    width: '100%',
                    fieldLabel: 'Identnummern',
                    name: 'identnummern',
                    allowBlank: false,
                    listeners: {
                        change: 'onListIdentChange'
                    },
                    bind: {
                        value: '{identnummern}'
                    }
                },
                {
                    xtype: 'grid',
                    height: 300,
                    bind: {
                        store: '{identList}'
                    },
                    columns: [
                        {
                            text: 'Identnummer',
                            dataIndex: 'identnummer',
                            flex: 1
                        },
                        {
                            text: 'Name',
                            dataIndex: 'name',
                            flex: 1
                        },
                        {
                            text: 'Status',
                            dataIndex: 'status',
                            flex: 1,
                            renderer: function(value,metaData,record){
                                if (value){
                                    return '<span style="color:green"><i class="fas fa-check-circle"></i></span>';
                                }else{
                                    return '<span style="color:red"><i class="fas fa-hand-paper"></i></span>';
                                }
                            }
                        },
                        {
                            text: 'Hinweis',
                            dataIndex: 'message',
                            flex: 1
                        }
                    ]
                }
            ]
        },
    ]
});