/* 
 * 
 */
define([
    'jqueryui',
    'underscore', 
    'backbone',
    'modules/orderModule/view/VTabOrders',
    'modules/orderModule/collections/OrderList'
], 
function($, _, Backbone, VTabOrders, OrderList) {
    "use strict";
    
    return Backbone.View.extend({
        
        el: $('#ordersLayout'),
        
        orderList: OrderList,
        
        // Константа, определяющее периодичность обновления списка заказов
        get LIST_RELOAD_INTERVAL() { return 30000; },
        
        // Значение, возвращаемое функцией setInterval, при обновлении заказов на странице
        LIST_RELOAD_INTERVAL_MARK: null,

        tabs: {
            tabHot  : "#tabs-1",
            tabPre  : "#tabs-2",
            tabRun  : "#tabs-3"
        },
        
        initialize: function() {
            $(".tabs_section").tabs({});
            this.orderList.setFromTable();
            
            this.tabHot = new VTabOrders({el: this.tabs.tabHot, collection: this.orderList});
            this.tabPre = new VTabOrders({el: this.tabs.tabPre, collection: this.orderList});
            this.tabRun = new VTabOrders({el: this.tabs.tabRun, collection: this.orderList});
            
            this.orderList.fetch();
            this.reloadStart();
        },
        
        reloadStart: function() {
            var list = this.orderList;
            this.LIST_RELOAD_INTERVAL_MARK = setInterval(function() {
//                list.fetch({ reset: true });
                list.fetch();
            }, this.LIST_RELOAD_INTERVAL);
        }
    });
    
});