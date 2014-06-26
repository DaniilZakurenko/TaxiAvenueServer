/* 
 * Представление заказа в таблице (строка)
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'general'
], function($, _, Backbone, General) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: "div",
        id: "clientMapWrap",
        
        mapElem: null,
        directionsDisplay: null,
        directionsService: null,
        
        events: {
            "click img"     :      "hide"
        },
        
        initialize: function() {
            this.createMap();
            this.render();
        },
        
        createMap: function(){
            this.$el.appendTo("#application div.information_block");
            $("<img />").attr({
                class: "hideMap",
                title: "Закрыть карту",
                src: General.getUrl("/images/delete.png")
            }).appendTo(this.$el);
            
            this.mapElem = $("<div></div>").attr("id", "clientMap").appendTo(this.$el).get(0);
        },
        
        render: function(){         
            this.directionsService = new General.GoogleMap.gMaps.DirectionsService();
            this.directionsDisplay = new General.GoogleMap.gMaps.DirectionsRenderer();
            
            this.map = new General.GoogleMap.gMaps.Map(this.mapElem, {
                zoom: 14,
                maxZoom: 16,
                center: General.GoogleMap.centerMap
            });
            this.directionsDisplay.setMap(this.map);
        },
        
        showRoute: function(points){
            this.$el.addClass("show");
            
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
        },
        
        hide: function() {
            this.$el.removeClass("show");
        }
    });
});


