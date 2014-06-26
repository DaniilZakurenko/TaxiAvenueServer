/* 
 * 
 */
define([
    'jqueryui',
    'underscore', 
    'backbone', 
    'dialog',
    'modules/driverModule/collections/DriverList',
    'modules/driverModule/view/VDriverListControlPannel',
    'modules/driverModule/view/VDriverList', 
    'paginationEx'
], 
function($, _, Backbone, Dialog, DriverList, VControlPannel, VDriverList, VPagination) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'div',
        className: 'driverListTable',
        
        // Количество строк в таблице о водителях
        get LIMIT_RECORDS() { return 15; },
        
        dialog              : null,
        driverList          : null, 
        controlPannelView   : null,
        driverListView      : null,
        paginationView      : null,
        
        initialize: function() {
            this.driverList = new DriverList({ limit: this.LIMIT_RECORDS });
            
            this.controlPannelView = new VControlPannel({ collection: this.driverList });
            this.driverListView = new VDriverList({ collection: this.driverList });
            this.paginationView = new VPagination({ collection: this.driverList });
            
            this.render();
        },
        
        render: function() {
            this.createDialog();
            
            this.$el.append(this.controlPannelView.$el);
            this.$el.append(this.driverListView.$el);
            this.$el.append(this.paginationView.$el);
            
            return this;
        },
        
        // Вызов в функции render
        createDialog: function() {
            var self = this;
            var options = {
                width: 1100,
                height: 860,
                title: 'Сведения о водителях',
                close   : function(){ 
                    self.close();
                    self.remove(); 
                    $(this).dialog('destroy');
                },
                buttons : { "Ok": function(){ $(this).dialog("close"); } }
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        close: function(){
            this.driverList.close();
            this.controlPannelView.remove();
            this.driverListView.remove();
            this.paginationView.remove();
        }
        
    });
    
});