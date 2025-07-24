
Ext.define('Tualo.PaperVote.lazy.input.fsm.State', {
	extend: 'Ext.Base',
    config: {
        state: 'init',
        fsm: null,
        allowed: [],
    },
    
    constructor: function(config){
        this.initConfig(config);
        this.callParent([config]);
        console.log(config,this,this._state);
        if (config && config.allowed){
            this.allowed = [] 
            config.allowed.forEach((allow)=>{
                this.append(allow);
            });
        }
    },
    getName: function(){
        return this._state;
    },
    getFSM: function(){
        return this._fsm;
    },
    action: async function (...args) {
        console.warn('action','is not defined',this,this._state,args);
        return true;
    },
    before: async function (...args) {
        return true;
    },
    after: async function (...args) {
        return true;
    },
    allow: function(state){
        this.allowed.push(state);
    },
    getAllowed: function(){
        return this._allowed;
    },
});
