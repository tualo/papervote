Ext.define('Tualo.PaperVote.lazy.Blockdocument', {
	extend: 'Ext.panel.Panel',
	
	requires: [
		'Tualo.PaperVote.lazy.models.Blockdocument',
		'Tualo.PaperVote.lazy.controller.Blockdocument'
	],

	alias: 'widget.papervote_lazy_blockdocument',
	controller: 'papervote_lazy_blockdocument',
	viewModel: {
		type: 'papervote_lazy_blockdocument'
	},
	listeners: {
		boxReady: 'onBoxReady'
	},
	
	layout: 'border',
	title: 'Blockdokument',
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
						keyup: 'onKeyup',
						focus: 'onFocus',
						blur: 'onBlur'
					}
				}
			]
		},
        {
            itemId: 'frame',
			region: 'center',
            xtype: 'tualoiframe',
            src: 'about:blank'
        }
	]
});