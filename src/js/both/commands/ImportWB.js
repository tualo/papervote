Ext.define('Tualo.PaperVote.commands.ImportWB', {
    statics: {
        glyph: 'circle',
        title: 'Dateiupload',
        tooltip: 'nicht gesetzt'
    },
    requires: [
        'Ext.form.field.Text',
        'Ext.view.View',
        'Ext.data.Model',
        'Ext.data.Store',
        'Ext.panel.Panel',
        'Ext.form.field.Checkbox',
        'Ext.form.field.ComboBox',
        'Ext.tip.*'
    ],
    extend: 'Ext.panel.Panel',
    alias: ['widget.wm_wb_importcmd'],
    layout: 'fit',
    loadRecord: function (record, records, selectedrecords) {

    },
    layout: 'card',
    bodyPadding: '24px',
    items: [
        // UPLOAD FORM
        {
            xtype: 'form',
            fileUpload: true,
            items: [
                {
                    xtype: 'panel',
                    html: 'Bitte wählen Sie eine Excel.'
                },
                {
                    xtype: 'filefield',
                    fieldLabel: 'Datei',
                    name: 'userfile',
                    value: '',
                    anchor: '100%'
                }
            ],
            buttons: [{
                text: 'Hochladen',
                handler: function (btn) {
                    let view = btn.up('wm_wb_importcmd');

                    btn.up('form').getForm().submit({
                        url: './papervote/wahlberechtigte/upload',
                        params: {
                            t: this.tablename
                        },
                        timeout: 600000,
                        scope: this,
                        waitMsg: 'Die Datei wird hochgeladen...',
                        success: function (form, o) {
                            try {
                                var x = Ext.JSON.decode(o.response.responseText);
                                var ar = [];
                                var first = '';
                                for (var i = 0; i < x.data.length; i++) {
                                    if (first === '') {
                                        first = x.data[i].id;
                                    }
                                    ar.push([x.data[i].id, x.data[i].name]);
                                }

                                view.items.getAt(1).down('combobox').getStore().loadData(ar);
                                view.items.getAt(1).down('combobox').setValue(first);
                                view.getLayout().setActiveItem(1);

                            } catch (e) {
                                console.error(e);
                                Ext.MessageBox.show({
                                    title: 'Fehler',
                                    icon: Ext.MessageBox.ERROR,
                                    msg: 'Unbekannt ' + o.response.responseText,
                                    buttons: Ext.MessageBox.OK
                                });
                            }
                        },
                        failure: function (f) {
                            Ext.MessageBox.show({
                                title: 'Fehler',
                                buttons: Ext.MessageBox.OK,
                                icon: Ext.MessageBox.ERROR,
                                msg: 'Unbekannt' + ' ' + f.responseText
                            });

                        }

                    });
                }
            }]
        },

        // TABLE FORM
        {
            xtype: 'form',
            items: [
                {
                    xtype: 'panel',
                    html: 'Bitte wählen Sie das Tabellenblatt, welches Sie importieren wollen.'
                },
                {
                    xtype: 'combobox',
                    fieldLabel: 'Tabellenblatt',
                    anchor: '100%',
                    name: 'sheetname',
                    store: {
                        type: 'array',
                        fields: ['id', 'name'],
                        idIndex: 0
                    },
                    queryMode: 'local',
                    displayField: 'name',
                    valueField: 'id'
                }
            ],
            buttons: [{
                text: 'Importieren',
                handler: function (btn) {
                    let v = btn.up('form').getForm().getValues();

                    Tualo.Ajax.request({
                        scope: this,
                        timeout: 600000,
                        showWait: true,
                        params: {
                            sheetname: v.sheetname
                        },
                        url: './papervote/wahlberechtigte/process',
                        waitMsg: 'Die Datei wird geprüft...',
                        success: function (o) {
                            try {
                                console.log('o>>>>>', o);

                                var x = Ext.JSON.decode(o.responseText);
                                if (x.success === true) {

                                    Tualo.Ajax.request({
                                        scope: this,
                                        timeout: 600000,
                                        showWait: true,
                                        params: {
                                            sheetname: v.sheetname
                                        },
                                        url: './compiler',
                                        waitMsg: 'Das System wird compiliert ...',
                                        success: function (o) {
                                            try {
                                                console.log('o>>>>>', o);

                                                var x = Ext.JSON.decode(o.responseText);
                                                if (x.success === true) {

                                                    window.location.href = '#ds/view_pwgen_wahlberechtigte_anlage';
                                                    setTimeout(() => {
                                                        window.location.reload();
                                                    }, 1000);
                                                } else {
                                                    Ext.MessageBox.show({
                                                        title: 'Fehler',
                                                        buttons: Ext.MessageBox.OK,
                                                        icon: Ext.MessageBox.ERROR,
                                                        msg: x.msg
                                                    });
                                                }
                                            } catch (e) {
                                                console.log(e);
                                                Ext.MessageBox.show({
                                                    title: 'Fehler',
                                                    buttons: Ext.MessageBox.OK,
                                                    icon: Ext.MessageBox.ERROR,
                                                    msg: "Die Serverantwort konnte nicht gelesen werden"
                                                });
                                            }
                                        }
                                    });
                                } else {
                                    Ext.MessageBox.show({
                                        title: 'Fehler',
                                        buttons: Ext.MessageBox.OK,
                                        icon: Ext.MessageBox.ERROR,
                                        msg: x.msg
                                    });
                                }
                            } catch (e) {
                                console.log(e);
                                Ext.MessageBox.show({
                                    title: 'Fehler',
                                    buttons: Ext.MessageBox.OK,
                                    icon: Ext.MessageBox.ERROR,
                                    msg: "Die Serverantwort konnte nicht gelesen werden"
                                });
                            }
                        }
                    });
                }
            }]
        }
    ],
    buttons: [
        {
            text: 'Schliessen',
            handler: function (btn) {
                btn.up('wm_wb_importcmd').fireEvent('cancled');
            }
        }
    ]
});

