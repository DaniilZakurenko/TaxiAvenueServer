/* 
 * 
 */
define([ 
    'jqueryui', 
    'underscore', 
    'backbone', 
    'point', 
    'route', 
    'general' 
], function($, _, Backbone, Point, Route, General) {
    "use strict";
    
    var Order = Backbone.Model.extend({
        
        idAttribute: "orderId",
        
        toRowOfTable: function(){
//            var data = this.attributes;
            var data = $.extend({}, this.attributes);
            var defaults = this.defaults();
            data.statusName = General.getStatusName(data.status);
            data.firstPoint = data.route.firstPoint().getAddress();
            data.lastPoint = data.route.lastPoint() ? data.route.lastPoint().getAddress() : "&nbsp;";
            data.clientPhone = data.customerPhone ? data.customerPhone : "&nbsp;";
            var length = data.route.length();
            data.routeLength = length === "0" ? "0" : length.slice(0, -3) + "," + length.slice(-3);
            if(data.createDatetime !== defaults.createDatetime){
                data.createDatetime = $.format.date(data.createDatetime, "dd-MM-yyyy HH:mm:ss");
            }
            if(data.arriveDatetime !== defaults.arriveDatetime){
                data.arriveDatetime = $.format.date(data.arriveDatetime, "dd-MM-yyyy HH:mm:ss");
            }
            else {
                data.arriveDatetime = $.format.date(data.arriveDatetime, "HH:mm:ss");
            }
            if(data.finishDatetime !== defaults.finishDatetime){
                data.finishDatetime = $.format.date(data.finishDatetime, "dd-MM-yyyy HH:mm:ss");
            }
            data.tarifId = General.getTypeById(data.tarif_id);            
            return data;
        },
        
        toDetailForm: function(){
//            var data = this.attributes;
            var data = $.extend({}, this.attributes);
            var defaults = this.defaults();
//            data.costInfo = data.cost === "0" ? "0" : data.cost + " грн";
            var length = data.route.length();
            data.routeLength = length === "0" ? "0" : length.slice(0, -3) + "," + length.slice(-3) + " км";
            if(data.createDatetime !== defaults.createDatetime){
                data.createDatetime = $.format.date(data.createDatetime, "dd-MM-yyyy HH:mm:ss");
            }
            if(data.arriveDatetime !== defaults.arriveDatetime){
                data.arriveDatetime = $.format.date(data.arriveDatetime, "dd-MM-yyyy HH:mm:ss");
            }
            else {
                data.arriveDatetime = $.format.date(data.arriveDatetime, "HH:mm:ss");
            }
            if(data.finishDatetime !== defaults.finishDatetime){
                data.finishDatetime = $.format.date(data.finishDatetime, "dd-MM-yyyy HH:mm:ss");
            }
            data.tarifId = General.getTypeById(data.tarif_id);
            data.StatusTypes = [
                {id: '6',   name: 'Заказ доступен'},
                {id: '7',   name: 'Заказ взят'},
                {id: '8',   name: 'Заказ выполняется'},
                {id: '9',   name: 'Заказ выполнен'},
                {id: '10',  name: 'Заказ удалён'},
                {id: '12',  name: 'Пассажир не вышел'},
                {id: '17',  name: 'Заказ закрыт (не выполнен)'},
                {id: '18',  name: 'Заказ закрыт (нет машины)'},
                {id: '22',  name: 'Заказ закрыт (Не завершён по уважительной причине)'},
                {id: '24',  name: 'Заказ закрыт (отказ клиента)'},
                {id: '25',  name: 'Заказ удалён (ошибочно созданный)'}
            ];
            data.CarTypes = [
                {id: '1', type: 'Бизнес'},
                {id: '2', type: 'Премиум'},
                {id: '3', type: 'Груз'},
                {id: '4', type: 'Универсал'},
                {id: '5', type: 'Микроавтобус'},
                {id: '6', type: 'Базовый'}
            ];
            
            return data;
        },
        
        defaults: function(){
            var defaultPoint = new Point({
                    street: "",
                    number: "",
                    lat: "",
                    lng: ""
            });
            return {
                address: "",
                airCondition: "0",
                animal: "0",
                apartment: "",
                arriveDatetime: "00-00-0000 00:00",
                callsign: undefined,
                city: "1",
                customerName: "",
                customerPhone: "",
                customerPhone2: "",
                cost: "0",
                courierDelivery: "0",
                createDatetime: new Date(),
                dispatcherId: undefined,
                dispatcher_note: "",
                driverId: undefined,
                driver_note: "",
                finishDatetime: "00-00-0000 00:00",
                gprsNotes: "",
                grach: "0",
                extracard: null,
                hour: "0",
                length: "0",
                namesign: "0",
                payment: "cash_payment_tarif",
                points: [defaultPoint],
                porch: "",
                regularCustomer: "0",
                reservation: "0",
                reservDate: "",
                reservTime: "",
                route: new Route({points: [defaultPoint], length: "0"}),
                salonLoading: "0",
                status: "6",
                takeDatetime: "00-00-0000 00:00",
                tarif_id: "6",
                terminal: "0",
                ticket: "0",
                voucher: null
            };
        },
        
        toJSON: function(){
            var json = this.cloneAttr();
            json.route = json.route.toJSON();
            json.points = json.route.points;
            return json;
        },
        
        save: function(formData, callback){
            // Очистка старых точек формы, которые возможно были сохранены ранее
            // (баг хранения-передачи данных)
            for(var prop in this.attributes){
                if(prop.indexOf("point[") !== -1){
                    delete this.attributes[prop];
                }
            }
            
            this.set(formData);
            
            var data = [];
            for(var prop in this.attributes){
                data.push({
                    name: prop,
                    value: this.attributes[prop]
                });
            }
            
            $.ajax({
                type: 'POST',
                url: General.getUrl('/order/saveOrder'),
                data: data,
                context: this,
                success: function(data){
//                    this.trigger("change");
                    callback(data);
                },
                error: function(){
                    General.Logger.log("VOrderDetail/saveOrder: Ошибка при сохранении данных о заказе.");
                }
            });
        },

        cloneAttr: function() {
            var attr = $.extend({}, this.attributes);
            attr.arriveDatetime = attr.arriveDatetime.toString();
            attr.createDatetime = attr.createDatetime.toString();
            attr.finishDatetime = attr.finishDatetime.toString();
            attr.takeDatetime = attr.takeDatetime.toString();
            attr.route = attr.route.clone();
            attr.points = attr.route.get("points");
            return attr;
        },
        
        /*
        clone: function() {
            var attr = $.extend({}, this.attributes);
            attr.arriveDatetime = attr.arriveDatetime.toString();
            attr.createDatetime = attr.createDatetime.toString();
            attr.finishDatetime = attr.finishDatetime.toString();
            attr.takeDatetime = attr.takeDatetime.toString();
            attr.route = attr.route.clone();
            attr.points = attr.route.get("points");
            return new this.constructor(attr);
        },
        */

        updatePoint: function(params) {
//            console.log("order/updatePoint");
            var point = this.get("route").getPoint(params.cid);
            if(!point || !params.street || !params.number){
                return;
            }
            var addr = params.street + ", " + params.number;
            var self = this;
            General.GoogleMap.getCodeByAddress(addr, function(location){
                point.set({
                    street: params.street,
                    number: params.number,
                    lat: location.lat(), 
                    lng: location.lng()
                });
                self.trigger("change:route");
            });
        },

        addPoint: function(params) {
//            console.log("order/addPoint");
            return this.get("route").addPoint(params);
        },

        removePoint: function(cid) {
            this.get("route").removePoint(cid);
            this.trigger("change:route");
        }
    }, {
        create: function(params) {
//            console.log(params);
            params.id = params.orderId;            
            var points = [];
            _.each(params.points, function( point ) {
                points.push(new Point({
                    street: point.point.street,
                    number: point.point.number,
                    lat: point.location.lat,
                    lng: point.location.lng
                }));
            });
            params.points = points;
            params.route = new Route({points: points, length: params.length});
            
            return new Order(params);
        }
    });
    
    return Order;
});

