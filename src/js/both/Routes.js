
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
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Input');
        },
        before: function (action) {
            action.resume();
        }
    }
});

Ext.define('Tualo.routes.PaperVoteReturnList', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/returnlist',
                    path: '#papervote/returnlist'
                }
            ]
        }
    }, 
    url: 'papervote/returnlist',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Input',{
                list_length: 10
            });
        },
        before: function (action) {
            action.resume();
        }
    }
});

// list_length
Ext.define('Tualo.routes.PaperVoteReturnIdent', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/returnident',
                    path: '#papervote/returnident'
                }
            ]
        }
    }, 
    url: 'papervote/returnident',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Input',{
                useident: 1
            });
        },
        before: function (action) {
            action.resume();
        }
    }
});

Ext.define('Tualo.routes.PaperVoteReturnIdentList', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/returnidentlist',
                    path: '#papervote/returnidentlist'
                }
            ]
        }
    }, 
    url: 'papervote/returnidentlist',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.Input',{
                useident: 1,
                list_length: 10
            });
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
            fetch('./papervote/status').then(function(response){
                response.json().then(function(json){

                    if (json.basistyp=='stimmzettel'){
                        Ext.getApplication().addView('Tualo.PaperVote.lazy.monitor.Viewport');
                    }else{
                        Ext.getApplication().addView('Tualo.PaperVote.lazy.monitor.SZGViewport');
                    }
                    return json;
                });
            })

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
                wahltyp.data.push({
                    id: 'x',
                    __displayfield: 'Alle WT'
                });

                abgabetyp.data.push({
                    id: 'x',
                    __displayfield: 'Alle AT'
                });
                
                wahltyp.data.forEach(function(wahltyp){
                    abgabetyp.data.forEach(function(abgabetyp){
                        list.push({
                            name: wahltyp.__displayfield + ' ('+abgabetyp.__displayfield+')',
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
            let opt={}
            if (typ!='x') opt.typ=typ;
            if (abgabetyp!='x') opt.abgabetyp=abgabetyp;
            if (testdaten!='x') opt.testdaten=testdaten;
            Ext.getApplication().addView('Tualo.PaperVote.lazy.involvement.Viewport',opt);
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
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.FindIdentnummer');
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



Ext.define('Tualo.routes.ResetCombine', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/resetcombine',
                    path: '#papervote/resetcombine'
                }
            ]
        }
    }, 
    url: 'papervote/resetcombine',
    handler: {
        action: function () {
            
            Ext.getApplication().addView('Tualo.PaperVote.lazy.ResetCombine');
        },
        before: function (action) {

            
            action.resume();
        }
    }
});








Ext.define('Tualo.routes.PaperVoteOpticalScan', {
    statics: {
        load: async function() {
            return [
                {
                    name: 'papervote/opticalscan',
                    path: '#papervote/opticalscan'
                }
            ]
        }
    }, 
    url: 'papervote/opticalscan',
    handler: {
        action: function () {
            
            let mainView = Ext.getApplication().getMainView(),
                stage = mainView.getComponent('dashboard_dashboard').getComponent('stage'),
                component = null,
                cmp_id = 'papervote_opticalscan';
                component = stage.down(cmp_id);
            if (component){
                stage.setActiveItem(component);
            }else{
                Ext.getApplication().addView('Tualo.PaperVote.lazy.OpticalScan',{
                
                });
            }

            
        },
        before: function (action) {
            action.resume();
        }
    }
});

