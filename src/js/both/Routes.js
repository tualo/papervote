
Ext.define('Tualo.routes.PaperVoteReturn', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/return',
                    path: '#papervote/return'
                }
            ]
        }
    }, 
    url: 'papervote/return',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.Viewport');
        },
        before: function (action) {
            action.resume();
        }
    }
});


Ext.define('Tualo.routes.PaperVoteCounting', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/counting',
                    path: '#papervote/counting'
                }
            ]
        }
    }, 
    url: 'papervote/counting',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.counting.Viewport');
        },
        before: function (action) {
            
            action.resume();
        }
    }
});



Ext.define('Tualo.routes.PaperVoteReset', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/reset',
                    path: '#papervote/reset'
                }
            ]
        }
    }, 
    url: 'papervote/reset',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Reset');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});


Ext.define('Tualo.routes.PaperVoteRescan', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/rescan',
                    path: '#papervote/rescan'
                }
            ]
        }
    }, 
    url: 'papervote/rescan',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Rescan');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});




Ext.define('Tualo.routes.PaperVoteMonitor', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/monitor',
                    path: '#papervote/monitor'
                }
            ]
        }
    }, 
    url: 'papervote/monitor',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.monitor.Viewport');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});



Ext.define('Tualo.routes.PaperVoteInvolvement', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/involvement',
                    path: '#papervote/involvement'
                }
            ]
        }
    }, 
    url: 'papervote/involvement',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.involvement.Viewport');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});



Ext.define('Tualo.routes.PaperVoteStacks', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/stacks',
                    path: '#papervote/stacks'
                }
            ]
        }
    }, 
    url: 'papervote/stacks',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.stacks.Viewport');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});


Ext.define('Tualo.routes.PaperVoteInvolvementDynamic', {
    statics: {
        load: async function() {
            let list = [];

            let wahltyp = await Tualo.Fetch.post('ds/wahltyp/read',{limit:10000});
            let abgabetyp = await Tualo.Fetch.post('ds/abgabetyp/read',{limit:10000});

            if (
                (wahltyp.success==true)
                &&
                (abgabetyp.success==true)
            ){
                wahltyp.data.forEach(function(wahltyp){
                    abgabetyp.data.forEach(function(abgabetyp){
                        list.push({
                            name: wahltyp.title + ' ('+abgabetyp.title+')',
                            path: '#papervote/involvement/'+wahltyp.id+'/'+abgabetyp.id+'/0'
                        });
                    });
                });

            }
            return list;
            
        }
    }, 
    url: 'papervote/involvement/:typ/:abgabetyp/:testdaten',
    handler: {
        action: function (typ,abgabetyp,testdaten) {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.involvement.Viewport',{
                typ: typ,
                abgabetyp: abgabetyp,
                testdaten: testdaten
            });
        },
        before: function (typ,abgabetyp,testdaten,action) {

            
            action.resume();
        }
    }
});




Ext.define('Tualo.routes.PaperVoteFindIdent', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/findident',
                    path: '#papervote/findident'
                }
            ]
        }
    }, 
    url: 'papervote/findident',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.stacks.FindIdentnummer');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});




Ext.define('Tualo.routes.Combine', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/combine',
                    path: '#papervote/combine'
                }
            ]
        }
    }, 
    url: 'papervote/combine',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Combine');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});
