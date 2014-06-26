/* 
 * 
 */
"use strict";
define(['underscore', 'backbone', 'general'], function(_, Backbone, General) {
    
    var Point = Backbone.Model.extend({
        
        defaults: {
            street: '',
            number: '',
            lat: undefined,
            lng: undefined
        },
        
        getAddress: function(){
            return this.get("street") + ", " + this.get("number");
        },
        /*
        toJSON: function(){
            return {
                street: this.attributes.street,
                number: this.attributes.number,
                lat: this.attributes.lat,
                lng: this.attributes.lng
            };
        },
        */
        
        toString: function(){
            return this.get("street") + ", " + this.get("number");
        },
        
        toGoogleMapPoint: function(){
            return new General.GoogleMap.gMaps.LatLng(this.get("lat"), this.get("lng"));
        }
        
    });
    
    return Point;
    
});
