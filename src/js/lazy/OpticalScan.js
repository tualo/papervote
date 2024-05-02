Ext.define('Tualo.PaperVote.lazy.OpticalScan', {
    extend: 'Ext.panel.Panel',
    requires: [
        'Tualo.PaperVote.lazy.models.OpticalScan',
        'Tualo.PaperVote.lazy.controller.OpticalScan'
    ],
    alias: 'widget.papervote_opticalscan',
    controller: 'papervote_opticalscan',

    viewModel: {
        type: 'papervote_opticalscan'
    },
    listeners:{
            boxReady: 'onBoxReady'
    },

	layout: 'border',
    bind:{
        title: '{ftitle}'
    },
	items: [
            
        {
            xtype: 'grid',
            itemId: 'docs',
            region: 'west',
            flex: 1,
            listeners: {
                select: 'onSelect'
            },

            store: {
                type: 'array',
                fields: ['pagination_id','marks']
            },

            columns: [{
                header: 'ID',
                dataIndex: 'pagination_id',
                flex:1
            },{
                hidden: true,
                header: 'Markierungen',
                dataIndex: 'marks',
                flex:1
            }]
        },
        {
            xtype: 'grid',
            itemId: 'marks',
            region: 'east',
            flex: 1,
            listeners: {
                select: 'onSelectCandidate'
            },

            store: {
                type: 'array',
                fields: ['pagination_id',
                    'stimmzettel_id',
                    'stimmzettel_name',
                    'anzeige_name',
                    'pos',
                    'marked']
            },
            columns: [{
                header: 'Kandidat',
                dataIndex: 'anzeige_name',
                flex:1
            },{
                header: 'Gewählt',
                dataIndex: 'marked',
                flex:1
            }]
        },
        {
            xtype: 'component',
            itemId: 'image',
            flex: 3,
            region: 'center',
            src: '',
            style: 'object-fit: contain; width: 100%; height: 100%;',
        
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
