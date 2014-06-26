/* 
 * 
 */
"use strict";  
define([ 
    'jqueryui', 
    'underscore', 
    'backbone', 
    'point', 
    'route', 
    'general' 
], function($, _, Backbone, Point, Route, General) {
    
    return Backbone.Model.extend({
        
        idAttribute: "orderId",
//        url: General.getUrl('/order/saveOrder'),
        
        toRowOfTable: function(){
            var data = $.extend({}, this.attributes);
            var defaults = this.defaults();
            data.statusName = General.getStatusName(data.status);
            if(data.createDatetime !== defaults.createDatetime){
                data.createDatetime = $.format.date(data.createDatetime, "dd-MM-yy HH:mm");
            }
            if(data.arriveDatetime !== defaults.arriveDatetime){
                data.arriveDatetime = $.format.date(data.arriveDatetime, "dd-MM-yy HH:mm");
            }
            else {
                data.arriveDatetime = $.format.date(data.arriveDatetime, "HH:mm");
            }
            data.tarifId = General.getTypeById(data.tarif_id);
            data.carTypeColor = General.CarTypeToColor[data.tarif_id];
            data.paymentColor = General.PaymentToColor[data.payment];
            data.getUrl = General.getUrl;
//            data.ex = "sdsdfs sdfsdfsdfsdfsdfsdf sdfsdfsd sdsdfs sdfsdfsdfsdfsdfsdf sdfsdfsd sdsdfs sdfsdfsdfsdfsdfsdf sdfsdfsd sdfsdfsd sdfsdfsdf sdfsdfsdfsd sdfsdfsdfsdfsdf sdfsdfsdfsdf";
            return data;
        },
        
        toDetailForm: function(){            
            var data = this.toJSON();
            data.defaults = this.defaults();
            if(data.createDatetime !== data.defaults.createDatetime){
                data.createDatetime = $.format.date(data.createDatetime, "dd-MM-yyyy HH:mm");
            }
            if(data.arriveDatetime !== data.defaults.arriveDatetime){
                data.arriveDatetime = $.format.date(data.arriveDatetime, "dd-MM-yyyy HH:mm");
            }
            var length = data.route.length();
            data.routeLength = length === "0" ? "0" : length.slice(0, -3) + "," + length.slice(-3) + " км";
            data.cost = data.cost === "0" ? "0" : data.cost + " грн";
            data.carTypes = General.CarTypes;
            data.id = this.isNew() ? "" : data.id;
            
            return data;
        },
        
        toDeleteForm: function(){            
            var data = $.extend({}, this.attributes);
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
                callsign: null,
                city: "1",
                customerName: "",
                customerPhone: "",
                customerPhone2: "",//-
                cost: "0",
                courierDelivery: "0",
                createDatetime: new Date(),
                dispatcherId: null,
                dispatcher_note: "",
                downTimes: 0,//-
                driverId: null,
                driver_note: "",//-
                gprsNotes: "",//-
                grach: "0",
                extracard: null,//-
                hour: "0",
                length: "0",
                namesign: "0",
                payment: "cash_payment_tarif",
                points: [defaultPoint],
                porch: "",
                regularCustomer: "0",//-
                reservation: "0",//-
                reservDate: "",//-
                reservTime: "",//-
                route: new Route({points: [defaultPoint], length: "0"}),
                salonLoading: "0",
                sms: null,
                status: "6",
                takeDatetime: "00-00-0000 00:00",
                tarif_id: "6",
                terminal: "0",
                ticket: "0",
                voucher: null//-
                // № поездки
                // СМС
            };
        },

        parse: function(response) {
//            console.log(response);
            response.id = response.orderId;
            var points = [];
            _.each(response.points, function( point ) {
                points.push(new Point({
                    street: point.point.street,
                    number: point.point.number,
                    lat: point.location.lat,
                    lng: point.location.lng
                }));
            });
            response.route = new Route({points: points, length: response.length});
            return response;
        }
    });
});

