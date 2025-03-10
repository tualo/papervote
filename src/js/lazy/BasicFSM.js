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
            console.log('fireAsyncEvent',eventName,eventType,args);
            return await this.asyncListeners[eventName][eventType].apply( this, args);
        }
        return true;
    }

});


Ext.define('Tualo.PaperVote.lazy.BasicFSM', {
	mixins: ['Tualo.PaperVote.lazy.AsyncObservable'],
	extend: 'Ext.Base',
	begun: false,
    autoAppendErrorState: false,
    currentState: 'init',
    transitions: {
        init: ['end'],
        // error: ['end','error'],
        end: ['init']   
    },
    constructor: function(config){
        this.mixins.async_observable.constructor.call(this, config);
        this.initConfig(config);
        this.callParent([config]);
        this.transition('init');

    },
    action: function(...args){
        this.currentState.action.apply(this, args);
    },
    toMermaidChart: function(){
        var chart = 'stateDiagram-v2\n';
        chart += "\t[*] --> init\n";
        for (var trs in this.transitions) {
            if(!this.transitions.hasOwnProperty(trs)){continue;}
            for( var tr in this.transitions[trs]){
                if(!this.transitions[trs].hasOwnProperty(tr)){continue;}
                chart += "\t"+trs+ ' --> '+this.transitions[trs][tr]+'\n';
            }
        }
        chart += "\tend --> [*]\n";
        return chart
    },
    addTransition: function(from, to){
        if (!this.transitions[from]){
            this.transitions[from] = [ ];
            if (this.autoAppendErrorState){
                this.transitions[from].push('error');
            }
        }
        if (!this.transitions[to]){
            this.transitions[to] = [];
            if (this.autoAppendErrorState){
                this.transitions[from].push('error');
            }
        }
        this.transitions[from].push(to);
    },
    transition: async function(nextStateName){
        if (this.begun){
            if (this.transitions[this.currentState].indexOf(nextStateName)==-1){
                return;
                // this.transition('error');
                // throw new Error('Transition to unknown state: '+nextStateName);
            }
        }
        if (await this.fireAsyncEvent(nextStateName,'before',this)){
            this.begun = true;
            this.currentState = nextStateName;
            console.log( await  this.fireAsyncEvent(nextStateName,'after',this) );
        };
    }
});

async function sleep(fn, par) {
    return await setTimeout(async function() {
      await fn(par);
    }, 13000, fn, par);
  }

function testFSM(){
    console.log('testFSM');
    fsm = Ext.create('Tualo.PaperVote.lazy.BasicFSM', {
        asyncListeners: {
            init: {

                before: async function(fsm, state){
                    console.log('before_transition_init',fsm, state);
                    // laden der notwendigen datenstämme
                    return true;
                },

                after: async function(fsm, state){
                    console.log('after_transition_init',arguments);
                    fsm.transition('warte_auf_wahlschein_oder_blocknummer');
                    return true;
                },

            },
            warte_auf_wahlschein_oder_blocknummer: {
                before: async function(fsm, state){
                    console.log('before_transition_warte_auf_wahlschein_oder_blocknummer',fsm, state);
                    return true;
                },
                after: async function(fsm, state){
                    console.log('after_transition_warte_auf_wahlschein_oder_blocknummer',fsm, state);
                    return true;
                }
            },
            error: {
                after: async function(fsm, state){
                    console.log('error',fsm, state);
                    return false;
                }
            }
            

        }
    })
    fsm.addTransition('init','warte_auf_wahlschein_oder_blocknummer');

    fsm.addTransition('warte_auf_wahlschein_oder_blocknummer','blocknummer');
    fsm.addTransition('warte_auf_wahlschein_oder_blocknummer','wahlscheinnummer');
    fsm.addTransition('blocknummer','warte_auf_wahlschein_oder_blocknummer');


    fsm.addTransition('wahlscheinnummer','warte_auf_status');
    fsm.addTransition('warte_auf_status','status_gespeichert');
    fsm.addTransition('status_gespeichert','warte_auf_wahlschein_oder_blocknummer');

    console.log(fsm.toMermaidChart());

    /*
    setTimeout(()=>{
        fsm.transition('warte_auf_wahlschein_oder_blocknummer');
        setTimeout(()=>{
            fsm.transition('end');
            console.log('end>>>>',fsm);
        }, 3000);
    }, 3000);
    */
    console.log('testFSM',fsm);
}