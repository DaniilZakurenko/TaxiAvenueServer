/*
 * Общие настройки для работы карты
 */
(function(exports){
    "use strict";
    
    /*
     * Пространство имен
     */
    var MapModule = {
        get GoogleMapKey() { return "AIzaSyCppCmUuNf9PJdQOnFP6JgD7HaDDFKU6Eg"; },
        
        gMaps: google.maps,
        
        centerMap: new google.maps.LatLng(48.464717, 35.046183)
    };
    
    MapModule.Point = function(params){

        var _id = params.point_id;
        var _point = params.point;
        var _street;
        var _number;
        if(_point !== undefined){
            _street = params.point['street'];
            _number = params.point['number'];
        }
        var _name;
        if(_street !== undefined)
            _name = _street + ", " + _number;

        var _location = params.location;
        var _lat = params.location['lat'];
        var _lng = params.location['lng'];

        Object.defineProperties(this, {
            // Ограничиваем доступ 
            id: { value: _id, writable: false, enumerable:true, configurable:false },
            point: { value: _point, writable: false, enumerable:true, configurable:false },
            street: { value: _street, writable: false, enumerable:true, configurable:false },
            number: { value: _number, writable: false, enumerable:true, configurable:false },
            name: { value: _name, writable: false, enumerable:true, configurable:false },
            lat: { value: _lat, writable: false, enumerable:true, configurable:false },
            lng: { value: _lng, writable: false, enumerable:true, configurable:false },
            location: {value: _location, writable: false, enumerable:true, configurable:false}
        });

    };
    MapModule.Point.prototype.constructor = MapModule.Point;

    MapModule.Point.prototype.toGoogleMapPoint = function(){
        return new MapModule.gMaps.LatLng(this.lat, this.lng);
    };
    
    MapModule.StatusToColor = {
        '1' : 'green',
        '2' : 'yellow',
        '3' : 'yellow',
        '4' : 'blue',
        '5' : 'gray',
        '19': 'white',
        '20': 'white',
        '21': 'red',
        '23': 'gray'
    };
        
    MapModule.StatusToVisible = {
        '1': true,
        '2': true,
        '3': true,
        '4': true,
        '5': false,
        '19': false,
        '20': false,
        '21': true,
        '23': false
    };
        
    MapModule.getUrl = function(uri){
        return 'http://' + window.location.hostname + uri;
    };
    
    // 
    MapModule.MarkerImages = {
        default: MapModule.getUrl('/images/markers/default.png'),
//        default: MapModule.getUrl('/images/markers/red1.png'),
        out: {
            red     : MapModule.getUrl('/images/markers/red1.png'),
            blue    : MapModule.getUrl('/images/markers/blue1.png'),
            green   : MapModule.getUrl('/images/markers/green1.png'),
            yellow  : MapModule.getUrl('/images/markers/yellow1.png'),
            gray    : MapModule.getUrl('/images/markers/default.png'),
            white   : MapModule.getUrl('/images/markers/default.png')
        },
        own: {
            red     : MapModule.getUrl('/images/markers/red_hover.png'),
            blue    : MapModule.getUrl('/images/markers/blue_hover.png'),
            green   : MapModule.getUrl('/images/markers/green_hover.png'),
            yellow  : MapModule.getUrl('/images/markers/yellow_hover.png'),
            gray    : MapModule.getUrl('/images/markers/default.png'),
            white   : MapModule.getUrl('/images/markers/default.png')
        }
    };
    
    
    
    exports.MapModule = MapModule;
    
})(window);

