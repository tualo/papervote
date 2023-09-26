Ext.define('Tualo.PaperVote.commands.models.Import', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.wm_pwgen_importcmd',
    data: {
        uploadSize: 1024*1024*2,
        uploadSizeText: '',
        nextDisabled: false,
        sheetname: '',
        columnname: ''
    },
    formulas: {

    }
    
});
  