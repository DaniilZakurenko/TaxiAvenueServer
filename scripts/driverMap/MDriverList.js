/* 
 * 
 */
(function(MapModule){
    "use strict";
    
    
    var MDriverList = Backbone.Collection.extend({
        
        model: MapModule.MDriver
    });
    
    MapModule.MDriverList = MDriverList;
    
})(MapModule);


