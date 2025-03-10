

Ext.define('Tualo.PaperVote.lazy.input.fsm.state.BNFehlt', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'blocknummer_fehlt',
    allowed: ['warte_auf_wahlschein_oder_blocknummer'],
    before: async function (data) {
        console.error('Blocknummer fehlt', data);
        this.getFSM().fireEvent('blocknummer_fehlt');
        this.getFSM().fireEvent('state', 'red');
        this.getFSM().fireEvent('message', 'Blocknummer fehlt');
        return true;
    },
    after: async function (data) {
        this.getFSM().transit('warte_auf_wahlschein_oder_blocknummer');
        return true;
    }
});
