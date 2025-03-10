
Ext.define('Tualo.PaperVote.lazy.input.FSM', {
    mixins: ['Ext.mixin.Observable'],
    // mixins: ['Tualo.PaperVote.lazy.AsyncObservable'],
    extend: 'Ext.Base',
    constructor: function (config) {
        let me = this;
        this.mixins.observable.constructor.call(this, config);
        me.initConfig(config);
        me.callParent([config]);
        console.log(config);
        console.log(me.states);

        if (config && config.states) {
            me.states = config.states;
        }

        me._states = [];
        me.states.forEach((state) => {
            if (typeof state == 'string') {
                state = Ext.create(state, { fsm: me });
            }
            me.append(state);
        });
    },
    currentState: 'init',
    startState: null,
    append: function (state) {
        if (Ext.isEmpty(this.startState)) {
            this.startState = state.getName();
        }
        this._states[state.getName()] = state;
    },
    action: async function (...args) {
        if (this._states[this.currentState]) {
            await this._states[this.currentState].action.apply(this._states[this.currentState], args);
        }
    },
    transit: async function (state, ...args) {


        if (this._states[state]) {
            if (await this._states[state].before.apply(this._states[state], args)) {
                this.currentState = state;
                if (!await this._states[state].after.apply(this._states[state], args)) {
                    return false;
                }
            }
        } else {
            throw new Error('state "' + state + '" not found');
        }
    },



    toMermaidChart: function () {
        var chart = 'stateDiagram-v2\n';
        chart += "\t[*] --> " + this.startState + "\n";
        for (let stateName in this._states) {
            if (!this._states.hasOwnProperty(stateName)) { continue; }
            let allowed = this._states[stateName].getAllowed();
            allowed.forEach((allowedState) => {
                chart += "\t" + stateName + ' --> ' + allowedState + '\n';
            });
        }
        // chart += "\tend --> [*]\n";
        return chart
    },

});
