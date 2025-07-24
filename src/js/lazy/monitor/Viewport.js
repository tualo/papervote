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
                store: '{view_stimmenanzahl_ranking_los_monitor_list}'
            },
            dockedItems: [{
                xtype: 'pagingtoolbar',
                bind: {
                    store: '{view_stimmenanzahl_ranking_los_monitor_list}',
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
                dataIndex: 'stimmzettel_name',
                width: 300,
                sortable: true,
                hidden: false,
                text: 'Stimmzettel'
            }, {
                dataIndex: 'stimmzettelgruppen_name',
                width: 300,
                sortable: true,
                hidden: true,
                summaryType: 'count',

                text: 'Stimmzettelgruppe'
            }, {
                dataIndex: 'erwartet',
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
                        if (typeof group[record.get('stimmzettel_ridx')] == 'undefined') {
                            total += group[record.get('stimmzettel_ridx')] = record.get('erwartet');
                        }
                    }
                    return total;
                },
                text: 'Erwartet',
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'gescannt',
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
                        if (typeof group[record.get('stimmzettel_ridx')] == 'undefined') {
                            total += group[record.get('stimmzettel_ridx')] = record.get('gescannt');
                        }
                    }
                    return total;
                },
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'ungueltig',
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
                        if (typeof group[record.get('stimmzettel_ridx')] == 'undefined') {
                            total += group[record.get('stimmzettel_ridx')] = 1 * record.get('ungueltig');
                        }
                    }
                    return total;
                },
                text: 'Ungültig',
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'kontrolle',
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
                        if (typeof group[record.get('stimmzettel_ridx')] == 'undefined') {
                            total += group[record.get('stimmzettel_ridx')] = 1 * record.get('kontrolle');
                        }
                    }
                    return total;
                },
                hidden: true,
                text: 'Kontrolle',
                xtype: 'numbercolumn',
                format: '0,000'
            }, {
                dataIndex: 'quote',
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
                        if (typeof group[record.get('stimmzettel_ridx')] == 'undefined') {
                            total_a += group[record.get('stimmzettel_ridx')] = 1 * record.get('ungueltig');
                            total_a += group[record.get('stimmzettel_ridx')] = 1 * record.get('gescannt');
                            total_b += group[record.get('stimmzettel_ridx')] = 1 * record.get('erwartet');
                        }
                    }
                    total = total_a / total_b;
                    return total;
                },
                hidden: false,
                renderer: function (v) {
                    return Ext.util.Format.percent(v, '0,000.00');
                },
                summaryRenderer: function (v) {
                    console.log('summaryRenderer', v);
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
                store: '{view_stimmenanzahl_ranking_los_monitor}'
            },
            axes: [
                {
                    type: 'numeric',
                    position: 'bottom',

                    fields: ['offline', 'online'],
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
                    fields: 'anzeige_name',
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
                xField: 'anzeige_name',
                title: ['Briefwahl', 'Onlinewahl'],
                yField: ['offline', 'online'],
                style: {
                    opacity: 0.80,
                    minGapWidth: 10
                },
                highlightCfg: {
                    strokeStyle: 'black',
                    radius: 0
                },
                label: {
                    field: ['offline', 'online'],
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
