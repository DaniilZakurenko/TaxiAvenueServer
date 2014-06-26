/* 
 * 
 */
"use strict";  
define([ 
    'jqueryui', 
    'underscore', 
    'CollectionEx',
    'modules/driverModule/models/Driver', 
    'general'
], function($, _, CollectionEx, Driver, General) {
    
    return CollectionEx.extend({
        
        model: Driver,
        url: General.getUrl('/driver/getDriverList'),
        
        initialize: function(params){
            CollectionEx.prototype.initialize.call(this, params);
//            this.setRequestData(params);
            this.getList();
        },
        
        /*
         * Обработка полученных данных
         */
        responseHandler: function(data){
            var result = eval('(' + data + ')'), 
                list = result.driverList,
                drivers = [];
        
            for(var i = 0; i < list.length; i++){
                drivers.push(new Driver(list[i]));
            }
            
            return {
                count: result.count,
                list: drivers
            };
        },
        
        sortBy: function(fieldName, sortDir){
            this.sortDir = sortDir;
            switch(fieldName){
                case "callsign":
                    this.comparator = this.sortByCallsign;
                    break;
                case "surname":
                    this.comparator = this.sortBySurname;
                    break;
                case "name":
                    this.comparator = this.sortByName;
                    break;
                case "patronymic":
                    this.comparator = this.sortByPatronymic;
                    break;
                case "car_number":
                    this.comparator = this.sortByCarNumber;
                    break;
                case "car_model":
                    this.comparator = this.sortByCarModel;
                    break;
                case "car_type":
                    this.comparator = this.sortByCarType;
                    break;
                case "car_color":
                case "car_notes":
                    break;
            }
            
            this.setRequestData({
                sortDir     : sortDir,
                sortField   : fieldName
            });
            this.getList();
        },
        
        sortByCallsign: function(driver1, driver2){
            if(this.sortDir === "DESC")
                return parseInt(driver2.get("driver_callsign")) - parseInt(driver1.get("driver_callsign"));
            else 
                return parseInt(driver1.get("driver_callsign")) - parseInt(driver2.get("driver_callsign"));
        },
        
        sortByName: function(driver1, driver2){
            if(this.sortDir === "DESC")
                return driver2.get("driver_name").localeCompare(driver1.get("driver_name"));
            else 
                return driver1.get("driver_name").localeCompare(driver2.get("driver_name"));
        },
        
        sortBySurname: function(driver1, driver2){
            if(this.sortDir === "DESC")
                return driver2.get("driver_surname").localeCompare(driver1.get("driver_surname"));
            else 
                return driver1.get("driver_surname").localeCompare(driver2.get("driver_surname"));
        },
        
        sortByPatronymic: function(driver1, driver2){
            if(this.sortDir === "DESC")
                return driver2.get("driver_patronymic").localeCompare(driver1.get("driver_patronymic"));
            else 
                return driver1.get("driver_patronymic").localeCompare(driver2.get("driver_patronymic"));
        },
        
        sortByCarModel: function(driver1, driver2){
            if(this.sortDir === "DESC")
                return driver2.get("car_model").localeCompare(driver1.get("car_model"));
            else 
                return driver1.get("car_model").localeCompare(driver2.get("car_model"));
        },
        
        sortByCarNumber: function(driver1, driver2){
            if(this.sortDir === "DESC")
                return driver2.get("car_number").localeCompare(driver1.get("car_number"));
            else 
                return driver1.get("car_number").localeCompare(driver2.get("car_number"));
        },
        
        sortByCarType: function(driver1, driver2){
            var carType1 = General.getTypeById(driver1.get("car_type"));
            var carType2 = General.getTypeById(driver2.get("car_type"));
            if(this.sortDir === "DESC")
                return carType2.localeCompare(carType1);
            else 
                return carType1.localeCompare(carType2);
        }
        
    });
});

