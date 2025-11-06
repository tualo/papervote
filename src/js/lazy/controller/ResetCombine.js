Ext.define('Tualo.PaperVote.lazy.controller.ResetCombine', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_resetcombine',
    onBoxReady: function () {
        let me = this,
            vm = me.getViewModel(),
            ruecklauffelderStore = vm.getStore('ruecklauffelder');

        ruecklauffelderStore.load({
            params: {
                filter: Ext.JSON.encode([{ property: 'aktiv', value: '1', operator: 'eq' }])
            }
        });

    },
    onInitialIdentChange: function (field, newValue, oldValue, eOpts) {
        let me = this,
            vm = me.getViewModel();
        console.log('onInitialIdentChange', field, newValue, oldValue, eOpts);
        me.checkIdent(newValue);

    },

    getNameHtml: function (dataItem) {
        let me = this,
            html = '',
            vm = me.getViewModel(),
            ruecklauffelderStore = vm.getStore('ruecklauffelder');
        ruecklauffelderStore.getRange().forEach(function (ruecklauffeld) {
            if (Ext.isEmpty(dataItem[ruecklauffeld.get('column_name')])) {
                html += '<br/>';
            } else {
                html += '<span>' + dataItem[ruecklauffeld.get('column_name')] + '</span><br/>';
            }

        });
        return html;
    },


    checkIdent: async function (identnummer) {
        let me = this,
            vm = me.getViewModel(),
            res = null,
            dataItem = null,
            html = '';
        try {
            vm.set('inProgress', true);
            res = await fetch('./papervote/identnummer/' + identnummer, {
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
            }).then((response) => response.json());
            if (res.success) {
                dataItem = res.data[0];
                vm.set('initial_ident', identnummer);
                vm.set('voterData', dataItem);
                vm.set('hasError', false);
                vm.set('errorMessage', '');
                html = me.getNameHtml(dataItem);
                if (dataItem.wahlschein_kombiniert == identnummer) {
                    vm.set('hasError', true);
                    vm.set('errorMessage', 'Die Identnummer ist nicht kombiniert!');
                }
                if (dataItem.wahlscheinstatus != '1|0') {
                    vm.set('hasError', true);
                    vm.set('errorMessage', 'Der Wahlscheinstatus kann nicht verwendet werden!');
                }
                vm.set('voterHtml', html);
            } else {
                vm.set('voterHtml', 'nicht gefunden!');
                vm.set('voterData', null);
                vm.set('hasError', true);
                vm.set('errorMessage', res.message);
            }
        } catch (e) {
            vm.set('hasError', true);
            vm.set('errorMessage', e.message);
        } finally {
            vm.set('inProgress', false);
        }
    },


    showNext: function () {
        this.doCardNavigation(1);
    },

    showPrevious: function (btn) {
        this.doCardNavigation(-1);
    },

    doCardNavigation: async function (incr) {
        let me = this,
            l = me.getView().getLayout(),
            i = l.activeItem.id.split('card-')[1],
            next = parseInt(i, 10) + incr,
            vm = me.getViewModel();

        if (next == 2) {
            let res = await fetch('./papervote/combine/reset/' + vm.get('initial_ident'), {
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
            }).then((response) => response.json());
            if (res.success) {
                alert('Die Kombination wurde erfolgreich entfernt!');
                next = 0;
            } else {
                alert('Die Kombination konnte nicht entfernt werden!');
                return;
            }

            // 
        }

        l.setActiveItem(next);
        vm.set('currentCardIndex', next);

    }
});