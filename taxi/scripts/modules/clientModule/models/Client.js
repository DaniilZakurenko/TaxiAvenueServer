/* 
 * 
 */
"use strict";  
define([ 
    'jqueryui', 
    'underscore', 
    'backbone', 
    'general' 
], function($, _, Backbone, General){
    
    var Client = Backbone.Model.extend({
        
        toRowOfList: function(){
            var data = $.extend({}, this.attributes);
            data.getUrl = General.getUrl;           
            return data;
        }
        
//        defaults: function(){
////            var prefixId = "customer_";
//            
//            return {
//                address: ""
//            };
//        }
        
    });
    
    return Client;
    
});