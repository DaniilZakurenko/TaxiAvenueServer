/* 
 * Представление вкладки с заказами
 */
define([
    'jquery',
    'underscore',
    'backbone', 
    'general'
], function($, _, Backbone, General) {
    "use strict";
    
    var CollectionEx = Backbone.Collection.extend({
        
        model       : null,
        url         : "",
        
        request: null,
        
        initialize: function(params){
            this.request = _.extend({
                sortDir     : "DESC",
                sortField   : "",
                limit       : 10,
                offset      : 0,
                filter      : {}
            }, params);
        },
        
        getList: function(){
            $.ajax({
                type: 'POST',
                url: this.url,
                data: this.getRequestData(),
                context: this,
                error: function(){
                    General.Logger.log("CollectionEx/getList: не удалось получить данные.");
                },
                success: function(response){
                    var data = this.responseHandler(response);
                    this.set(data.list);
                    this.trigger('load', data.count);
                }
            });
        },
        
        getLimit: function(){         
            return this.request.limit;
        },
        
        /*
         * Установка данных для запроса к серверу
         */
        setRequestData: function(data){            
            this.request = _.extend(this.request, (data || {}));
        },
        
        /*
         * Добавление фильтра в запрос
         */
        addFilter: function(name, value){
            this.request.filter[name] = value;
        },
        
        /*
         * Удаление фильтра из запроса
         */
        removeFilter: function(name){            
            if(this.request.filter[name]){
                delete this.request.filter[name];
            }
        },
        
        /*
         * Получение данных для запроса к серверу
         */
        getRequestData: function(){
            var data = _.clone(this.request);
            
            if(data.sortField === ""){
                delete data.sortDir;
                delete data.sortField;
            }
            
            this.checkRequestData();            
            return data;
        },
        
        /*
         * Обработка полученных данных
         */
        responseHandler: function(){
            throw new Error("CollectionEx/responseHandler: Функция обработки результата запроса должна быть переопределена.");
        },
        
        /*
         * Проверка корректности свойств коллекции для выполнения запроса
         */
        checkRequestData: function() {
            if(!this.model || typeof this.model !== "function"){
                throw new Error("CollectionEx/checkRequestData error model.");
            }
            else if(!this.url || typeof this.url !== "string"){
                throw new Error("CollectionEx/checkRequestData error url.");
            }
        },
        
        close: function(){
            this.stopListening();
            
            for(var prop in this.request.filter){
                delete this.request.filter[prop];
            }
            
            delete this.request;
        }
        
    });
    
    return CollectionEx;
});

