Ext.define('Tualo.PaperVote.lazy.monitor.Viewport', {
    extend: 'Ext.panel.Panel',
    requires: [
        'Tualo.PaperVote.lazy.monitor.models.Viewport',
        'Tualo.PaperVote.lazy.monitor.controller.Viewport'
    ],
    alias: 'widget.cmp_wm_wahlausschuss_mon',
    controller: 'cmp_wm_wahlausschuss_mon',
    viewModel: {
        type: 'cmp_wm_wahlausschuss_mon'
    },
    listeners: {
        boxReady: 'onBoxReady'
    },
    layout: {
        type: 'hbox',
        align: 'stretch'
    },

    dockedItems: [{
        xtype: 'toolbar',
        dock: 'top',
        reference: 'toolbar',
        items: [
            {
                xtype: 'label',
                text: 'Looper'
            }, {
                xtype: 'numberfield',
                bind: {
                    value: '{loopTimeout}'
                }
            }, {
                xtype: 'button',
                text: 'Start',
                handler: 'loop'
            }
        ]
    }],
    title: 'Wahlausschuss Monitor',
    items: [
        {
            xtype: 'grid',
            flex: 1,
            split: true,
            height: 400,
            reference: 'list',

            listeners: {
                select: 'onStimmzettelSelect'
            },
            bind: {
                store: '{view_protokoll_erwartet}'
            },
            dockedItems: [{
                xtype: 'pagingtoolbar',
                bind: {
                    store: '{view_protokoll_erwartet}',
                },
                dock: 'bottom',
                displayInfo: true
            }],
            features: [{
                //id: 'group',
                ftype: 'summary',
                dock: 'bottom'
                //groupHeaderTpl: '{name}',
                //hideGroupedHeader: true,
                //enableGroupingMenu: false
            }],
            columns: [{
                dataIndex: 'use_name',
                width: 300,
                sortable: true,
                hidden: false,
                text: 'Stimmzettel'
            }, {
                dataIndex: 'briefwahlstimmzettel_erwartet',
                align: 'right',
                width: 100,
                sortable: true,

                summaryType: function (records, values) {
                    var i = 0,
                        length = records.length,
                        total = 0,
                        group = {},
                        record;
                    for (; i < length; ++i) {
                        record = records[i];
                        if (typeof group[record.get('use_id')] == 'undefined') {
                            total += group[record.get('use_id')] = record.get('erwartet');
                        }
                    }
                    return total;
                },
                text: 'Erwartet',
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'briefwahlstimmzettel_anzahl',
                align: 'right',
                width: 100,
                sortable: true,
                text: 'Erfasst',
                summaryType: function (records, values) {
                    var i = 0,
                        length = records.length,
                        total = 0,
                        group = {},
                        record;
                    for (; i < length; ++i) {
                        record = records[i];
                        if (typeof group[record.get('use_id')] == 'undefined') {
                            total += group[record.get('use_id')] = record.get('gescannt');
                        }
                    }
                    return total;
                },
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'briefwahlstimmzettel_ungueltig',
                align: 'right',
                width: 100,
                sortable: true,
                //summaryType: 'sum',
                summaryType: function (records, values) {
                    var i = 0,
                        length = records.length,
                        total = 0,
                        group = {},
                        record;
                    for (; i < length; ++i) {
                        record = records[i];
                        if (typeof group[record.get('use_id')] == 'undefined') {
                            total += group[record.get('use_id')] = 1 * record.get('ungueltig');
                        }
                    }
                    return total;
                },
                text: 'Ungültig',
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'briefwahlstimmzettel_kontrolle',
                align: 'right',
                width: 100,
                sortable: true,
                //summaryType: 'sum',
                summaryType: function (records, values) {
                    var i = 0,
                        length = records.length,
                        total = 0,
                        group = {},
                        record;
                    for (; i < length; ++i) {
                        record = records[i];
                        if (typeof group[record.get('use_id')] == 'undefined') {
                            total += group[record.get('use_id')] = 1 * record.get('kontrolle');
                        }
                    }
                    return total;
                },
                hidden: true,
                text: 'Kontrolle',
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'briefwahl_quote',
                align: 'right',
                width: 100,
                sortable: true,
                //summaryType: 'average',
                summaryType: function (records, values) {
                    var i = 0,
                        length = records.length,
                        total_a = 0,
                        total_b = 0,
                        group = {},
                        record;
                    for (; i < length; ++i) {
                        record = records[i];
                        if (typeof group[record.get('use_id')] == 'undefined') {
                            total_a += group[record.get('use_id')] = 1 * record.get('briefwahlstimmzettel_ungueltig');
                            total_a += group[record.get('use_id')] = 1 * record.get('briefwahlstimmzettel_anzahl');
                            total_b += group[record.get('use_id')] = 1 * record.get('briefwahlstimmzettel_erwartet');
                        }
                    }
                    total = total_a / total_b;
                    return total;
                },
                hidden: false,
                renderer: function (v) {
                    if (isNaN(v)) {
                        v = 0;
                    }
                    return Ext.util.Format.percent(v, '0,000.00');
                },
                summaryRenderer: function (v) {
                    if (isNaN(v)) {
                        v = 0;
                    }
                    return Ext.util.Format.percent(v, '0,000.00');
                },
                header: 'Quote',

                xtype: 'numbercolumn'

            }]
        },


        {
            flex: 1,
            xtype: 'cartesian',
            reference: 'chart',
            minWidth: 500,
            insetPadding: 50,
            flipXY: true,

            captions: {
                title: '...',
                subtitle: '..',
                credits: '..'
            },
            //bind: {captions: '{getChartCaption}'},

            interactions: {
                type: 'itemedit',
                style: {
                    lineWidth: 2
                },
                tooltip: {
                    renderer: 'onItemEditTooltipRender'
                }
            },
            animation: {
                easing: 'easeOut',
                duration: 500
            },
            bind: {
                store: '{view_kandidaten_stimmenanzahl}'
            },
            axes: [
                {
                    type: 'numeric',
                    position: 'bottom',

                    fields: ['offlinestimmen', 'onlinestimmen'],
                    grid: true,
                    minimum: 0,
                    //maximum: 300,
                    //majorTickSteps: 10,
                    title: 'Stimmen',
                    renderer: 'onAxisLabelRender'
                },
                {
                    type: 'category',
                    position: 'left',
                    fields: 'barcode',
                    grid: true,
                    renderer: 'onCategoryRenderer',
                    label: {
                        textAlign: 'start'
                    }
                }
            ],
            legend: {
                docked: 'bottom'
            },
            series: [{
                type: 'bar',
                xField: 'barcode',
                title: ['Briefwahl', 'Onlinewahl'],
                yField: ['offlinestimmen', 'onlinestimmen'],
                style: {
                    opacity: 0.80,
                    minGapWidth: 10
                },
                highlightCfg: {
                    strokeStyle: 'black',
                    radius: 0
                },
                label: {
                    field: ['offlinestimmen', 'onlinestimmen'],
                    display: 'insideStart',
                    renderer: 'onSeriesLabelRender'
                },
                renderer: 'barRenderer',
                tooltip: {
                    trackMouse: true,
                    renderer: 'onSeriesTooltipRender'
                }
            }]
        }
    ],

});
