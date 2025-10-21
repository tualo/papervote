Ext.define('Tualo.PaperVote.lazy.SigningVoter', {
    extend: 'Ext.panel.Panel',

    alias: 'widget.papervote_lazy_check_signing_voter',

    layout: 'border',
    title: 'Identnummer suchen',
    items: [
        {
            xtype: 'dsview_view_wm_wahlschein_register_abgabe_zeichnungsberechtigt',
            region: 'west',
            width: 300
        },
        {

            xtype: 'tualoiframe',
            region: 'center',
            reference: 'iframe',
            src: './pugreporthtml/wm_berichte/wm_berichte_zeichnungsberechtigt_status',
            loadMask: 'Lade...'
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