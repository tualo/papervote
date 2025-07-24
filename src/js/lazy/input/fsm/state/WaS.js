Ext.define('Tualo.PaperVote.lazy.input.fsm.state.WaS', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'warte_auf_status',
    allowed: ['status_gespeichert'],
    action: async function (inputCode) {
        if (inputCode == 'FC201') {
            console.log('warte_auf_status', '>status_gespeichert');
        }
        this.getFSM().fireEvent('clear_input');
        return true;
    }
});