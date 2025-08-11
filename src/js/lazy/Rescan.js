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
	bind: {
		title: '{ftitle}'
	},

	config: {
		wahlscheinstatus: null,
		abgabetyp: null,
		typ: 'wahlscheinnummer'
	},
	applyWahlscheinstatus: function (wahlscheinstatus) {
		console.log('applyWahlscheinstatus', wahlscheinstatus);
		this.getViewModel().set('wahlscheinstatus', wahlscheinstatus);
		//this.getController().loadWahlscheinstatus();
		return wahlscheinstatus;
	},
	updateWahlscheinstatus: function (wahlscheinstatus) {
		console.log('updateWahlscheinstatus', wahlscheinstatus);
		this.getViewModel().set('wahlscheinstatus', wahlscheinstatus);
		//this.getController().loadWahlscheinstatus();
	},

	applyAbgabetyp: function (abgabetyp) {
		console.log('applyAbgabetyp', abgabetyp);
		this.getViewModel().set('abgabetyp', abgabetyp);
		//this.getController().loadAbgabetyp();
		return abgabetyp;
	},
	updateAbgabetyp: function (abgabetyp) {
		console.log('updateAbgabetyp', abgabetyp);
		this.getViewModel().set('abgabetyp', abgabetyp);
		//this.getController().loadAbgabetyp();
	},

	applyTyp: function (typ) {
		this.getViewModel().set('typ', typ);
		return typ;
	},
	updateTyp: function (typ) {
		console.log('updateTyp', typ);
		this.getViewModel().set('typ', typ);
	},

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
				header: 'Gescannt',
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