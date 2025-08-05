Ext.define('Tualo.PaperVote.lazy.monitor.controller.Viewport', {
  extend: 'Ext.app.ViewController',
  alias: 'controller.cmp_wm_wahlausschuss_mon',


  onBoxReady: function () {
    var me = this;
    this.reloadGrid();
    this.reloadChart();
    //this.loop();
  },

  reloadChart: async function () {
    console.log('reloadChart');
    let r = await fetch('./papervote/refreshCounting')
    this.getViewModel().getStore('view_kandidaten_stimmenanzahl').load();
    //setTimeout(this.reloadChart.bind(this),120000);
    console.log('reloadChart');
  },

  reloadGrid: function () {
    this.getViewModel().getStore('view_protokoll_erwartet').load();
    setTimeout(this.reloadGrid.bind(this), 320000);
  },

  loop: function () {

    /*
    
    */

    let list = this.lookupReference('list'),
      range = list.getStore().getRange(),
      selection = list.getSelection(),
      length = range.length,
      n = false,
      nr = null;

    this.lookupReference('toolbar').hide();
    list.hide();
    console.log('loop', '---', selection);
    range.forEach(function (item) {
      if (n) {
        console.log('---->>>>>', item.id, selection[0].id);
        nr = item;
        n = false;
      }
      if (selection.length > 0) {
        if (item.id == selection[0].id) {
          console.log(item.id, selection[0].id);
          n = true;
        }
      }
    });
    if ((typeof nr == 'undefined') || (nr == null)) {
      nr = range[0];
      setTimeout(this.loop.bind(this), this.getViewModel().get('loopTimeout') * 1000);
      list.setSelection(nr);

    } else {

      console.log('loop', nr, length);
      setTimeout(this.loop.bind(this), this.getViewModel().get('loopTimeout') * 1000);
      list.setSelection(nr);
    }

  },

  onMonitorStoreLoad: function (b, records, successful, operation, eOpts) {
    console.log(b, records, successful, operation, eOpts);
    //console.log(this.lookupReference('chart'));
    if (records != null)
      if (records.length > 0) {
        this.lookupReference('chart').getCaptions().title.setText(records[0].get('use_name'));
        this.lookupReference('chart').getCaptions().subtitle.setText(
          //  records[0].get('sitze')
          [
            'Sitze: ',
            records[0].get('use_sitze'),
            ''
            //record.get('gescannt'),
            //record.get('erwartet')
          ].join(' ')

        );
      }
  },

  barRenderer: function (sprite, config, rendererData, index) {
    try {
      if (rendererData.store.getAt(index).get('gewaehlt') == 1) {
        return { fillOpacity: 0.75 };
      }
    } catch (e) {

    }
    return { fillOpacity: 0.2 };
  },



  onStimmzettelSelect: async function (rm, selected, index, eOpts) {

    let record = null;
    if (Ext.isArray(selected)) {
      record = selected[0];
    } else {
      record = selected;
    }

    this.sitze = record.get('use_sitze');



    this.lookupReference('chart').getCaptions().credits.setText(
      [
        'Quote: ',
        Ext.util.Format.number(
          (
            (
              record.get('briefwahlstimmzettel_anzahl') +
              record.get('briefwahlstimmzettel_ungueltig') +
              record.get('briefwahlstimmzettel_enthaltung')
            ) /
            record.get('briefwahlstimmzettel_erwartet')) * 100,
          '0.000,00/i'),
        '%'
      ].join(' ')

    );
    let r = await fetch('./papervote/refreshCounting')

    /*this.getViewModel().getStore('view_kandidaten_stimmenanzahl').sort([
      {
        property: 'gesamtstimmen',
        direction: 'asc'
      }
    ]);*/



    this.getViewModel().getStore('view_kandidaten_stimmenanzahl').filter([
      {
        property: 'use_id',
        operator: 'eq',
        value: record.get('use_id')
      }
    ]);
    // this.getViewModel().getStore('view_kandidaten_stimmenanzahl').load();

    console.log('onStimmzettelSelect', record.get('use_id'));

  },

  getKandidateNameById: function (id) {
    let store = this.getViewModel().getStore('kandidaten');
    let rec = store.findRecord('id', id, 0, false, false, true);
    if (rec) {
      return rec.get('anzeige_name');
    }
    return '';
  },

  onSeriesLabelRender: function (v) {
    //console.log('onSeriesLabelRender',arguments)
    if (v == 0) return '';
    return Ext.util.Format.number(v, '0');
  },

  onItemEditTooltipRender: function (tooltip, item, target, e) {
    var formatString = '0',
      record = item.record;
    tooltip.setHtml(this.getKandidateNameById(record.get('id')) + ': ' + Ext.util.Format.number(target.yValue, formatString));
  },

  onSeriesTooltipRender: function (tooltip, record, item) {
    var formatString = '0 (Stimmen)';

    if (record.get('offlinestimmen') + record.get('onlinestimmen') != 0) {
      formatString = '0 (Stimmen)';
      tooltip.setHtml(
        this.getKandidateNameById(record.get('id')) + ': ' +
        Ext.util.Format.number(record.get('gesamtstimmen'),
          formatString)
      );

      //+"<br>"+ Ext.util.Format.number(record.get('voted_oc')+record.get('notvoted_oc'), '0 Online')+"<br>"+ Ext.util.Format.number(record.get('voted_c')+record.get('notvoted_c'), '0 Brief') );
    } else {
      tooltip.setHtml(this.getKandidateNameById(record.get('id')) + ': ' +
        Ext.util.Format.number(record.get('gesamtstimmen'), formatString));
    }
  },
  onAxisLabelRender: function (axis, label, layoutContext) {
    var store = this.getViewModel().getStore('view_kandidaten_stimmenanzahl');
    // var max_val = store.max('gesamtstimmen');
    return Ext.util.Format.number(label, '0,000');
    //return Ext.util.Format.number(label*max_val*2, '0,000');
  },

  onCategoryRenderer: function (axis, label, layout, lastlabel) {
    try {
      var store = this.getViewModel().getStore('kandidaten');
      var rec = store.findRecord('barcode', label, 0, false, false, true);
      return rec.get('anzeige_name');
    } catch (e) {
      console.error('onCategoryRenderer', e);
    }
    return label;

  }
});
