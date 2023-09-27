Ext.define('Ext.cmp.cmp_wm_beteiligung.Application', {
    extend: 'Ext.container.Viewport',
    requires:['Ext.tualo.QuickStore'],
    layout: 'anchor',
    items: [],
    renderTo: Ext.getBody(),
    initComponent: function(){
        Ext.Loader.setPath('Ext.cmp.cmp_wm_beteiligung', './cmp/cmp_wm_beteiligung/js/screens');
        this.callParent(arguments);
    },
    listeners: {
        scope: this,
        render: function(obj){
            
            Ext.require('Ext.cmp.cmp_wm_beteiligung.Viewport',function(){
                var p = Ext.create('Ext.cmp.cmp_wm_beteiligung.Viewport', {
                        component: cmp,  
                        anchor: '100% 100%',
                        title: cmp_title,
                        version: cmp_version
                }
                );
                    this.t.on('resize',function(o,w,h){
                        this.items.getAt(0).setSize(w,h);
                    },this.t);
                this.t.items.add(p);
            }
            ,
            {
                    t: obj 
            }
            );
        }
    }
})