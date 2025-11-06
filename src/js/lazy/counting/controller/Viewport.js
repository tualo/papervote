Ext.define('Tualo.PaperVote.lazy.counting.controller.Viewport', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.papervote_counting',


    onBoxReady: function () {
        var me = this;
        me.logic = new Tualo.PaperVote.lazy.counting.Logic();
        me.scannField = this.lookupReference('barcode');
        me.setMessage('Bitte scannen Sie einen Kistencode');
        me.setYellowLight(false);
        me.logic.initLogic({
            store: this.getViewModel().getStore('list'),
            kandidaten: this.getViewModel().getStore('kandidaten'),
            stimmzettel: this.getViewModel().getStore('stimmzettel'),
            stimmzettelgruppen: this.getViewModel().getStore('stimmzettelgruppen'),
            parent: me
        });


        me.scannField.focus();
        window.scann = this;
        me.getConfig();
        //Ext.defer(me.scannField.focus,500,me);
        setInterval(function () {
            me.scrollToLast();
        }, 1000);
    },

    getConfig: async function () {
        const response = await fetch("./papervote/skipStartBallotpaper", {
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
        });
        const jsonData = await response.json();
        console.log(jsonData);
        this.logic.skipStartBallotpaper = jsonData.success;
    },



    onFocus: function (fld) {
        var el = document.getElementById(fld.id + '-inputEl');
        el.style.backgroundColor = 'rgb(255,255,255)';
    },
    onKeyup: function (t, e, opt) {
        if (e.browserEvent.keyCode == 13 || e.browserEvent.keyCode == 10) {
            e.stopEvent();
            var v = t.getValue();
            this.logic.progressCode(v);
            t.setValue("");
            t.focus();
        }
    },
    onBlur: function (fld) {
        var el = document.getElementById(fld.id + '-inputEl');
        el.style.backgroundColor = 'rgb(255,100,100)';
    },

    onListAdd: function () {

    },
    onListRemove: function () {

    },
    setHeaderMessage: function (msg) {
        console.log('header', msg);
        this.getView().setTitle(msg);
    },
    setMessage: function (msg) {
        if (typeof msg == 'object') {
            if (typeof msg.message == 'string') {

                if (msg.message == '"start => ballotPaper" is not a valid transition') { msg = 'Bitte zuerst einen Stapeltrenner scannen,der Trenner darf jetzt erfasst werden'; }
                if (msg.message == '"initStack => stopStack" is not a valid transition') { msg = 'Ein leerer Stapel darf nicht erfasst werden, der Stapel darf nochmals erfasst werden'; }
                if (msg.message == '"saveError => stopStack" is not a valid transition') { msg = 'Erfassungsfehler, der Stapel muss neu erfasst werden'; }
                if (msg.message == '"stopStack => ballotPaper" is not a valid transition') { msg = 'Erfassungsfehler, scannen Sie zuerst einen Stapelanfang. Sie können mit einem Stapel fortsetzen'; }
            }
        }
        this.lookupReference('message').setHtml(msg);
        console.log('msg', msg);
    },
    setGreenLight: function () {
        this.lookupReference('ampel').setHtml(
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:green;"></div>' +
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:green;"></div>' +
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:green;"></div>'
        );
        console.log('green');
    },
    setYellowLight: function (sound) {
        this.lookupReference('ampel').setHtml(
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:yellow;"></div>' +
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:yellow;"></div>' +
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:yellow;"></div>'
        );
        console.log('yellow');
        try {
            if (sound !== false) {
                var audio = new Audio('./papervote/sounds/sms-alert-1-daniel_simon.mp3');
                audio.play();
            }
        } catch (e) { }

    },
    setRedLight: function (sound) {
        this.red = true;
        this.lookupReference('ampel').setHtml(
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:red;"></div>' +
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:red;"></div>' +
            '<div style="height:60px;width:60px;float:right;border-radius: 30px;margin: 12px; background-color:red;"></div>'
        );
        console.log('red');
        try {
            if (sound !== false) {
                var audio = new Audio('./papervote/sounds/sms-alert-2-daniel_simon.mp3');
                audio.play();
            }
        } catch (e) { }

    },

    scrollToLast: function () {
        /*var scrollPosition = 100;   

        this.getView().lookupReference('centerlist').getEl().down('.x-grid-view').scroll('bottom', 0, false);
        */
        try {
            var view = this.getView().lookupReference('centerlist').getView();
            this.getView().lookupReference('centerlist').getEl().down('.x-grid-view').scroll('bottom', 100, true);
            //            Ext.get( view.getRow(  this.getView().lookupReference('centerlist').getStore().getCount()-1  ) ).scrollIntoView(view.getEl(), null, true);
        } catch (e) {
            console.log(e);
        }
    },


    simulate: function (n, x) {
        if (typeof this.simulateCodeList == 'undefined') {
            this.simulateCodeList = [];
        }
        if (n > 0) {
            if (typeof x == 'undefined') {
                x = 5;
            }
            var stack = "FC3" + Math.round((new Date()).getTime() / 100 - 15818675680);
            this.logic.progressCode("FC81"); this.simulateCodeList.push("FC45551");
            this.logic.progressCode(stack); this.simulateCodeList.push(stack);
            var code = '0101';
            setTimeout(function () {
                this.simulateFC201(n--, code, function () {
                    this.logic.progressCode(stack); this.simulateCodeList.push(stack);
                    n--;
                    setTimeout(function () {
                        this.simulateSecond(n, x);
                    }.bind(this), 800);
                }.bind(this));
            }.bind(this), 600)



        }
    },
    /*
    simulateSecond: function(n,x){
        .forEach(function(code){
            this.logic.progressCode(code);
        }.bind(this));
        this.simulateCodeList = [];
    },
    */
    simulateSecond: function (n, x) {
        if (this.simulateCodeList.length > 0) {

            var c = this.simulateCodeList.splice(0, 1);

            console.log(c, this.simulateCodeList);
            setTimeout(function () {
                console.log('>>>>>>>>>>>', c[0]);
                this.logic.progressCode(c[0]);

                setTimeout(function () {
                    this.simulateSecond(n, x);
                }.bind(this), 200
                )
            }.bind(this), 200
            )
        } else {
            this.simulate(n, x);
        }


    },
    simulateFC201: function (n, code, cb) {
        if (n >= 0) {
            n -= 1;
            var range = this.getViewModel().getStore('kandidaten').getRange();
            var r = Math.floor(Math.random() * range.length);
            code = range[r].get('kandidaten__barcode');
            console.log('simulateFC201', n, code);
            this.logic.progressCode("FC201"); this.simulateCodeList.push("FC201");
            this.logic.progressCode(code); this.simulateCodeList.push(code);
            if (this.red === true) return;
            setTimeout(function () {
                this.simulateFC201(n, code, cb);
            }.bind(this), 100);
            //Ext.defer(this.simulateFC201,1000,this,[n--,code,cb]);
        } else {
            cb();
        }
    }
});
