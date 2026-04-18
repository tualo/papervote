Ext.define('Tualo.PaperVote.lazy.counting.Viewport', {
    extend: 'Ext.panel.Panel',
    requires: [
        'Tualo.PaperVote.lazy.counting.models.Viewport',
        'Tualo.PaperVote.lazy.counting.controller.Viewport',
        'Tualo.PaperVote.lazy.counting.FSM',
        'Tualo.PaperVote.lazy.counting.Logic'
    ],
    alias: 'widget.papervote_counting',
    controller: 'papervote_counting',
    viewModel: {
        type: 'papervote_counting'
    },
    listeners: {
        boxReady: 'onBoxReady'
    },
    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    items: [

        {
            xtype: 'form',
            reference: 'bcForm',
            autoHeight: true,
            items: [
                {
                    xtype: 'textfield',
                    anchor: '100%',
                    name: '_read_barcode',
                    reference: 'barcode',
                    emptyText: 'Barcode',
                    enableKeyEvents: true,
                    listeners: {
                        keyup: 'onKeyup',
                        focus: 'onFocus',
                        blur: 'onBlur'
                    }
                }
            ]
        },

        {
            xtype: 'grid',
            flex: true,
            bind: {
                store: '{list}'
            },
            reference: 'centerlist',
            columns: [{
                header: 'Stapel',
                dataIndex: 'stapel',
                flex: 1,
                renderer: function (v, metaData, record) {
                    metaData.tdAttr = "";
                    if (Ext.isEmpty(record.get('stimmzettelnr'))) {
                        metaData.tdStyle = "background-color:#0DA1FF;";
                        metaData.tdStyle += "color:#fff;";
                        metaData.tdStyle += "font-weight:bold;";

                        if (record.get('state') == 'stopStack') {
                            metaData.tdStyle = "background-color: #0D91EF;";
                            metaData.tdStyle += "color: #fffd;";
                            metaData.tdStyle += "font-weight:bold;";
                        }
                    }
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdStyle = "background-color: #FFFEC6;";

                        if (!Ext.isEmpty(record.get('pagination'))) {
                            metaData.tdStyle = "background-color: #fdec89;";
                        }
                    }
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdStyle = "background-color: #9DFF99;";
                    }
                    if (record.get('state') == 'stopStack') {
                        metaData.tdStyle += "border-bottom: 2px solid #7f7a7a;";
                    }
                    return v;
                }
            }, {
                header: 'Stimmzettel-Nr.',
                dataIndex: 'stimmzettelnr',
                flex: 1,
                renderer: function (v, metaData, record) {
                    metaData.tdAttr = "";
                    metaData.tdStyle = "";
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdStyle = "background-color: #FFFEC6;";
                        if (!Ext.isEmpty(record.get('pagination'))) {
                            metaData.tdStyle = "background-color: #fdec89;";
                            v = v + " (" + record.get('pagination') + ")";
                        }
                    }
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdStyle = "background-color: #9DFF99;";
                    }
                    if (record.get('state') == 'stopStack') {
                        metaData.tdStyle += "border-bottom: 2px solid #7f7a7a;";
                    }
                    return v;
                }
            }, {
                header: 'Kandidat-Nr.',
                dataIndex: 'code',
                flex: 1,
                renderer: function (v, metaData, record) {
                    metaData.tdStyle = "";
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdStyle = "background-color: #9DFF99;";
                    }
                    if (record.get('state') == 'stopStack') {
                        metaData.tdStyle += "border-bottom: 2px solid #7f7a7a;";
                    }
                    return v;
                }
            }, {
                header: 'Kandidat-Name',
                dataIndex: 'name',
                flex: 4,
                renderer: function (v, metaData, record) {
                    metaData.tdStyle = "";
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdStyle = "background-color:#9DFF99";
                    }
                    if (!Ext.isEmpty(v)) {
                        v = "<b>" + v + "<b>";
                    }
                    if (record.get('state') == 'stopStack') {
                        metaData.tdStyle += "border-bottom: 2px solid #7f7a7a;";
                    }
                    return v;
                }
            }]
        }

    ],
    dockedItems: [{

        xtype: 'panel',
        dock: 'bottom',

        layout: {
            type: 'hbox'
        },

        items: [
            {
                flex: 1,
                xtype: 'label',
                html: '',
                minHeight: 30,
                style: 'font-weight:bold;font-size:16pt;padding: 12px;',
                reference: 'message'
            }/*,'->'*/,
            {
                xtype: 'label',
                width: 340,
                html: '',
                reference: 'ampel'
            }
        ]
    }]

});