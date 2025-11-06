Ext.define('Tualo.PaperVote.lazy.input.fsm.state.WN', {
    extend: 'Tualo.PaperVote.lazy.input.fsm.State',
    state: 'wahlscheinnummer',
    allowed: ['warte_auf_status', 'wahlschein_fehler', 'warte_auf_tan'],
    before: async function (data) {
        console.log('(wahlscheinnummer) before ', data);

        let useident = this.getFSM().fireEvent('useident');
        let url = (useident === true) ? ('./papervote/identnummer/' + data) : ('./papervote/wahlschein/' + data);
        let o = await (await fetch(url, {
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
        })).json()

        if (o && o.success) {
            // teste ob zustand erlaubt ist
            this.getFSM().fireEvent('wahlscheinnummer', data);

            for (let i = 0; i < o.data.length; i++) {
                if (!this.getFSM().fireEvent('checkallowedtype', o.data[i].abgabetyp)) {
                    return this.getFSM().transit('wahlschein_fehler', data, { msg: 'Der Abgabetyp ist nicht zulässig' });
                }
            }
            for (let i = 0; i < o.data.length; i++) {
                if (!this.getFSM().fireEvent('checkallowedstate', o.data[i].abgabetyp, o.data[i].wahlscheinstatus)) {
                    // To Do, wenn verschiedene Zustände enhalten, dann testen!
                    return this.getFSM().transit('warte_auf_tan', data, o);
                }
            }
            this.getFSM().fireEvent('state', 'green');
            this.getFSM().fireEvent('message', 'Wahlscheinnummer ' + data + ' ist gültig');


        } else {
            return this.getFSM().transit('wahlschein_fehler', data, o);
        }

        return true;
    },
    after: async function (data) {
        console.log('(wahlscheinnummer) after', 'gehe zum nächtsen zustand', data);
        return this.getFSM().transit('warte_auf_status');
    }
});