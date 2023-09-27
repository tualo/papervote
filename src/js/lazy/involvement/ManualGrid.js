Ext.define('Ext.cmp.cmp_wm_beteiligung.ManualGrid', {
    extend: 'Ext.panel.Panel',
    layout: 'fit',
    constructor: function(config) {

        this.callParent([config]);


    },
    initComponent: function(){

        var fields = new Array();
        var columns = new Array();
        columns.push({
            header: "Wahlgruppe / Wahlbezirk",
            dataIndex: 'name',
            flex: 1,
            sortable: true
        });
        fields.push({name:'name',type: 'string'});
        fields.push({name:'ridx',type: 'string'});


        var ohne_wahlberechtigten=this.ohne_wahlberechtigten;
        for(var i=0;i<ohne_wahlberechtigten.length;i++){
            var dataIndex = 'anzahl_'+ohne_wahlberechtigten[i].get('ohne_wahlberechtigten__id');
            var headerName = ohne_wahlberechtigten[i].get('ohne_wahlberechtigten__name');

            columns.push({
                header: headerName,
                dataIndex: dataIndex,
                sortable: true,
                xtype: 'numbercolumn',
                editor: {
                    selectOnFocus: true
                },
                format:'0,000',
                align: 'right'
            });
            fields.push({name: dataIndex,type: 'int'});
        }

        this.store = Ext.create('Ext.tualo.JsonStore', {
            fields:fields,
            pageSize: 1000,
            proxy: {
                type: 'ajax',
                url: './index.php',

                extraParams: {
                    TEMPLATE: 'NO',
                    sid: sid,
                    cmp: 'cmp_wm_beteiligung',
                    typ: '1|0',
                    p: 'ajax/manual'
                },
                reader: {
                    type: 'json',
                    root: 'data'
                }
            }
        });

        this.grid = Ext.create('Ext.tualo.Grid', {
            store: this.store,
            columns: columns,
            plugins: [
                new Ext.grid.plugin.CellEditing({
                    clicksToEdit: 1
                })
            ],
            tbar:[
                {
                    text: 'Speichern',
                    scope: this,
                    handler: this.saveData
                }
            ]
        });
        this.items = [this.grid];



        this.callParent(arguments);
        this.store.load();
    },
    saveData: function(){
        var me=this;
        Ext.MessageBox.wait('Bitte warten...','Die Daten werden gespeichert');
        Ext.Ajax.request({
          url: './index.php',
            params: {
                TEMPLATE: 'NO',
                sid: sid,
                cmp: 'cmp_wm_beteiligung',
                typ: '1|0',
                p: 'ajax/save',
                list: Ext.JSON.encode(this.grid.serialize())
            },
            timeout: 600000,
            success: function(f, a){
                Ext.MessageBox.hide();
                var o = Ext.JSON.decode(f.responseText);
                me.store.load();
            },
            failure: function(f){
                Ext.MessageBox.hide();
                Ext.MessageBox.alert('Fehler '+f.responseText);
            }
        });
    }
});
