/* 
 * 
 */
"use strict";
define([
    'underscore', 'backbone', 'point', 'general'
], function(_, Backbone, Point, General) {
    
    var Route = Backbone.Model.extend({
        
        defaults: {
            points: [],
            length: 0
        },

//        parse: function(response) {
//            console.log(response);
//        },
        
        countOfPoints: function(){
            return this.get("points").length;
        },
        
        firstPoint: function(){
            return this.get("points")[0];
        },
        
        lastPoint: function(){
            return this.get("points")[this.countOfPoints() - 1];
        },
        
        length: function(){
            return this.get("length");
        },
        
        toJSON: function(){
            var p = [];
            for(var i = 0; i < this.attributes.points.length; i++){
                p.push(this.attributes.points[i].toJSON());
            }
            return {
                points: p,
                length: this.attributes.length
            };
        },

        clone: function() {
            var points = [];
            _.each(this.attributes.points, function(point){
                points.push(point.clone());
            });
            var attr = {
                points: points,
                length: this.attributes.length
            };
            return new this.constructor(attr);
        },

        getPoint: function(cid) {
            var points = this.get("points");
            var length = points.length;
            for(var i = 0; i < length; i++){
                if(points[i].cid === cid){
                    return points[i];
                }
            }
            
            return null;
        },

        updatePoint: function(params) {
            var point = this.getPoint(params.cid);
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
//                console.log(point);
                self.trigger("change:route");
            });
        },

        addPoint: function(params) {
//            console.log("route/addPoint. street: " + params.street + "; number: " + params.number + "; idx: " + params.idx);
            var point = new Point({
                street: params.street,
                number: params.number
            });
            
            var idx = parseInt(params.idx, 10);
            if(isNaN(idx) || idx === this.get("points").length){
                this.get("points").push(point);
            }
            else {
                var points = [];
                _.each(this.get("points"), function(_point, idx){
                    if(params.idx === idx){
                        points.push(point);
                    }
                    points.push(_point);
                });
                this.set("points", points);
            }
            return point.cid;
        },

        removePoint: function(cid) {
            var points = [];
            _.each(this.get("points"), function(point){
                if(point.cid !== cid){
                    points.push(point);
                }
            });
            this.set("points", points);
        },
        
        toString: function(){
            var data = "", points = this.get("points");
            for(var i = 0; i < points.length; i++){
                data += points[i].toString();
                if(i < points.length - 1){
                    data += "; ";
                }
            }
            return data;
        }
        
    });
    
    return Route;
    
});
