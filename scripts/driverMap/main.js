/* 
 * 
 */
jQuery(function($){
    "use strict";
    
    var module = MapModule;
    
    var driversMap = null;
    
    var driverList = new module.MDriverList();
    
    var parseData = function(data){
        var result = eval('(' + data + ')');
        var drivers = [];
        var list = result.driverList;
        for(var i = 0; i < list.length; i++){
            drivers.push(new module.MDriver(list[i]));
        }
        driverList.set(drivers);
        // 88, 68, 60, 59, 57
        console.log(drivers);
    };
    
    var getData = function(callback){
        $.ajax({
            type: 'post',
            url: module.getUrl('/driver/getDriverList'),
            success: callback
        });
    };
    
    var getListDrivers = function(){
        getData(function(data){
            parseData(data);
            driversMap = new module.VDriverMap({
                collection: driverList
            });
        });
    };
    
    var updateListDrivers = function(){
        getData(parseData);
    };
    
    // Получаем первую порцию данных
    getListDrivers();
    // Запускаем периодическое обновление данных с сервером
    setInterval( updateListDrivers, 3000 );
});
