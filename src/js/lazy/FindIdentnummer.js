Ext.define('Tualo.PaperVote.lazy.FindIdentnummer', {
	extend: 'Ext.panel.Panel',
	
    /*
	requires: [
		'Tualo.PaperVote.lazy.models.Rescan',
		'Tualo.PaperVote.lazy.controller.Rescan'
	],
    */

	alias: 'widget.cmp_wm_find_identnummer_viewport',
    /*
	controller: 'cmp_wm_nachzaehlung_viewport',
	viewModel: {
		type: 'cmp_wm_nachzaehlung_viewport'
	},
	listeners: {
		boxReady: 'onBoxReady'
	},
    */
	
	layout: 'border',
	title: 'Identnummer suchen',
	items: [
		{
        
            xtype: 'form',
            reference: 'bcForm',
            region: 'north',
            items: [
              {
                xtype: 'textfield',
                anchor: '100%',
                name: '_read_barcode',
                reference: 'barcode',
                emptyText: 'Barcode',
                enableKeyEvents: true,
                listeners: {
                  keyup: async function(fld){
                    if (fld.getValue().length>0){
                        let v = fld.getValue();
                        fld.setValue('');
                        let url = './papervote/wahlschein/'+v;
                        let o = await (await fetch(url)).json()
                        if (o.success) {
                            fld.up().up().getComponent('display').setHtml('<b>'+ o.data[0].identnummer+'</b>');
                        }else{
                            alert(o.msg);
                        }
                    }
                  }
                }
              }
            ]
          },
          {
            xtype: 'panel',
            itemId: 'display',
            reference: 'display',
            region: 'center',
            html: ''
          }
	]
});