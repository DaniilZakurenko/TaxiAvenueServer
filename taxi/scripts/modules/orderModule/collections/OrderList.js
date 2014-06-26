/* 
 * 
 */
"use strict";
define([
    'jqueryui', 
    'underscore', 
    'backbone',  
    'general', 
    'point', 
    'route', 
    'modules/orderModule/models/Order'
], function($, _, Backbone, General, Point, Route, Order) {
    
    var OrderList = Backbone.Collection.extend({
        
        model: Order,
        url: General.getUrl('/order/getOrderListJSON'),

        setFromTable: function() {
            var rows$ = $('div#orderListStart > div');
            for(var i = 0; i < rows$.length; i++){
                this.setOrderFromTableRow((rows$.eq(i)));
            }
            $('div#orderListStart').remove();
        },

        setOrderFromTableRow: function(row$) {
            var params = {};
            params.id = params.orderId = row$.find("input[name='orderId']").val();

            params.createDatetime = row$.find("input[name='createDatetime']").val();
            params.takeDatetime = row$.find("input[name='takeDatetime']").val();
            params.arriveDatetime = row$.find("input[name='arriveDatetime']").val();

            params.callsign = row$.find("input[name='callsign']").val();
            params.clientName = row$.find("input[name='name']").val();
            params.clientPhone = row$.find("input[name='phone']").val();
            params.cost = row$.find("input[name='cost']").val();
            params.payment = row$.find("input[name='payment']").val();
            params.tarif_id = row$.find("input[name='tarif_id']").val();
            params.length = row$.find("input[name='length']").val();
            params.dispatcher_note = row$.find("input[name='dispatcher_note']").val();
            params.airCondition = row$.find("input[name='addService[airCondition]']").val();
            params.salonLoading = row$.find("input[name='addService[salonLoading]']").val();
            params.animal = row$.find("input[name='addService[animal]']").val();
            params.city = row$.find("input[name='city']").val();
            params.courierDelivery = row$.find("input[name='addService[courierDelivery]']").val();
            params.terminal = row$.find("input[name='terminal']").val();
            params.namesign = row$.find("input[name='addService[nameSign]']").val();
            params.hour = row$.find("input[name='hour']").val();
            params.grach = row$.find("input[name='grach']").val();
            params.ticket = row$.find("input[name='ticket']").val();
            params.status = row$.find("input[name='status']").val();
            
            var points = [];
            row$.find('div.point').each(function(i){
                points.push(new Point({
                    street: $(this).find("input[name='street']").val(),
                    number: $(this).find("input[name='number']").val(),
                    lat: $(this).find("input[name='lat']").val(),
                    lng: $(this).find("input[name='lng']").val()
                }));
            });
            params.points = points;
            params.route = new Route({points: points, length: params.length});

            this.add(new Order(params));
        },
        
        parse: function(response) {
//            console.log(response.orders);
            return response.orders;
        },
        
        ex: function(){
            
        }
    });
    
    return new OrderList();
    
});


