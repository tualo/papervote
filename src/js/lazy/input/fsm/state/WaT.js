Ext.define('Tualo.PaperVote.lazy.input.fsm.state.WaT', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'warte_auf_tan',
    allowed: ['warte_auf_wahlschein_oder_blocknummer'],
    before: async function (data, o) {
        console.log('(warte_auf_tan) before ', data, o);
        this._data = data;
        this._o = o;
        return true;
    },
    action: async function (inputCode) {

        let url = './papervote/return/tan/' + (this._o.data[0].wahlschein_id || this._o.data[0].id) + '/' + inputCode;
        let o = await (await fetch(url)).json();
        this.getFSM().fireEvent('clear_input');
        if (o.success) {
            this.getFSM().transit('warte_auf_wahlschein_oder_blocknummer');
            this.getFSM().fireEvent('message', 'Entsperrt');
            return this.getFSM().transit('wahlscheinnummer', this._data);
        } else {
            this.getFSM().fireEvent('state', 'red');
            this.getFSM().fireEvent('message', o.msg);
        }
        return true;
    }
});