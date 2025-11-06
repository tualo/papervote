Ext.define('Tualo.PaperVote.lazy.dashboard.State', {
    requires: [
        // 'Ext.chart.CartesianChart'
    ],
    extend: 'Ext.dashboard.Part',
    alias: 'part.tualodashboard_papervote_state',


    viewTemplate: {
        title: 'Briefwahl-Status',
        items: [
            {
                xtype: 'grid',
                store: {
                    type: 'json',
                    fields: [
                        { name: 'id', type: 'int' },
                        { name: 'name', type: 'string' },
                        { name: 'value', type: 'string' },
                        { name: 'color', type: 'string' },
                        { name: 'bold', type: 'boolean' }
                    ]
                },
                //height: 500,
                //border: true,
                hideHeaders: true,
                columns: [
                    { text: 'Name', dataIndex: 'name', flex: 1 },
                    {
                        text: 'Wert', dataIndex: 'value', flex: 1, align: 'right', renderer: function (value, meta, record) {
                            if (record.get('bold')) {
                                return '<span style="font-weight: bold;color:' + record.get('color') + ';">' + value + '</span>';
                            } else {
                                return '<span style="color:' + record.get('color') + ';">' + value + '</span>';
                            }
                        }
                    }
                    //   { text: 'Farbe', dataIndex: 'color', flex: 1 },
                    //   { text: 'Fett', dataIndex: 'bold', flex: 1 }
                ],
                listeners: {
                    boxready: async function (me) {
                        let data = await fetch('./papervote/status', {
                            headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/json"
                            },
                        }).then((response) => { return response.json() }),
                            list = [];
                        if (data.basistyp === 'stimmzettel') {
                            list.push({
                                name: 'Basistyp',
                                value: 'Stimmzettel',
                                color: 'green',
                                bold: true
                            });
                        }
                        if (data.basistyp === 'stimmzettelgruppen') {
                            list.push({
                                name: 'Basistyp',
                                value: 'Stimmzettelgruppen',
                                color: 'green',
                                bold: true
                            });
                        }

                        list.push({
                            name: 'Blockerfassung',
                            value: (data.force_blocknumber == '1') ? 'aktiv' : 'inaktiv',
                            color: 'green',
                            bold: true
                        });

                        if (data.owstate.remoteError === false) {
                            list.push({
                                name: 'Remote-Server',
                                value: 'erreichbar',
                                color: 'green',
                                bold: false
                            });
                        }
                        if (data.owstate.remoteError === true) {
                            list.push({
                                name: 'Remote-Server ',
                                value: 'nicht erreichbar',
                                color: 'red',
                                bold: true
                            });
                        }
                        if (data.owstate.starttime == null) {
                            list.push({
                                name: 'Wahlzeitraum (online)',
                                value: 'nicht konfiguriert',
                                color: 'red',
                                bold: true
                            });
                        } else {
                            let start = Ext.util.Format.date(new Date(data.owstate.starttime), 'd.m.Y H:i:s');
                            let stop = Ext.util.Format.date(new Date(data.owstate.stoptime), 'd.m.Y H:i:s');

                            if (
                                (new Date(data.owstate.starttime)).getTime() > (new Date(data.owstate.stoptime)).getTime()
                            ) {
                                list.push({
                                    name: 'Wahlzeitraum (online)',
                                    value: 'fehlerhaft konfiguriert',
                                    color: 'red',
                                    bold: true
                                });

                            } else {


                                if (
                                    (new Date(data.owstate.starttime)).getTime() <= Date.now() &&
                                    (new Date(data.owstate.stoptime)).getTime() >= Date.now()
                                ) {
                                    list.push({
                                        name: 'Wahl (online)',
                                        value: 'aktiv',
                                        color: 'green',
                                        bold: true
                                    });

                                } else if (
                                    (new Date(data.owstate.starttime)).getTime() > Date.now()
                                ) {
                                    list.push({
                                        name: 'Wahl (online)',
                                        value: 'nicht gestartet',
                                        color: 'darkgrey',
                                        bold: true
                                    });
                                } else if (
                                    (new Date(data.owstate.stoptime)).getTime() < Date.now()
                                ) {
                                    list.push({
                                        name: 'Wahl (online)',
                                        value: 'beendet',
                                        color: 'orange',
                                        bold: true
                                    });
                                }
                            }

                            list.push({
                                name: 'Start (online)',
                                value: start,
                                color: 'black',
                                bold: true
                            });

                            list.push({
                                name: 'Ende (online)',
                                value: stop,
                                color: 'black',
                                bold: true
                            });

                        }


                        list.push({
                            name: 'Webserver-Zeitzone (online)',
                            value: '' + data.owstate.timezone,
                            color: 'black',
                            bold: false
                        });
                        list.push({
                            name: 'Zeitabweichung (online)',
                            value: Math.abs(Math.round((new Date(data.owstate.php_time)).getTime() - (new Date(data.owstate.db_time)).getTime()) / 1000) + ' Sekunden',
                            color: (Math.round(Math.abs(Math.round((new Date(data.owstate.php_time)).getTime() - (new Date(data.owstate.db_time)).getTime()) / 1000) / 100) > 0 ? 'red' : 'black'),
                            bold: false
                        });
                        list.push({
                            name: 'aktive Wähler (online)',
                            value: data.owstate.active_voters,
                            color: 'black',
                            bold: false
                        });

                        me.getStore().loadData(list);
                    }
                }
            }
        ]
    }
});