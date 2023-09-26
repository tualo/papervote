/*
Ext.tualo.FSM = Ext.extend(Ext.util.Observable,  {
    extend: 'Ext.Base',
*/

Ext.define('Tualo.PaperVote.lazy.counting.FSM', {
	mixins: ['Ext.mixin.Observable'],
	extend: 'Ext.Base',
	begun: false,
	sep: '!',
	stateHist:[],
	states: {},
	transitions: {}, // stores valid state transition
	custEvents: {}, // stores custom events
	emitCustom: function (eventName, eventObj){
		var evq = this.custEvents[eventName];
		if (evq) {
			for (var i=0; i<evq.length; i++) {
				evq[i](eventObj);
			}
		}
	},
	constructor: function(config) {
		//this.initConfig(config);
		if (!config || !config.startingState){
		throw new Error('no starting state provided');
		}
		this.initConfig(config);  // We need to initialize the config options when the class is instantiated
		this.startingState = config.startingState;
		return this;
	},
	onBegin: function(f){
		this.beginFunc = f;
		return this;
	},
	begin: function(){
		if (!this.begun) {
			this.states[this.startingState]=true;
			this.stateHist.push(this.startingState);
			if (typeof this.beginFunc=="function") {this.beginFunc();}
			this.begun = true;
		}
		return this;
	},
	getState: function(){
		return this.stateHist[this.stateHist.length-1];
	},
	onTransit: function(){
		return this.allowTransit(arguments);
	},
	allowTransit: function(transition, action, action2, events, clobberable){
		if (transition.indexOf(this.sep)!=-1){
			throw new Error('transition string cannot contain "'+this.sep+'" character');
		}
		var tr = transition.split(/\s*=>\s*/);
		// clean up transition list and store the state
		for (var i=0;i<tr.length;i++){
			tr[i] = tr[i].replace(/^\s\s*/,'').replace(/\s\s*$/,'');
			this.states[tr[i]]=true;
		}
		// build string to internally store representation of transition
		var trStr = tr.join(this.sep);
		// populate all two-length transitions comprising transitions
		// of three or more but make them clobberable
		if (tr.length > 2) {
			for (var i=1;i<tr.length;i++){
				var newTransition = tr[i-1]+' => '+tr[i];
				this.onTransit(newTransition,null, null, null, true);
			}
		}
		var exst = !!this.transitions[trStr], // this transition already exists
		    clb = !!clobberable, // whether transition being added wants to be clobberable
		    write = !exst || (exst && !clb), // whether to write/overwrite this transition
		    err = exst && !clb && !this.transitions[trStr].clb; // whether to throw an error
		if (write) {
			this.transitions[trStr] = {
				pattern: new RegExp('(^|'+this.sep+')'+trStr+'$'),
				events: events?events.split(/\s+/):[],
				action: action,
				action2: action2,
				clb:!!clobberable
			};
		}
		if (err) {
			/*

			

			var v="";for(var ts in this.transitions){v+=","+ts;}console.log(v);
			var errMsg = 'cannot overwrite "'+transition
				+'" transition, already exists'
			throw new Error(errMsg);
			*/
		}
		return this;
	},
	on: function(event, action){
		var evq = this.custEvents[event];
		if (!evq) { this.custEvents[event] = evq = []; }
		evq.push(action);
		return this;
	},
	transit: function(toState, event){
		console.log("FSM transit: "+toState);
		if (!this.begun) { this.begin(); }
		event = event || {};
		var matchFound=false;
		hStr = this.stateHist.join(this.sep)+this.sep+toState;
		for (var trs in this.transitions) {
			if(!this.transitions.hasOwnProperty(trs)){continue;}
			var tr=this.transitions[trs];
			if (tr.pattern.test(hStr)){
				matchFound=true;
				if (tr.action) { tr.action(event); }
				for (var i=0;i<tr.events.length;i++){
					this.emitCustom(tr.events[i],event);
				}
			}
		}
		if(!matchFound){
			if(!this.states[toState]) {
				throw new Error('"'+toState+'" is not a valid state');
			} else {
				throw new Error('"'+this.getState()+' => '+toState+'" is not a valid transition');
			}
		} else {
			this.stateHist.push(toState);
			if (this.stateHist.length > 64) {
				this.stateHist.splice(0,8);
			}
			for (var trs in this.transitions) {
				if(!this.transitions.hasOwnProperty(trs)){continue;}
				var tr=this.transitions[trs];
				if (tr.pattern.test(hStr)){
					if (tr.action2) { tr.action2(event); }
				}
			}
		}
		return this;
	}
})
