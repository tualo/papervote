Ext.define('Tualo.PaperVote.lazy.input.Input', {
    extend: 'Tualo.PaperVote.lazy.input.FSM',
    requires: [
        'Tualo.PaperVote.lazy.input.fsm.state.WaWoB',
        'Tualo.PaperVote.lazy.input.fsm.state.BN',
        'Tualo.PaperVote.lazy.input.fsm.state.WN',
        'Tualo.PaperVote.lazy.input.fsm.state.WaS',
        'Tualo.PaperVote.lazy.input.fsm.state.SG',
        'Tualo.PaperVote.lazy.input.fsm.state.BNFehlt',
        'Tualo.PaperVote.lazy.input.fsm.state.WaL',
        'Tualo.PaperVote.lazy.input.fsm.state.WNFehler',
        'Tualo.PaperVote.lazy.input.fsm.state.WaT'
    ],

    states: [
        'Tualo.PaperVote.lazy.input.fsm.state.WaWoB',
        'Tualo.PaperVote.lazy.input.fsm.state.BN',
        'Tualo.PaperVote.lazy.input.fsm.state.WN',
        'Tualo.PaperVote.lazy.input.fsm.state.WaS',
        'Tualo.PaperVote.lazy.input.fsm.state.SG',
        'Tualo.PaperVote.lazy.input.fsm.state.BNFehlt',
        'Tualo.PaperVote.lazy.input.fsm.state.WaL',
        'Tualo.PaperVote.lazy.input.fsm.state.WNFehler',
        'Tualo.PaperVote.lazy.input.fsm.state.WaT'
    ],
});