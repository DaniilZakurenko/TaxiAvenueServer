/* 
 * Представление заказа в таблице (строка)
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'general',  
    'dialog'
], function($, _, Backbone, General, Dialog) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: "div",
        id: "routeMap",
        className: "routeMap",
        widthMap: 520,
        heightMap: 625,
        widthDialog: 550,
        heightDialog: 750,
        
        mapElem: null,
        directionsDisplay: null,
        directionsService: null,
        
        events: {
            "click img"     :      "hide"
        },
        
        initialize: function() {
            this.$el.width(this.widthMap);
            this.$el.height(this.heightMap);
            this.createMap();
            this.render();
        },
        
        createMap: function(){
            var options = {
                modal   : true,
                width: this.widthDialog,
                height: this.heightDialog,
                title: 'Маршрут',
                resizable: false,
                buttons: { 'Ok': function(){ $(this).dialog("close"); } }
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        render: function(){         
            this.directionsService = new General.GoogleMap.gMaps.DirectionsService();
            this.directionsDisplay = new General.GoogleMap.gMaps.DirectionsRenderer();
            
            this.map = new General.GoogleMap.gMaps.Map(this.el, {
                zoom: 14,
                center: General.GoogleMap.centerMap
            });
            this.directionsDisplay.setMap(this.map);
        },
        
        showRoute: function(points){
            
            var waypts = [],
                count = points.length;
            
            for(var i = 1; i < count - 1; i++){
                waypts.push({
                    location: points[i].toGoogleMapPoint(),
                    stopover: true
                });
            }
            var request = {
                origin: points[0].toGoogleMapPoint(),
                destination: points[count-1].toGoogleMapPoint(),
                waypoints: waypts,
                travelMode: General.GoogleMap.gMaps.TravelMode.DRIVING
            };
            
            var routeMap = this;
            this.directionsService.route(request, function(response, status) {
                if (status === General.GoogleMap.gMaps.DirectionsStatus.OK) {
                    routeMap.directionsDisplay.setDirections(response);
                }
            });
        }
    });
});


