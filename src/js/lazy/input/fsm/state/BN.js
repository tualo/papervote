

Ext.define('Tualo.PaperVote.lazy.input.fsm.state.BN', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'blocknummer',
    allowed: ['warte_auf_wahlschein_oder_blocknummer'],
    before: async function (data) {
        console.log('(blocknummer) before set UI Block auf', data);
        this.getFSM().fireEvent('blocknummer', data);
        return true;
    },
    after: async function (data) {
        console.log('(blocknummer) after', 'gehe zum nächtsen zustand');
        this.getFSM().transit('warte_auf_wahlschein_oder_blocknummer');
        return true;
    }
});
