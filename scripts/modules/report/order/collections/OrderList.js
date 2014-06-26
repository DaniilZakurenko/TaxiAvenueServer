/* 
 * 
 */
"use strict";
define([
    'jquery',  
    'underscore',
    'backbone',  
    'general', 
    'modules/report/order/models/Order'
], function($, _, Backbone, General, Order) {
    
    return Backbone.Collection.extend({
        
        model       : Order,
        url         : General.getUrl('/order/getOrderListJSON'),
        
        requestData : {
            sortDir     : "DESC",
            sortField   : "orderId",
            limit       : 10,
            offset      : 0,
            filter      : {}
        },

        initialize: function() {
            this.comparator = this.sortByNumber("id");
        },
        
        // Объект, устанавливающий сортировку полей коллекции
        sortBy: function(sortDir){
            this.requestData.sortDir = sortDir;
            var self = this;
            return {
                orderId: function(){
                    self.requestData.sortField = "orderId";
                    self.comparator = self.sortByNumber("id");
                },
                status: function(){
                    self.requestData.sortField = "status";
                    self.comparator = self.sortByNumber("status");
                },
                callsign: function(){
                    self.requestData.sortField = "callsign";
                    self.comparator = self.sortByNumber("callsign");
                },
                firstPoint: function(){
                    self.requestData.sortField = "firstPoint";
                    self.comparator = self.sortByPoint("firstPoint");
                },
                lastPoint: function(){
                    self.requestData.sortField = "lastPoint";
                    self.comparator = self.sortByPoint("lastPoint");
                },
                clientPhone: function(){
                    self.requestData.sortField = "clientPhone";
                    self.comparator = self.sortByString("clientPhone");
                },
                cost: function(){
                    self.requestData.sortField = "cost";
                    self.comparator = self.sortByNumber("cost");
                },
                arriveDatetime: function(){
                    self.requestData.sortField = "arriveDatetime";
                    self.comparator = self.sortByDate("arriveDatetime");
                },
                createDatetime: function(){
                    self.requestData.sortField = "createDatetime";
                    self.comparator = self.sortByDate("createDatetime");
                },
                length: function(){
                    self.requestData.sortField = "length";
                    self.comparator = self.sortByNumber("length");
                },
                dispatcherId: function(){
                    self.requestData.sortField = "dispatcherId";
                    self.comparator = self.sortByNumber("dispatcherId");
                },
                tarifId: function(){
                    self.requestData.sortField = "tarifId";
                    self.comparator = self.sortByNumber("tarifId");
                },
                clientPaymentType: function(){
//                    self.sortField = "clientPaymentType";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю clientPaymentType не реализована");
                },
                additionalCard: function(){
//                    self.sortField = "additionalCard";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю additionalCard не реализована");
                },
                downTimes: function(){
//                    self.sortField = "downTimes";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю downTimes не реализована");
                },
                downTimeCost: function(){
//                    self.sortField = "downTimeCost";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю downTimeCost не реализована");
                },
                driverNote: function(){
                    self.requestData.sortField = "driverNote";
                    self.comparator = self.sortByString("driverNote");
                },
                dispatcherNote: function(){
                    self.requestData.sortField = "dispatcherNote";
                    self.comparator = self.sortByString("dispatcherNote");
                },
                discount: function(){
//                    self.sortField = "discount";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю discount не реализована");
                },
                paymentType: function(){
//                    self.sortField = "paymentType";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю paymentType не реализована");
                },
                travelNumber: function(){
//                    self.sortField = "travelNumber";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю travelNumber не реализована");
                },
                taxiFrom: function(){
//                    self.sortField = "taxiFrom";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю taxiFrom не реализована");
                },
                taxiFromTitle: function(){
//                    self.sortField = "taxiFromTitle";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю taxiFromTitle не реализована");
                },
                taxiTo: function(){
//                    self.sortField = "taxiTo";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю taxiTo не реализована");
                },
                taxiToTitle: function(){
//                    self.sortField = "taxiToTitle";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю taxiToTitle не реализована");
                },
                statusTransfer: function(){
//                    self.sortField = "statusTransfer";
//                    self.comparator = self.sortById;
                    console.log("Сортировка по полю statusTransfer не реализована");
                }
            };
        },
        
        sortByString: function(fieldName){
            return function(order1, order2){
                var str1 = order1.get(fieldName);
                var str2 = order2.get(fieldName);

                if(this.requestData.sortDir === "DESC"){
                    if(!str1){
                        return 1;
                    }
                    if(!str2){
                        return -1;
                    }
                    return str1.localeCompare(str1);
                }
                else {
                    if(!str2){
                        return 1;
                    }
                    if(!str1){
                        return -1;
                    }
                    return str1.localeCompare(str2);
                }
            };
        },
        
        sortByPoint: function(fieldName){
            return function(order1, order2){
                var point1, point2;
                if(fieldName === 'firstPoint'){
                    point1 = order1.get("route").firstPoint().getAddress();
                    point2 = order2.get("route").firstPoint().getAddress();
                }
                else if(fieldName === 'lastPoint'){
                    point1 = order1.get("route").lastPoint().getAddress();
                    point2 = order2.get("route").lastPoint().getAddress();
                }

                if(this.requestData.sortDir === "DESC"){
                    if(!point1){
                        return 1;
                    }
                    if(!point2){
                        return -1;
                    }
                    return point2.localeCompare(point1);
                }
                else {
                    if(!point2){
                        return 1;
                    }
                    if(!point1){
                        return -1;
                    }
                    return point1.localeCompare(point2);
                }
            };
        },
        
        sortByDate: function(fieldName){
            return function(order1, order2){
                var date1 = Date.parse(order1.get(fieldName));
                var date2 = Date.parse(order2.get(fieldName)); 

                if(this.requestData.sortDir === "DESC"){
                    if(isNaN(date1)){
                        return 1;
                    }
                    if(isNaN(date2)){
                        return -1;
                    }
                    return date2 - date1;
                }
                else {
                    if(isNaN(date1)){
                        return -1;
                    }
                    if(isNaN(date2)){
                        return 1;
                    }
                    return date1 - date2;
                }
            };
        },
        
        sortByNumber: function(fieldName){
            return function(order1, order2){
                var val1 = parseInt(order1.get(fieldName));
                var val2 = parseInt(order2.get(fieldName));
                
                if(this.requestData.sortDir === "DESC"){
                    if(isNaN(val1)){
                        return 1;
                    }
                    if(isNaN(val2)){
                        return -1;
                    }
                    return val2 - val1;
                }
                else {
                    if(isNaN(val1)){
                        return -1;
                    }
                    if(isNaN(val2)){
                        return 1;
                    }
                    return val1 - val2;
                }
            };
        },
        
        getList: function(data, reset){
            this.reset = reset;
            data = _.extend(this.requestData, data);
            
            $.ajax({
                type: 'post',
                url: this.url,
                data: data,
                context: this,
                error: function(){
                    General.Logger.log("modules/report/order/collection/OrderList: не удалось получить данные о заказах.");
                },
                success: this.responseHandler
            });
        },
        
        getFilteredList: function(data){
            this.requestData.offset = 0;
            this.getList(data, true);
        },
        
        saveAsExcel: function(data){
            data = _.extend(this.requestData, data);
            $.ajax({
                type: 'post',
                url: General.getUrl('/report/getOrderReportXls'),
                data: data,
                context: this,
                error: function(){
                    General.Logger.log("modules/report/order/collection/OrderList: не удалось получить данные о заказах.");
                },
                success: function(data){
                    var result = eval('(' + data + ')');
                    var idx = result.filepath.indexOf("taxiavenue.corvus.dp.ua/");
                    var link = result.filepath.slice(idx + 24);
                    window.open(link);
                }
            });
        },
        
        /*
         * Обработка полученных данных
         */
        responseHandler: function(data){
            var result = eval('(' + data + ')'), 
                list = result.orders.orderList,
                orders = [];
            
            for(var i = 0; i < list.length; i++){
                orders.push(Order.create(list[i]));
            }
            this.set(orders);
            this.trigger('load', {countOfRecords: result.orders.count, reset: this.reset});
        }
    });
    
});


