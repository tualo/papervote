Ext.define('Tualo.PaperVote.lazy.input.fsm.state.WaL', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'warte_auf_leeren',
    allowed: ['warte_auf_wahlschein_oder_blocknummer'],
    action: async function (inputCode) {
        this.getFSM().fireEvent('clear_input');
        if (inputCode == 'FC299') {
            return this.getFSM().transit('warte_auf_wahlschein_oder_blocknummer');
        }
        return false;
    }
});