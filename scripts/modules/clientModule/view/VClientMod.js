/* 
 * 
 */
define([
    'jqueryui',
    'underscore', 
    'backbone', 
    'dialog',
    'modules/clientModule/collections/ClientList',
    'modules/clientModule/view/VClientList', 
    'paginationEx'
], 
function($, _, Backbone, Dialog, ClientList, VClientList, VPagination) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'div',
        
        // Количество строк в таблице
        get LIMIT_RECORDS() { return 15; },
        
        dialog              : null,
        clientListView      : null,
        paginationView      : null,
        
        initialize: function() {
            this.collection = new ClientList({ limit: this.LIMIT_RECORDS });
            
            this.clientListView = new VClientList({ collection: this.collection });
            this.paginationView = new VPagination({ collection: this.collection });
            
            this.render();
        },
        
        render: function() {
            this.createDialog();
            
            this.$el.append(this.clientListView.$el);
            this.$el.append(this.paginationView.$el);
            
            return this;
        },
        
        // Вызов в функции render
        createDialog: function() {
            var self = this;
            var options = {
                width: 810,
                height: 650,
                title: 'Клиенты',
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
            this.collection.close();
            this.clientListView.remove();
            this.paginationView.remove();
        }
        
    });
    
});