Ext.define('Tualo.PaperVote.lazy.Rescan', {
	extend: 'Ext.panel.Panel',
	
	requires: [
		'Tualo.PaperVote.lazy.models.Rescan',
		'Tualo.PaperVote.lazy.controller.Rescan'
	],

	alias: 'widget.cmp_wm_nachzaehlung_viewport',
	controller: 'cmp_wm_nachzaehlung_viewport',
	viewModel: {
		type: 'cmp_wm_nachzaehlung_viewport'
	},
	listeners: {
		boxReady: 'onBoxReady'
	},
	
	layout: 'border',
	title: 'Nachkontrolle',
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
			xtype: 'grid',
			region: 'center',
			store: {
				type: 'array',
				fields: ['id']
			},
			reference: 'centerlist',
			columns: [{
				header: 'Wahlscheinnummer',
				dataIndex: 'id',
				flex: 1
			}]
		}
	]/*,
	dockedItems: [
		{
			xtype: 'toolbar',
			dock: 'bottom',
			reference: 'buttonDock'
		},
		{
			xtype: 'toolbar',
			dock: 'bottom',

			items: [
				{
					xtype: 'label',
					html: '',
					reference: 'message'
				}
			]
		}
	],
	*/
});