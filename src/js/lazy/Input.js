Ext.define('Tualo.PaperVote.lazy.Input', {
    extend: 'Ext.panel.Panel',
    requires: [
        'Tualo.PaperVote.lazy.models.Input',
        'Tualo.PaperVote.lazy.controller.Input'
    ],
    alias: 'widget.papervote_input',
    controller: 'papervote_input',

    viewModel: {
        type: 'papervote_input'
    },
    listeners:{
            boxReady: 'onBoxReady'
    },

	layout: 'border',
    //title: 'Rücklauf',
  bind:{
    title: '{ftitle}'
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
				fields: ['waehler','zeichnungsberechtigter']
			},
			reference: 'centerlist',
			columns: [{
				header: 'Wähler',
				dataIndex: 'waehler',
				flex:1
			},{
				header: 'Zeichnungsberechtigter',
				dataIndex: 'zeichnungsberechtigter',
				flex:1
			}]
    }
	],
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
          style: 'font-size: 1.3em;line-height: 32px',
					reference: 'message'
				}
			]
    }
  ],
});
