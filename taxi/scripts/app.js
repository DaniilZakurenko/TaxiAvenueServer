/* 
 * C:\Users\Admin\Documents\NetBeansProjects\taxiavenue.corvus.dp.ua\scripts\modules\control\settings
 */
define([
    'jqueryui',
    'underscore', 
    'backbone',
    'general',
    'modules/orderModule/models/Order',
    'modules/orderModule/view/VOrderDetail', 
    'modules/orderModule/view/VOrdersLayout',
    'modules/driverModule/view/VDriverMod', 
    'modules/clientModule/view/VClientMod', 
    'modules/report/order/view/VOrderList', 
    'modules/control/settings/SettingsMod'
], 
function($, _, Backbone, General, Order, VOrderDetail, VOrdersLayout, VDriverMod, VClientMod, OrdersReportMod, SettingsMod){
    "use strict";
    
    return Backbone.View.extend({
        
        driversMap: null,
        
        el: $('#application'),
        
        events: {
            "click div.menu_bottom li.create"       :       "createOrder",
            "click div.menu_bottom ul li.map"       :       "showDriversMap",
            "click div.data_table li.showDrivers"   :       "showDriversList",
            "click div.data_table li.showClients"   :       "showClientList",
            "click div.reports li.orderReport"      :       "showOrdersReport",
            "click div.control li.showSettings"     :       "showSettings"
        },
        
        initialize: function() {
            this.ordersModule = new VOrdersLayout();
            
//            setTimeout(function(){
//                $("table.orderList tbody td img.delete").last().click();
//            }, 1500);
            
//            this.showOrdersReport();
//            this.showSettings();
//            console.log(this.$el);
        },
        
        createOrder: function() {
            new VOrderDetail({model: new Order()});
        },
        
        // Отчет по заказам
        showOrdersReport: function() {
            this.ordersReportMod = new OrdersReportMod();
        },
        
        showDriversList: function() {
            this.driversModule = new VDriverMod();
        },
        
        showClientList: function() {
//            console.log(this.driversModule);
            this.clientModule = new VClientMod();
        },
        
        // Карта, отображающая расположение всех водителей
        showDriversMap: function(){
            if(this.driversMap === null || this.driversMap.closed){
                this.driversMap = window.open("driver/getDriversMap");
            }
            else {
                this.driversMap.focus();
            }
        },
        
        showSettings: function() {
            this.settingsMod = new SettingsMod();
        }

    });
});