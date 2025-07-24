Ext.define('Tualo.PaperVote.lazy.input.fsm.state.WNFehler', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'wahlschein_fehler',
    allowed: ['warte_auf_leeren'],
    before: async function (data, o) {
        console.log('(wahlschein_fehler) before ', data, o);

        this.getFSM().fireEvent('wahlscheinnummer', data);
        this.getFSM().fireEvent('state', 'red');
        this.getFSM().fireEvent('message', o.msg);

        return true;
    },
    after: async function (data) {
        return this.getFSM().transit('warte_auf_leeren');
    }
});