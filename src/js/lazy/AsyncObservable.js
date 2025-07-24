

Ext.define('Tualo.PaperVote.lazy.AsyncObservable', {
    extend: 'Ext.Mixin',
    mixinConfig: {
        id: 'async_observable',
    },
    constructor: function(config){
        let me = this,
            asyncListeners = (config && config.asyncListeners) || me.asyncListeners;
        if (Ext.isEmpty(asyncListeners)){
            asyncListeners = {};
        }
        me.asyncListeners = asyncListeners;
    },
    fireAsyncEvent: async function(eventName,eventType,...args){
        if (typeof this.asyncListeners[eventName]=='object' && typeof this.asyncListeners[eventName][eventType] == 'function'){
            return await this.asyncListeners[eventName][eventType].apply( this, args);
        }
        return true;
    }

});


fn = async function(){
    fsm = Ext.create('Tualo.PaperVote.lazy.input.Input', {});
    console.log(fsm.toMermaidChart());

    await fsm.transit('warte_auf_wahlschein_oder_blocknummer');
    await fsm.action('FC7175631625');
    console.log('---');
    await fsm.action('12345678');
    console.log('---');
    await fsm.action('FC201');
}

fn();