Ext.define('Tualo.PaperVote.lazy.models.Combine', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.papervote_combine',
    data:{
        currentCardIndex: 0,
        initial_ident: null,
        identnummern: null,
        voterData: null,
        hasError: false,
        inProgress: false,
        listOk : false,
        errorMessage: '',
    },
    formulas: {
        nextText: function(get){
            if (get('currentCardIndex')==0) return 'Weiter &raquo;';
            if (get('currentCardIndex')==1) return 'Weiter &raquo;';
            if (get('currentCardIndex')==2) return 'Kombinieren &raquo;';
        },
        prevDisabled: function(get){
            if (get('currentCardIndex')==0) return true;
            if (get('inProgress')) return true;

            return false;
        },
        nextDisabled: function(get){
            if ((get('currentCardIndex')==1) && ( Ext.isEmpty( get('initial_ident') ) )) return true;
            if ((get('currentCardIndex')==2) && ( !get('listOk') )) return true;
            if (get('hasError')) return true;
            if (get('inProgress')) return true;

            return get('currentCardIndex')<0;
        },
        currentCard: function(get){
            return  'card-'+ get('currentCardIndex');
        },
        voterStatusHtml: function(get){
            if (get('hasError')){
                return '<span style="color:red">'+get('errorMessage')+'</span>';
            }else{

                if (!Ext.isEmpty(get('voterData')) && get('voterData').wahlscheinstatus=='1|0') return '<span style="color:green"><i class="fas fa-check-circle"></i></span>';
                return '<span style="color:red"><i class="fas fa-hand-paper"></i></span>';
            }
        }
    },
    stores: {
      ruecklauffelder: {
        autoLoad: false,
        type: 'ruecklauffelder_store',
        listeners: {
          load: 'onRuecklauffelderLoad'
        }
      },
      identList: {
        autoLoad: false,
        type: 'json',
        fields: [
            {
                name: 'identnummer',
                type: 'string'
            },
            {
                name: 'status',
                type: 'boolean',
                defaultValue: false
            },
            {
                name: 'name',
                type: 'string'
            },
            {
                name: 'message',
                type: 'string'
            }
        ]
      },
    }
});