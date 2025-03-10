
Ext.define('Tualo.PaperVote.lazy.input.fsm.state.WaWoB', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'warte_auf_wahlschein_oder_blocknummer',
    action: async function (inputCode) {
        console.log('warte_auf_wahlschein_oder_blocknummer', inputCode);
        if (inputCode.substring(0, 3) == 'FC7') {
            this.getFSM().fireEvent('clear_input');
            return this.getFSM().transit('blocknummer', inputCode);
        }
        if (!this.getFSM().fireEvent('check_forced_blocknummer')) {
            this.getFSM().fireEvent('clear_input');
            return this.getFSM().transit('blocknummer_fehlt', inputCode);
        }
        if (/[0-9]{8}/.test(inputCode)) {
            this.getFSM().fireEvent('clear_input');
            return this.getFSM().transit('wahlscheinnummer', inputCode);
        } else {
            console.error('ungültiger Code');
        }
        return true;
    },
    allowed: ['wahlscheinnummer', 'blocknummer', 'blocknummer_fehlt'],
});


