/* 
 * 
 */
"use strict";
define([
    'jquery',  
    'underscore',
    'CollectionEx',
    'general', 
    'modules/clientModule/models/Client'
], function($, _, CollectionEx, General, Client) {
    
    return CollectionEx.extend({
        
        model       : Client,
        url         : General.getUrl('/customer/getCustomerList'),
        
        requestData : {
            sortDir     : "DESC",
            sortField   : "",
            limit       : 10,
            offset      : 0,
            filter      : {}
        },

        initialize: function(params) {
            CollectionEx.prototype.initialize.call(this, params);
            this.getList();
        },
        
        /*
         * Обработка полученных данных
         */
        responseHandler: function(data){
            var list = eval('(' + data + ')'), 
                clients = [];
        
            for(var i = 0; i < list.length; i++){
                clients.push(new Client(list[i]));
            }
            
            return {
                count: list.length,
                list: clients
            };
        }
    });
    
});


