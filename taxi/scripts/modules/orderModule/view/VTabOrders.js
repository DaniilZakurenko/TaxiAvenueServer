/* 
 * Представление вкладки с заказами
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'general',  
    'modules/orderModule/view/VOrderList'
], function($, _, Backbone, General, VOrderList) {
    "use strict";
    
    return Backbone.View.extend({
        
        selectedOrder: undefined,

        initialize: function(params) {
            this.el = params.el;
            this.vOrderList = new VOrderList({parent: this, collection: params.collection});
            this.$el.append(this.vOrderList.$el);
//            console.log(this.el);
        },
        
        // Проверяем принадлежность заказа вкладке
        belongsToTab: function(status) {
            var tabName = General.StatusToTab[status];
            if(tabName !== this.el) 
                return false;
            return true;
        }
        
    });
});

