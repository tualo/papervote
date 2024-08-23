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
            hidden: false,
            listeners: {
                select: 'onSelect'
            },

            bind: {
                store: '{papervote_optical}'
            },


            columns: [{
                header: 'ID',
                dataIndex: 'pagination_id',
                flex:1,
                renderer: function (value, metaData, record) {

                    if ((record.get('stimmzettelgruppen_ungueltig')==1)||(record.get('stimmzettelgruppen_ungueltig')===true)){
                        metaData.tdStyle = 'background-color: rgba(255,0,0,0.5);';
                    }

                    if ((record.get('stimmzettel_ungueltig')==1)||(record.get('stimmzettel_ungueltig')===true)){
                        metaData.tdStyle = 'background-color: rgba(255,100,0,0.5);';
                    }


                    if ((record.get('stimmzettelgruppen_enthaltung')==1)||(record.get('stimmzettelgruppen_enthaltung')===true)){
                        metaData.tdStyle = 'background-color: rgba(255,255,0,0.5);;';
                    }
                    if ((record.get('stimmzettel_enthaltung')==1)||(record.get('stimmzettel_enthaltung')===true)){
                        metaData.tdStyle = 'background-color: rgba(255,255,0,0.5);;';
                    }

                    return value;
                }
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
            scrollable: 'y',
            
            flex: 1,
            listeners: {
                select: 'onSelectCandidate'
            },
            hidden: true,
            store: {
                type: 'array',
                fields: [
                    'pagination_id',
                    'stimmzettel_id',
                    'stimmzettel_name',
                    'anzeige_name',
                    'pos',
                    'marked'
            ]
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
            split: true,
            itemId: 'image',
            flex: 3,
            region: 'center',
            src: '',
            //style: 'object-fit: contain; width: 100%; height: 100%;',
        
        }
	],
    /*
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
  ],*/
});
