/* 
 * 
 */
define([
    'jqueryui',
    'underscore', 
    'backbone', 
    'dialog',   
    'templates'
], 
function($, _, Backbone, Dialog, templates) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'div',
        id: 'tarifficationMod',
        template    : _.template(templates.settingsMod),

        events: {
            "click button.tarifficationMod"         :       "showTarifficationModule",
            "click button.mutualPaymentsMod"        :       "showMutualPaymentsModule",
            "click button.sectorsMod"               :       "showSectorsModule",
            "click button.mapMod"                   :       "showMapModule"
        },
        
        dialog              : null,
        
        initialize: function() {
            this.$el.html(this.template());
            this.createDialog();
            this.$el.find("button").button();
            
//            this.render();
        },
        
        showTarifficationModule: function() {
            console.log("showTarifficationModule");
            this.dialog.close();
        },
        
        showMutualPaymentsModule: function() {
            console.log("showMutualPaymentsModule");
            this.dialog.close();
        },
        
        showSectorsModule: function() {
            console.log("showSectorsModule");
            this.dialog.close();
        },
        
        showMapModule: function() {
            console.log("showMapModule");
            this.dialog.close();
        },
        
        // Вызов в функции render
        createDialog: function() {
            var self = this;
            var options = {
                width: 460,
                height: 105,
                position: 'center top',
                resizable: false,
                title: 'Настройки',
                close   : function(){ 
                    self.close();
                    self.remove(); 
                    $(this).dialog('destroy');
                },
                buttons : {  }
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        close: function(){
//            this.driverList.close();
//            this.controlPannelView.remove();
//            this.driverListView.remove();
//            this.paginationView.remove();
        }
        
    });
    
});