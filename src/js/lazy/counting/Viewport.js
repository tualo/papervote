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
                        metaData.tdAttr = "bgcolor=#0DA1FF";
                    }
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdAttr = "bgcolor=#FFFEC6";
                    }
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdAttr = "bgcolor=#9DFF99";
                    }
                    return v;
                }
            }, {
                header: 'Stimmzettel-Nr.',
                dataIndex: 'stimmzettelnr',
                flex: 1,
                renderer: function (v, metaData, record) {
                    metaData.tdAttr = "";
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdAttr = "bgcolor=#FFFEC6";
                    }
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdAttr = "bgcolor=#9DFF99";
                    }
                    return v;
                }
            }, {
                header: 'Kandidat-Nr.',
                dataIndex: 'code',
                flex: 1,
                renderer: function (v, metaData, record) {
                    metaData.tdAttr = "";
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdAttr = "bgcolor=#9DFF99";
                    }
                    return v;
                }
            }, {
                header: 'Kandidat-Name',
                dataIndex: 'name',
                flex: 4,
                renderer: function (v, metaData, record) {
                    metaData.tdAttr = "";
                    if (!Ext.isEmpty(record.get('stimmzettelnr')) && !Ext.isEmpty(record.get('kandidat'))) {
                        metaData.tdAttr = "bgcolor=#9DFF99";
                    }
                    if (!Ext.isEmpty(v)) {
                        v = "<b>" + v + "<b>";
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