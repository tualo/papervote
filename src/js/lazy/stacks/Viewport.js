Ext.define('Tualo.PaperVote.lazy.stacks.Viewport', {
  extend: 'Ext.panel.Panel',
  requires: [
    'Ext.form.field.Text',

  ],
  layout: {
    type: 'hbox',
    align: 'stretch'
  },
  title: 'offene Stapel',
  initComponent: function () {

    this.stapel_store_model_name = Ext.id();
    Ext.define(this.stapel_store_model_name, {
      extend: 'Ext.data.Model',
      fields: [{
        name: 'id',
        type: 'string'
      },
      {
        name: 'login',
        type: 'string'
      },
      {
        name: 'createdatetime',
        dateFormat: 'Y-m-d H:i:s',
        type: 'date'
      }

      ]
    });
    this.stapel_store = new Ext.data.Store({
      model: this.stapel_store_model_name,
      remoteSort: false,
      pageSize: 5000,
      autoLoad: false,
      proxy: {
        type: 'ajax',
        extraParams: {
          usefilter: true
        },
        url: './papervote/stacks/open',
        reader: {
          type: 'json',
          root: 'data',
          totalProperty: 'total'
        }
      }
    });

    this.items = [
      Ext.create('Ext.grid.Panel', {
        tbar: [{
          text: 'Stapel abbrechen',
          scope: this,
          handler: function () {
            Ext.MessageBox.prompt('Stapel entwerten', 'Bitte geben Sie die Stapelnummer ein:', function (btn, text) {
              if (btn == 'ok') {
                Ext.MessageBox.wait("Bitte Warten...");
                Ext.Ajax.request({
                  url: "./papervote/stacks/cancle/" + text,
                  success: function (response) {
                    Ext.MessageBox.hide();
                    try {
                      var x = Ext.JSON.decode(response.responseText);
                      if (x.success) {
                        this.stapel_store.load();
                      } else {
                        Ext.MessageBox.show({
                          title: 'Fehler',
                          icon: Ext.MessageBox.ERROR,
                          msg: x.msg,
                          buttons: Ext.MessageBox.OK
                        });
                      }
                    } catch (e) {
                      Ext.MessageBox.show({
                        title: 'Fehler',
                        icon: Ext.MessageBox.ERROR,
                        msg: response.responseText + " " + e,
                        buttons: Ext.MessageBox.OK
                      });
                    }
                  },
                  failure: function () {
                    Ext.MessageBox.hide();

                    Ext.MessageBox.show({
                      title: 'Fehler',
                      icon: Ext.MessageBox.ERROR,
                      msg: 'Abbruch der Verbindung',
                      buttons: Ext.MessageBox.OK
                    });

                  },
                  scope: this
                });
              }
            }, this);

          }
        }],
        flex: 1,
        store: this.stapel_store,
        listeners: {
          scope: this,
          itemdblclick: function (v, record, item, index, e, eOpts) {

          }
        },
        columns: [{
          dataIndex: 'id',
          width: 260,
          sortable: true,
          header: 'Stapel'
        },
        {
          dataIndex: 'login',
          header: 'Login',
          sortable: true,
          width: 90
        },
        {
          dataIndex: 'createdatetime',
          sortable: true,
          header: 'Zeit',
          width: 60,
          renderer: function (v) {
            return Ext.util.Format.date(v, 'H:i:s');
          },

          align: 'left'
        }
        ]
      })
    ];
    this.stapel_store.load();
    this.callParent(arguments);

  }
})
