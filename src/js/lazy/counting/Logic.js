/*
Ext.cmp={};
Ext.cmp.cmp_wm_erstzaehlung1={};
*/
var FC_INIT_STACK = "FC3";
var FC_BOX_CODE = "FC4";
var FC_BOX_CODE1 = "FC8";
var FC_INIT_SYS = "FC2";
var FC_INIT_SYS_PAPER = "FC201";
var FC_INIT_SYS_RESET_PAPER = "FC270";
var FC_INIT_SYS_RESET_STACK = "FC209";
var FC_INIT_SYS_OK = "FC299";

Ext.define('Tualo.PaperVote.lazy.counting.Logic', {
  extend: 'Ext.Component',

  currentBP: null,
  currentBPGroups: null,
  skipStartBallotpaper: false,

  //Ext.cmp.cmp_wm_erstzaehlung1.Logic = Ext.extend( Ext.util.Observable ,  {
  //Ext.define('Ext.cmp.cmp_wm_erstzaehlung1.Logic',  {
  //  extend: 'Ext.Base',
  scrollToLast: function () {
    this.parent.scrollToLast();
  },
  setMessage: function (msg) {
    this.parent.setMessage(msg);
  },
  setGreenLight: function () {
    this.parent.setGreenLight();
  },
  setYellowLight: function () {
    this.parent.setYellowLight(true);
  },
  setRedLight: function () {
    this.parent.setRedLight(true);
  },
  initLogic: function (config) {

    this.parent = config.parent;

    this.store = config.store;
    this.kandidaten = config.kandidaten;
    this.stimmzettel = config.stimmzettel;
    this.stimmzettelgruppen = config.stimmzettelgruppen;

    this.boxcode = "";
    this.stimmzettelnr = 0;
    this.kistennummer = "";
    this.is_zweitzaehlung = false;
    this.stapel = "";

    this.FSM = new Tualo.PaperVote.lazy.counting.FSM({
      startingState: 'start'
    });
    this.FSM.allowTransit('start => initStack', null, function (scope) {
      return function () {
        scope.setMessage('Stimmzettelanfang wird erwartet');
      }
    }(this));
    this.FSM.allowTransit('initStack => ballotPaper', function () {
      return true;
    }, function (scope) {
      return function () {
        scope.setMessage('Kandidat wird erwartet');
      }
    }(this));
    this.FSM.allowTransit('ballotPaper => candidate', function () {
      return true;
    }, function (scope) {
      return function () {
        scope.setMessage('Kandidat oder Stimmzettelanfang wird erwartet');
      }
    }(this));
    this.FSM.allowTransit('candidate => candidate', null, function (scope) {
      return function () {
        scope.setMessage('Kandidat oder Stimmzettelanfang wird erwartet');
      }
    }(this));
    this.FSM.allowTransit('candidate => ballotPaper', null, function (scope) {
      return function () {
        scope.setMessage('Kandidat wird erwartet');
      }
    }(this));
    this.FSM.allowTransit('candidate => stopStack', function (scope) {
      return function () {
        if (scope.stapel == scope.code) {
          scope.setMessage('Stapeltrenner wird erwartet');
        } else {
          throw new Error('errorStack');
        }
      }
    }(this), null);

    this.FSM.allowTransit('candidate => errorStack', null, function (scope) {
      return function () {
        scope.setMessage('Der Stapeltrenner ist nicht der des Stapels');
        scope.setYellowLight();
      }
    }(this));

    /* STAPELENDE nach STAPELFEHLER */
    this.FSM.allowTransit('errorStack => stopStack', null, function (scope) {
      return function () {
        scope.setMessage('Der neue Stapeltrenner wird erwartet');
        scope.setGreenLight();
      }
    }(this));

    /* STAPELABBRUCH nach STAPELFEHLER */
    this.FSM.allowTransit('errorStack => resetStack', null, function (scope) {
      return function () {
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));

    this.FSM.allowTransit('ballotPaper => ballotPaper', null, function (scope) {
      return function () {
        //console.log('set Error (ballotPaper => ballotPaper)');
        scope.FSM.transit('errorBallotPaper');
      }
    }(this));
    this.FSM.allowTransit('ballotPaper => errorBallotPaper', null, function (scope) {
      return function () {
        scope.setMessage('Stimmenthaltung bitte informieren Sie die Leitung');
        scope.setRedLight();
      }
    }(this));
    this.FSM.allowTransit('errorBallotPaper => resetBallotPaper', null, function (scope) {
      return function () {
        console.log('current State (errorBallotPaper => resetBallotPaper):' + scope.FSM.getState());
        var new_state = scope.resetBallotPaper();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));


    /* STIMMZETTELABBRUCH */
    this.FSM.allowTransit('ballotPaper => resetBallotPaper', null, function (scope) {
      return function () {
        var new_state = scope.resetBallotPaper();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));
    this.FSM.allowTransit('candidate => resetBallotPaper', null, function (scope) {
      return function () {
        var new_state = scope.resetBallotPaper();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));
    this.FSM.allowTransit('resetBallotPaper => candidate', null, function (scope) {
      return function () {
        scope.setMessage('Kandidat oder Stimmzettelanfang wird erwartet');
        scope.setGreenLight();
      }
    }(this));
    this.FSM.allowTransit('resetBallotPaper => ballotPaper', null, function (scope) {
      return function () {
        scope.setMessage('Kandidat wird erwartet');
        scope.setGreenLight();
      }
    }(this));



    this.FSM.allowTransit('candidate => errorBallotPaper', null, function (scope) {
      return function () {
        scope.setMessage('Stimmzettelfehler');
        scope.setRedLight();
      }
    }(this));


    this.FSM.allowTransit('resetBallotPaper => initStack', null, function (scope) {
      return function () {
        scope.setMessage('Stimmzettelanfang wird erwartet');
        scope.setGreenLight();
      }
    }(this));


    /* STAPELABBRUCH */
    this.FSM.allowTransit('ballotPaper => resetStack', null, function (scope) {
      return function () {
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));
    this.FSM.allowTransit('candidate => resetStack', null, function (scope) {
      return function () {

        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        scope.setGreenLight();

      }
    }(this));
    this.FSM.allowTransit('candidate => candidateError', null, function (scope) {
      return function () {
        /*
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        */
        scope.setYellowLight();

      }
    }(this));
    this.FSM.allowTransit('ballotPaper => candidateError', null, function (scope) {
      return function () {
        /*
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        */
        scope.setYellowLight();

      }
    }(this));
    this.FSM.allowTransit('candidateError => candidate', null, function (scope) {
      return function () {
        /*
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        */
        scope.setMessage('Kandidat oder Stimmzettelanfang wird erwartet');
        scope.setGreenLight();

      }
    }(this));
    this.FSM.allowTransit('initStack => resetStack', null, function (scope) {
      return function () {
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));
    this.FSM.allowTransit('resetStack => start', null, function (scope) {
      return function () {
        scope.setMessage('Stapeltrenner wird erwartet');
        scope.setGreenLight();
      }
    }(this));
    this.FSM.allowTransit('resetStack => stopStack', null, function (scope) {
      return function () {
        scope.setMessage('Stapeltrenner wird erwartet');
        scope.setGreenLight();
      }
    }(this));


    this.FSM.allowTransit('stopStack => unkownSaveError', null, function (scope) {
      return function () {
        scope.setMessage('Unbekannter Fehler: ' + scope.lastError);
        scope.setRedLight();
      }
    }(this));



    this.FSM.allowTransit('candidate => candidateMaxError', null, function (scope) {
      return function () {
        scope.setMessage('Zu viele Stimmen auf dem Stimmzettel');
        scope.setRedLight();
      }
    }(this));


    this.FSM.allowTransit('candidateMaxError => resetBallotPaper', null, function (scope) {
      return function () {
        var new_state = scope.resetBallotPaper();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));

    this.FSM.allowTransit('candidateMaxError => resetStack', null, function (scope) {
      return function () {
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));

    this.FSM.allowTransit('stopStack => saveError', null, function (scope) {
      return function () {
        scope.setMessage('' + scope.lastError);
        scope.setRedLight();
      }
    }(this));


    this.FSM.allowTransit('saveError => resetStack', null, function (scope) {
      return function () {
        var r = scope.store.getRange();
        scope.store.remove(r[r.length - 1]);
        var new_state = scope.resetStack();
        scope.FSM.transit(new_state);
        scope.setGreenLight();
      }
    }(this));

    /* NÄCHSTER STAPEL */
    this.FSM.allowTransit('stopStack => initStack', null, function (scope) {
      return function () {
        scope.setMessage('Stimmzettelanfang wird erwartet');
        scope.setGreenLight();
      }
    }(this));



    this.FSM.begin();
  },
  isCandidate: function (code) {
    return this.getCandidate(code) !== false;
  },
  getCandidate: function (code) {
    if (code.substring(0, 2) == 'FC') {
      return false;
    }
    var res = this.kandidaten.findRecord('barcode', code, 0, false, false, true);

    if (Ext.isEmpty(res)) {
      return false;
    }
    return res;
  },
  getBallotpaper: function (code) {

    var res = this.stimmzettelgruppen.findRecord('id', code, 0, false, false, true);
    if (Ext.isEmpty(res)) {
      return false;
    }
    return res;
  },





  progressCode: function (code) {
    this.code = code;
    // wenn onhe stimmzettelanfang, dann starte den sz anfang vorab


    console.log("current State: " + this.FSM.getState());
    try {
      var signal = code;
      if (code.length > 3) {
        signal = code.substring(0, 3);
      }
      if (this.kistennummer == "") {
        if ((signal != FC_BOX_CODE) && (signal != FC_BOX_CODE1)) {
          this.setMessage("Bitte scannen Sie zuerst einen Kistencode");
          this.setYellowLight();
          return;
        }
      }
      switch (signal) {
        case FC_BOX_CODE:
          this.is_zweitzaehlung = true;
          this.kistennummer = code;
          this.parent.setHeaderMessage("Zweitzählung (Kiste-Nr.: " + code + ")");
          this.setMessage('Stapelanfang wird erwartet');
          break;
        case FC_BOX_CODE1:
          this.is_zweitzaehlung = false;
          this.kistennummer = code;
          this.parent.setHeaderMessage("Erstzählung (Platz-Nr.: " + code + ")");
          this.setMessage('Stapelanfang wird erwartet');
          break;
        case FC_INIT_STACK:
          console.log(this.FSM.getState());
          if ((this.FSM.getState() == 'start') || (this.FSM.getState() == 'stopStack')) {
            this.FSM.transit('initStack');
            this.stapel = code;
            var itm = this.store.add({
              stapel: this.stapel,
              stimmzettel: null,
              kandidat: null,
              typ: 1,
              state: this.FSM.getState()
            });
            this.scrollToLast();
            this.setGreenLight();
          } else {
            var can_save = this.checkLastGroupMin('errorBallotPaper');


            if (can_save) {

              this.FSM.transit('stopStack');
              var itm = this.store.add({
                stapel: this.stapel,
                stimmzettel: null,
                kandidat: null,
                typ: 1,
                state: this.FSM.getState()
              });
              this.scrollToLast();
              var stacklist = new Array();
              var klist = new Array();
              var r = this.store.getRange();
              for (var i = r.length - 2; i >= 0; i--) {
                if (r[i].get('typ') == 3) {
                  klist.push({
                    code: r[i].get('code'),
                    stimmzettel: r[i].get('stimmzettel'),
                    stimmzettelgruppe: r[i].get('stimmzettelgruppe'),
                    kandidat: r[i].get('kandidat'),
                    //allowed: this.allowedSZbySZRi dx(r[i].get('stimmzettel'))
                  });

                }

                if (r[i].get('typ') == 2) {
                  stacklist.push(klist);
                  klist = new Array();
                }
                if (r[i].get('typ') == 1) {
                  break;
                }
              }


              this.saveStack(stacklist);
              this.stapel = "";
              this.stimmzettelnr = 0;
            }

          }
          break;
        case FC_INIT_SYS:
          if (code == FC_INIT_SYS_PAPER) {
            // Prüfen auf der Stimmzettellogic 
            this.checkLastGroupMin('errorBallotPaper');
            this.FSM.transit('ballotPaper');
            this.stimmzettelnr++;
            while (this.stimmzettelnr < 1) {
              this.stimmzettelnr++;
            }
            this.store.add({
              stapel: this.stapel,
              stimmzettelnr: this.stimmzettelnr,
              kandidat: null,
              typ: 2,
              state: this.FSM.getState()
            });
            this.scrollToLast();
            this.setGreenLight();
            this.currentBP = null;
            this.currentBPGroups = null;
          }
          if (code == FC_INIT_SYS_RESET_PAPER) {
            this.currentBP = null;
            this.currentBPGroups = null;
            this.FSM.transit("resetBallotPaper");
          }
          if (code == FC_INIT_SYS_OK) {
            this.FSM.transit("candidate");
          }
          if (code == FC_INIT_SYS_RESET_STACK) {
            this.currentBP = null;
            this.currentBPGroups = null;
            window.location.reload();
            this.FSM.transit("resetStack");
            this.parent.getView().disable();
          }

          break;
        default:

          if (this.skipStartBallotpaper) {
            var candidateres = this.getCandidate(code);
            if (candidateres !== false) {
              // Prüfen auf der Stimmzettellogic 
              this.checkLastGroupMin('errorBallotPaper');
              this.FSM.transit('ballotPaper');
              this.stimmzettelnr++;
              while (this.stimmzettelnr < 1) {
                this.stimmzettelnr++;
              }
              this.store.add({
                stapel: this.stapel,
                stimmzettelnr: this.stimmzettelnr,
                kandidat: null,
                typ: 2,
                state: this.FSM.getState()
              });
              this.scrollToLast();
              this.setGreenLight();
              this.currentBP = null;
              this.currentBPGroups = null;
            }
          }


          if ((this.FSM.getState() == 'initStack')) {
            this.setMessage('Stimmzettelanfang erwartet');
            this.setRedLight(); return;
          }
          if (
            (this.FSM.getState() == 'candidate') ||
            (this.FSM.getState() == 'ballotPaper')
          ) {

            var candidateres = this.getCandidate(code);
            if (candidateres === false) { this.FSM.transit('candidateError'); throw new Error("Der Kandidat wurde nicht gefunden (" + code + ")"); }
            var ballotpaperres = this.getBallotpaper(candidateres.get('stimmzettelgruppen'));
            if (ballotpaperres == false) { this.FSM.transit('candidateError'); throw new Error("Die Stimmzettelgruppe wurde nicht gefunden"); }
            var r = this.store.getRange();

            this.checkBallotPaperGroup(candidateres.get('stimmzettelgruppen'));
            this.checkBallotPaper(ballotpaperres.get('stimmzettel'));

            this.checkCurrentBallotPaper(candidateres.get('stimmzettelgruppen'));
            if (this.checkHasCandidate(candidateres.get('id'))) {
              this.FSM.transit('candidate');
              var itm = this.store.add({
                stapel: this.stapel,
                stimmzettelnr: this.stimmzettelnr,
                stimmzettel: ballotpaperres.get('stimmzettel'),
                code: code,
                kandidat: code,
                kandidat: candidateres.get('id'),
                stimmzettelgruppe: candidateres.get('stimmzettelgruppen'),
                name: candidateres.get('anzeige_name'),
                typ: 3,
                state: this.FSM.getState()
              });
              this.scrollToLast();
              this.setGreenLight();
            }


          }
          break;
      }

    } catch (error_1) {
      console.log(error_1);
      if (error_1 == 'Error: errorStack') {
        this.FSM.transit('errorStack');
      } else {
        var error_done = false;
        if (!error_done) {
          if (error_1 == 'Error: "ballotPaper => stopStack" is not a valid transition')
            error_1 = "Stimmenthaltung am Stapelende";
          this.setMessage(error_1);
          this.setRedLight();
        }
      }
    }
  },

  checkBallotPaperGroup: function (stimmzettelgruppe) {
    if (this.currentBPGroups === null) return true;
    if (this.currentBPGroups.indexOf(stimmzettelgruppe) < 0) { this.FSM.transit('errorBallotPaper'); throw new Error('Die Stimmzettelgruppe ist nicht stimmig'); }
  },
  checkBallotPaper: function (stimmzettel) {
    var me = this;
    if (me.currentBP === null) {
      me.currentBP = stimmzettel;
      me.currentBPGroups = [];
      me.stimmzettelgruppen.getRange().forEach(function (rec) {
        if (rec.get('stimmzettel') == stimmzettel)
          me.currentBPGroups.push(rec.get('id'));
      });
      console.log('checkBallotPaper', 'set', me.currentBP, me.currentBPGroups)
    }
    if (stimmzettel != me.currentBP) { me.FSM.transit('errorBallotPaper'); throw new Error('Der Kandidat gehört nicht zu diesem Stimmzettel'); }
  },


  // Stimmenhaltungen
  checkLastGroupMin: function (errorState) {
    return true;
  },
  checkHasCandidate: function (id) {
    var me = this;
    var range = this.store.getRange();
    console.log(range);

    for (var i = range.length - 1; i > 0; i--) {
      console.log('typ', range[i].get('typ'));
      if ((range[i].get('typ') == '3')) {
        if ((range[i].get('kandidat') == id)) {
          me.setMessage('Kandidat wurde bereits gescannt');
          console.log(range[i]);

          me.FSM.transit('candidateError');
          return false;
        }

      }
      if (range[i].get('typ') == 2) {
        console.log('break', range[i]);
        break;
      }
    }
    return true;
  },
  checkCurrentBallotPaper: function (stimmzettelgruppe) {
    var me = this;
    var checkHash = {};
    var nameHash = {};
    var max_sz_sitze = 0;
    this.stimmzettelgruppen.getRange().forEach(function (rec) {
      if (rec.get('stimmzettel') == me.currentBP) {
        checkHash[rec.get('id')] = rec.get('sitze') * 1;
        nameHash[rec.get('id')] = rec.get('name');
      }
    });


    console.log(checkHash);
    //stimmzettelgruppe
    checkHash[stimmzettelgruppe]--;
    var range = this.store.getRange();
    for (var i = range.length - 1; i > 0; i--) {
      if ((range[i].get('typ') == '3')) {
        checkHash[range[i].get('stimmzettelgruppe')]--;
      }
      if (range[i].get('typ') == 2) {
        break;
      }
    }
    for (var key in checkHash) {
      if (checkHash[key] < 0) {
        this.FSM.transit('candidateMaxError'); throw new Error('Zu viele Stimmen in der Gruppe ' + nameHash[key]);
      }
    }


    var szres = this.stimmzettel.findRecord('id', me.currentBP, 0, false, false, true);
    console.log('szres>>>>>>>', szres);
    try {
      max_sz_sitze = szres.get('sitze')
    } catch (e) {
      this.FSM.transit('MaxError'); throw new Error('Fehlerhafte SZ Konfiguration');
    }
    console.log('max_sz_sitze', max_sz_sitze);
    max_sz_sitze--;
    for (var i = range.length - 1; i > 0; i--) {
      if ((range[i].get('typ') == '3')) {
        max_sz_sitze--;
      }
      if (range[i].get('typ') == 2) {
        break;
      }
    }
    console.log('max_sz_sitze end', max_sz_sitze);

    if (max_sz_sitze < 0) {
      this.FSM.transit('candidateMaxError'); throw new Error('Zu viele Stimmen auf dem Stimmzettel');
    }
    return true;

  },

  resetBallotPaper: function () {
    var c = this.store.getCount();
    var r = this.store.getRange();
    for (var i = c - 1; i >= 0; i--) {
      var rx = r[i];
      var s = false;
      if (rx.get('typ') == 2) {
        s = true;
      }
      console.log("remove " + rx.get('kandidat') + ' #paper ' + rx.get('stimmzettel') + ' #stack ' + rx.get('stapel') + ' #typ ' + rx.get('typ') + ' #state ' + rx.get('state'));
      this.store.remove(rx);
      //
      if (s) {
        break;
      }
    }
    this.stimmzettelnr--;
    var state = "start";
    if (this.store.getCount() > 0) {
      state = this.store.getAt(this.store.getCount() - 1).get('state');
      console.log('state## ' + state);
    }
    return state;
  },
  resetStack: function () {
    var c = this.store.getCount();
    var r = this.store.getRange();
    for (var i = c - 1; i >= 0; i--) {
      var rx = r[i];
      var s = false;
      if (rx.get('typ') == 1) {
        s = true;
      }
      console.log("remove " + rx.get('kandidat') + ' #paper ' + rx.get('stimmzettel') + ' #stack ' + rx.get('stapel') + ' #typ ' + rx.get('typ') + ' #state ' + rx.get('state'));
      this.store.remove(rx);
      //
      if (s) {
        break;
      }
    }
    this.stimmzettelnr--;
    var state = "start";
    if (this.store.getCount() > 0) {

      state = this.store.getAt(this.store.getCount() - 1).get('state');
      console.log('state## ' + state);
    }
    return state;
  },



  saved_stacks: [],
  cleanup: function () {
    console.log('cleanup', this.saved_stacks);
    if (this.saved_stacks.length - 3 > 0) {
      var range = this.store.getRange();
      for (var i = this.saved_stacks.length - 3; i >= 0; i--) {
        range.forEach(function (item) {
          if (item.get('stapel') == this.saved_stacks[i]) {
            this.store.remove(item);
          }
        }.bind(this));
      }
      this.saved_stacks = this.saved_stacks.slice(this.saved_stacks.length - 3);
    }
  },

  saveStack: function (stack) {
    this.parent.getView().disable();
    var stapel = this.stapel;
    Ext.MessageBox.wait('Bitte warten ...');
    Tualo.Ajax.request({
      url: './papervote/counting/save',
      scope: this,
      params: {
        stapelliste: Ext.util.JSON.encode(stack),
        TEMPLATE: 'NO',
        stapel: this.stapel,
        kistennummer: this.kistennummer,
        zaehltyp: (this.is_zweitzaehlung) ? '2' : '1',
      },
      json: function (response) {
        Ext.MessageBox.hide();
        if (response.success) {
          console.log(stapel);
          this.saved_stacks.push(stapel);
          this.currentBP = null;
          this.currentBPGroups = null;

          this.cleanup();
        } else {
          this.lastError = response.msg;
          this.FSM.transit('saveError');

        }
        this.parent.getView().enable();
        this.parent.scannField.enable();
        this.parent.scannField.focus();
      },
      failure: function (r) {
        Ext.MessageBox.hide();
        this.lastError = 'Abbruch der Verbindung';
        this.FSM.transit('unkownSaveError');
        this.parent.getView().enable();

        this.parent.scannField.enable();
        this.parent.scannField.focus();

      }
    });
  }
})
