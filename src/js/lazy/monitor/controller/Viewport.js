Ext.define('Tualo.PaperVote.lazy.monitor.controller.Viewport', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.cmp_wm_wahlausschuss_mon',


    onBoxReady: function(){
        var me = this;
        this.reloadGrid();
        this.reloadChart();
        //this.loop();
      },

    reloadChart: function(){
      console.log('reloadChart');
      this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor').load();
      //setTimeout(this.reloadChart.bind(this),120000);
    },

    reloadGrid: function(){
      this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor_list').load();
      setTimeout(this.reloadGrid.bind(this),320000);
    },

    loop: function(){

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
      console.log('loop','---',selection);
      range.forEach(function(item){
        if (n){
          console.log('---->>>>>',item.id,selection[0].id);
          nr = item;
          n=false;
        }
        if ( selection.length>0){
          if (item.id == selection[0].id){
            console.log(item.id,selection[0].id);
            n=true;
          }
        }
      });
      if ( (typeof nr == 'undefined') || (nr == null) ){
          nr = range[0];
          setTimeout(this.loop.bind(this),this.getViewModel().get('loopTimeout')*1000);
          list.setSelection(nr);
          /*
          this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor_list').load(
            {
              callback: function(){
                console.log('loop',nr,length);
              }.bind(this)
            }
          );
          */
        }else{ 

          console.log('loop',nr,length);
          setTimeout(this.loop.bind(this),this.getViewModel().get('loopTimeout')*1000);
          list.setSelection(nr);
      }

    },

    onMonitorStoreLoad: function( b, records, successful, operation, eOpts ){
      //console.log( b, records, successful, operation, eOpts );
      //console.log(this.lookupReference('chart'));
      if (records!=null)
      if (records.length>0){
        this.lookupReference('chart').captions.title.setText(records[0].get('view_stimmenanzahl_ranking_los_monitor__stimmzettel_name'));
        this.lookupReference('chart').captions.subtitle.setText(
          //  records[0].get('view_stimmenanzahl_ranking_los_monitor__sitze')
          [
            'Sitze: ',
            records[0].get('view_stimmenanzahl_ranking_los_monitor__sitze'),
            ''
            //record.get('view_stimmenanzahl_ranking_los_monitor_list__gescannt'),
            //record.get('view_stimmenanzahl_ranking_los_monitor_list__erwartet')
          ].join(' ')
  
          );
      }
    },

    barRenderer: function (sprite, config, rendererData, index) {
        try{
            if (rendererData.store.getAt(index).get('view_stimmenanzahl_ranking_los_monitor__gewaehlt')==1){
            return { fillOpacity : 0.75 };
            }
        }catch(e){
            
        }
        return { fillOpacity : 0.2 };
    },



    onStimmzettelSelect: function(rm, record, index, eOpts) {
        this.sitze = record.get('view_stimmenanzahl_ranking_los_monitor_list__sitze');

        
        console.log(record.data);
        


        this.lookupReference('chart').captions.credits.setText(
          //  records[0].get('view_stimmenanzahl_ranking_los_monitor__sitze')
          [
            'Quote: ',
            Ext.util.Format.number(
              (
                (
                  record.get('view_stimmenanzahl_ranking_los_monitor_list__gescannt') + 
                  record.get('view_stimmenanzahl_ranking_los_monitor_list__ungueltig') 
                )/
              record.get('view_stimmenanzahl_ranking_los_monitor_list__erwartet'))*100,
            '0.000,00/i'),
            '%'
            //record.get('view_stimmenanzahl_ranking_los_monitor_list__gescannt'),
            //record.get('view_stimmenanzahl_ranking_los_monitor_list__erwartet')
          ].join(' ')
  
          );

        this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor').sort([
            {
                property: 'view_stimmenanzahl_ranking_los_monitor__stimmenanzahl',
                direction: 'asc'
            }
        ]);

        /*
        this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor').filter([
            {
                property: 'view_stimmenanzahl_ranking_los_monitor__stimmzettelgruppen_ridx',
                operator: 'eq',
                value:  record.get('view_stimmenanzahl_ranking_los_monitor_list__stimmzettelgruppen_ridx')
            }
        ]);
        */
        this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor').filter([
          {
              property: 'view_stimmenanzahl_ranking_los_monitor__stimmzettel_ridx',
              operator: 'eq',
              value:  record.get('view_stimmenanzahl_ranking_los_monitor_list__stimmzettel_ridx')
          }
        ]);

    },
    
      onSeriesLabelRender: function (v) {
        //console.log('onSeriesLabelRender',arguments)
        if (v==0)    return '';
        return Ext.util.Format.number(v, '0');
      },
    
      onItemEditTooltipRender: function (tooltip, item, target, e) {
          var formatString = '0',
              record = item.record;
          tooltip.setHtml(record.get('view_stimmenanzahl_ranking_los_monitor__anzeige_name') + ': ' +  Ext.util.Format.number(target.yValue, formatString));
      },
    
      onSeriesTooltipRender: function(tooltip, record, item) {
          var formatString = '0 (Stimmen)';
    
          if (record.get('view_stimmenanzahl_ranking_los_monitor__offline')+record.get('view_stimmenanzahl_ranking_los_monitor__online')!=0){
            formatString = '0 (Stimmen)';
            tooltip.setHtml(
              record.get('view_stimmenanzahl_ranking_los_monitor__anzeige_name') + ': ' + 
              Ext.util.Format.number(record.get('view_stimmenanzahl_ranking_los_monitor__stimmenanzahl'), 
              formatString)
            );

            //+"<br>"+ Ext.util.Format.number(record.get('voted_oc')+record.get('notvoted_oc'), '0 Online')+"<br>"+ Ext.util.Format.number(record.get('voted_c')+record.get('notvoted_c'), '0 Brief') );
          }else{
            tooltip.setHtml(record.get('view_stimmenanzahl_ranking_los_monitor__anzeige_name') + ': ' +
                Ext.util.Format.number(record.get('view_stimmenanzahl_ranking_los_monitor__stimmenanzahl'), formatString));
          }
      },
      onAxisLabelRender: function (axis, label, layoutContext) {
        var store = this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor');
        var max_val = store.max('view_stimmenanzahl_ranking_los_monitor__stimmenanzahl');
        return Ext.util.Format.number(label, '0,000');
        //return Ext.util.Format.number(label*max_val*2, '0,000');
      },
    
      onCategoryRenderer: function(axis,label,layout,lastlabel){
        
        var store = this.getViewModel().getStore('view_stimmenanzahl_ranking_los_monitor');
        var rec = store.findRecord('view_stimmenanzahl_ranking_los_monitor__anzeige_name',label,0,false,false,true);
        //console.log( label, rec,layout,lastlabel,axis);
        
        if (rec.get('view_stimmenanzahl_ranking_los_monitor__gewaehlt')==1){
          return ""+label+"   ";
        }
        return label+"   ";
      }
});
  