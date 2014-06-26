/* 
 * Представление для карты водителей
 */
(function(MapModule){
    "use strict";
    
    var VDriverMap = Backbone.View.extend({
        
        markers: [],
        infoWindow: null,

        initialize: function(params) {
            this.map = new MapModule.gMaps.Map(document.getElementById('map_canvas'), {
                zoom: 12,
                center: MapModule.centerMap
            });
            
            this.infoWindow = new MapModule.gMaps.InfoWindow();
            
            this.collection = params.collection;
            for(var i = 0; i < this.collection.length; i++){
                var model = this.collection.models[i];
                this.listenTo(model, "loadIcon", this.updateMarker);
                model.setMarker();
            }
            
            this.listenTo(this.collection, "change", this.update);
            
            this.render();
        },
        
        render: function() {
            for(var i = 0; i < this.collection.length; i++){
                this.createMarker(this.collection.models[i]);
            }
            return this;
        },
        
        update: function() {
            for(var i = 0; i < this.collection.length; i++){
                this.collection.models[i].setMarker();
            }
            return this;
        },
        
        createDriverInfo: function(model){
            var info = "<div id='driverInfo'><p>Водитель: " + model.get("driver_surname") + " ";
            info += model.get("driver_name") + " " + model.get("driver_patronymic");
            info += "</p><p>Автомобиль:</p><ul>";
            info += "<li>Марка: " + model.get("car_model") + "</li>";
            info += "<li>Номер: " + model.get("car_number") + "</li>";
            info += "<li>Цвет: " + model.get("car_color") + "</li>";
            info += "</ul></div>";
            return info;
        },
        
        createMarker: function(model) {
            var markerParams = model.get("marker");
            var marker = new MapModule.gMaps.Marker({
                map: this.map,
                title: markerParams.title,
                icon: markerParams.icon,
                position: markerParams.position,
                visible: markerParams.visible
            });
            this.markers[model.get("driver_id")] = marker;
            
            var driverMap = this;
            MapModule.gMaps.event.addListener(marker, 'click', function() {
                driverMap.infoWindow.setContent(driverMap.createDriverInfo(model));
                driverMap.infoWindow.open(driverMap.map, marker);
            });
        },
        
        updateMarker: function(model){
            var markerParams = model.get("marker");
            var marker  = this.markers[model.get("driver_id")];
            marker.setIcon(markerParams.icon);
            marker.setPosition(markerParams.position);
            marker.setVisible(markerParams.visible);
        }
    });
    
    MapModule.VDriverMap = VDriverMap;
    
})(MapModule);




