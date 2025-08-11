Ext.define('Tualo.PaperVote.lazy.controller.Rescan', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.cmp_wm_nachzaehlung_viewport',
    onBlur: function (fld) {
        var el = document.getElementById(fld.id + '-inputEl');
        el.style.backgroundColor = 'rgb(155,0,0)';
    },
    onFocus: function (fld) {
        var el = document.getElementById(fld.id + '-inputEl');
        el.style.backgroundColor = 'rgb(255,255,255)';
    },
    scrollIntoView: function (store, records, index) {
        /*
        var grid=this.lookupReference('centerlist'),
            gridview = grid.getView(),
            scroller = gridview.getScrollable(),
            store = grid.getStore(),
            sr = store.getRange();
        scroller.scrollTo(null, sr.length*50, true);
        */
    },
    onListAdd: function (store, records, index, eOpts) {
        //  Ext.Function.defer(this.scrollIntoView,500,this,[store, records, index]);
    },
    onListRemove: function (store, records, index, isMove, eOpts) {
        //  Ext.Function.defer(this.scrollIntoView,500,this,[store, records, index]);
    },

    onWahlscheinstatusLoad: function () {
        var me = this,
            vm = me.getViewModel(),
            wahlscheinstatus = vm.get('wahlscheinstatus'),
            store = vm.getStore('wahlscheinstatus');
        try {
            vm.set('wahlscheinstatusText', store.findRecord('id', wahlscheinstatus, 0, false, true, true).get('name'));
        } catch (e) {
            vm.set('wahlscheinstatusText', 'unbekannt');
        }
        console.log('wahlscheinstatusText', vm.get('wahlscheinstatusText'));
    },

    onAbgabetypLoad: function () {
        var me = this,
            vm = me.getViewModel(),
            abgabetyp = vm.get('abgabetyp'),
            store = vm.getStore('abgabetyp');
        try {
            vm.set('abgabetypText', store.findRecord('id', abgabetyp, 0, false, true, true).get('name'));
        } catch (e) {
            vm.set('abgabetypText', 'unbekannt');
        }
    },
    onBoxReady: function () {
        var me = this;


        var field = me.lookupReference('barcode');
        field.setValue('');
        field.focus();
    },
    disableButtons: function (state) {
        var me = this;
        me.ctrls.forEach(function (id) {
            Ext.getCmp(id).setDisabled(state);
        });
    },
    onKeyup: function (t, e, opt) {
        var me = this,
            vm = me.getViewModel(),
            wahlscheinstatus = vm.get('wahlscheinstatus'),
            abgabetyp = vm.get('abgabetyp'),
            typ = vm.get('typ');

        if (e.browserEvent.keyCode == 13 || e.browserEvent.keyCode == 10) {
            e.stopEvent();
            var v = t.getValue();
            // DV Code Trick!
            if ((v.substring(0, 2) == 'FC') || (isNaN(v) === false)) {
                t.el.dom.blur();
                var centerlist = this.lookupReference('centerlist');
                centerlist.getStore().insert(0, { id: v });


                t.disable();
                Tualo.Ajax.request({
                    url: './papervote/rescan/insert',
                    params: {
                        id: v,
                        wahlscheinstatus: wahlscheinstatus,
                        abgabetyp: abgabetyp,
                        typ: typ
                    },

                    json: function (o) {
                        if (o.success === true) {
                            t.setValue("");
                            t.enable();
                            t.focus();
                        } else {
                            Ext.Msg.alert('Fehler', o.msg);
                        }
                    }
                });
            } else {
                t.setValue("");
                t.focus();
            }
        }
    }
});