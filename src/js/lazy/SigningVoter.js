Ext.define('Tualo.PaperVote.lazy.SigningVoter', {
    extend: 'Ext.panel.Panel',

    alias: 'widget.papervote_lazy_check_signing_voter',

    layout: {
        type: 'hbox',

        align: 'stretch'
    },
    title: 'Unklare zeichnungsberechtigte Wähler',
    items: [
        {
            xtype: 'dsview_view_wm_wahlschein_register_abgabe_zeichnungsberechtigt',

            itemId: 'liste',
            region: 'west',
            listeners: {
                recordselect: function (record) {
                    const iframe = this.up('panel').getComponent('x').getComponent('iframe');
                    this.up('panel').wahlschein_id = record.get('id');
                    if (record) {
                        const url = `./pugreporthtml/wm_berichte/wm_berichte/wm_berichte_zeichnungsberechtigt_status?wahlschein_id=${record.get('id')}`;
                        iframe.load(url);
                    } else {
                        iframe.load('about:blank');
                    }
                }
            },
            border: true,
            flex: 1,
        },
        {
            title: "Bericht",
            layout: 'fit',
            itemId: 'x',
            border: true,
            flex: 1,
            tbar: [
                // print button
                {
                    text: 'Drucken',
                    iconCls: 'x-fa fa-print',
                    handler: function () {
                        const iframe = this.up('panel').getComponent('iframe');

                        iframe.getEl().dom.querySelector('iframe').contentWindow.focus();
                        iframe.getEl().dom.querySelector('iframe').contentWindow.print();
                    }
                }
            ],

            items: [
                {
                    xtype: 'tualoiframe',
                    region: 'center',
                    itemId: 'iframe',
                    src: './pugreporthtml/wm_berichte/wm_berichte/wm_berichte_zeichnungsberechtigt_status',
                    loadMask: 'Lade...'
                }
            ]
        }
    ],
    bbar: [

        {
            text: 'Annehmen',
            iconCls: 'x-fa fa-solid fa-circle-check',
            style: { backgroundColor: "lightgreen" },
            handler: async function () {
                let url = './papervote/signing/save';
                let response = await (await fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        wahlscheinstatus: 2,
                        wahlschein_id: this.up('panel').wahlschein_id
                    })
                })
                ).json();
                if (response.success) {
                    this.up('panel').getComponent('liste').getStore().load();
                } else {
                    Ext.Msg.alert('Fehler', response.msg);
                }
            }
        },
        '|'
        ,
        {
            text: 'Ablehnen',
            iconCls: 'x-fa fa-solid fa-circle-xmark',
            style: { backgroundColor: "rgba(255,80,80,0.5)" },
            handler: async function () {
                let url = './papervote/signing/save';
                let response = await (await fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        wahlscheinstatus: 3,
                        wahlschein_id: this.up('panel').wahlschein_id
                    })
                })
                ).json();
                if (response.success) {
                    this.up('panel').getComponent('liste').getStore().load();
                } else {
                    Ext.Msg.alert('Fehler', response.msg);
                }
            }
        },

        '->',
        {
            text: 'Klärung',
            iconCls: 'x-fa fa-solid fa-circle-exclamation',
            style: { backgroundColor: "lightblue" },
            handler: async function () {
                let url = './papervote/signing/save';
                let response = await (await fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        wahlscheinstatus: 8,
                        wahlschein_id: this.up('panel').wahlschein_id
                    })
                })
                ).json();
                if (response.success) {
                    this.up('panel').getComponent('liste').getStore().load();
                } else {
                    Ext.Msg.alert('Fehler', response.msg);
                }
            }
        }
    ]
});