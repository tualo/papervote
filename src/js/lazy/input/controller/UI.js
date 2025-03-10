Ext.define('Tualo.PaperVote.lazy.input.controller.UI', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_input_ui',
    onBoxReady: function () {
        let me = this,
            list_length = 1,
            useident = false;
        if (this.getView().request && this.getView().request.list_length) {
            list_length = parseInt(this.getView().request.list_length);
        }

        if (this.getView().list_length) {
            list_length = parseInt(this.getView().list_length);
        }

        if (this.getView().useident && (this.getView().useident == '1')) {
            useident = true;
        }

        if (this.getView().request && this.getView().request.useident) {
            if (this.getView().request.useident == '1') {
                useident = true;
            }
        }
        me.getViewModel().set('list_length', list_length);
        me.getViewModel().set('useident', useident);

        me.fsm = Ext.create('Tualo.PaperVote.lazy.input.Input', {});
        me.initFSMEvents();
        console.log(me.fsm.toMermaidChart());
        me.fsm.transit('warte_auf_wahlschein_oder_blocknummer');


        //        me.test();

        setTimeout(function () {
            me.focus();
        }, 100);
    },
    focus: function () {
        let field = this.lookupReference('barcode');
        field.focus();
    },
    test: async function () {
        let me = this;
        await me.fsm.transit('warte_auf_wahlschein_oder_blocknummer');
        await me.fsm.action('FC7175631625');
        console.log('---');
        await me.fsm.action('12345678');
        console.log('---');
        await me.fsm.action('FC201');
    },

    initFSMEvents: function () {
        let me = this;

        me.fsm.on('state', function (type) {
            if (type == 'red') {
                me.getView().setStyle('background-color', 'red');
                try {
                    var audio = new Audio('./papervote/sounds/sms-alert-1-daniel_simon.mp3');
                    audio.play();
                } catch (e) { }

            }
            if (type == 'green') {
                me.getView().setStyle('background-color', 'green');
            }

        }, me);

        me.fsm.on('message', me.onMessage, me);
        me.fsm.on('blocknummer', me.onBlocknummer, me);
        me.fsm.on('check_forced_blocknummer', me.onCheckForcedBlocknummer, me);
        me.fsm.on('useident', me.onUseIdent, me);
        me.fsm.on('checkallowedtype', me.onCheckAllowedType, me);
        me.fsm.on('checkallowedstate', me.onCheckAllowedState, me);
        me.fsm.on('clear_input', me.onClearInput, me);



    },
    onClearInput: function () {
        this.lookupReference('barcode').setValue('');
    },
    onCheckAllowedType: function (abgabetyp) {
        let me = this,
            list = [],
            store = me.getViewModel().getStore('abgabetyp_offline_erlaubt');

        store.clearFilter();
        let pos = store.findBy(function (record) {
            return (record.get('abgabetyp') == abgabetyp);
        });
        console.log('onCheckAllowedType', abgabetyp, pos);
        if (pos >= 0) {
            return true;
        } else {
            return false;
        }
    },
    onCheckAllowedState: function (abgabetyp, wahlscheinstatus) {
        let me = this,
            list = [],
            store = me.getViewModel().getStore('wahlscheinstatus_offline_erlaubt');

        store.clearFilter();
        let pos = store.findBy(function (record) {
            return (record.get('abgabetyp') == abgabetyp && record.get('wahlscheinstatus') == wahlscheinstatus);
        });
        console.log('onCheckAllowedState', abgabetyp, wahlscheinstatus, pos);
        if (pos >= 0) {
            return true;
        } else {
            return false;
        }
    },
    onUseIdent: function () {
        return this.getViewModel().get('useident');
    },
    onCheckForcedBlocknummer: function () {
        if (this.getViewModel().get('forceblocknumber') == false) {
            return true;
        } else {
            if (this.getViewModel().get('blocknumber') != '') {
                return true;
            }
        }
        return false;
    },

    onMessage: function (message) {
        this.lookupReference('message').setHtml(message);
    },

    onBlocknummer: function (nummer) {
        this.getViewModel().set('blocknumber', nummer);
    },

    onBlur: function (fld) {
        var el = document.getElementById(fld.id + '-inputEl');
        el.style.backgroundColor = 'rgb(155,0,0)';
    },
    onFocus: function (fld) {
        var el = document.getElementById(fld.id + '-inputEl');
        el.style.backgroundColor = 'rgb(255,255,255)';
    },
    onKeyup: function (t, e, opt) {

        if (e.browserEvent.keyCode == 13 || e.browserEvent.keyCode == 10) {
            e.stopEvent();
            this.fsm.action(t.getValue());
            /*
            var v = t.getValue().replace(/[^0-9]/g, "");
            // DV Code Trick!
            if ((v.substring(0, 2) == 'FC') || (isNaN(v.substr(2)) === false)) {
                t.el.dom.blur();
                this.fsm.action(v);
            } else {
                t.setValue("");
                t.focus();
            }*/
        }
    },
});