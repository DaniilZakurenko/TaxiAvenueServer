/*
 * Общие настройки приложения
 */
define(["jqueryui"], function($) {
    "use strict";
    
    var General = {
        
        storage: (function(){
            var _storageName = "Taxiavenue",
                _storage = window.localStorage,
                _defaults = {
                    settingsMainPageOrders: {
                        visibleFields: ["callsign", "arriveDatetime", "clientPhone", "route", "cost", "status", "tarifId"]
                    },
                    settingsReportOrders: {
                        countOfRecords: 17,
                        visibleFields: ["orderId", "status", "callsign", "firstPoint", "lastPoint", "clientPhone", "cost", "length", 
                            "createDatetime", "tarifId", "driverNote", "dispatcherNote", "travelNumber", "dispatcherId"]
                    }
                };
//                _storage.setItem(_storageName, JSON.stringify(_defaults));
                if(_storage.length === 0){
                    _storage.setItem(_storageName, JSON.stringify(_defaults));
                }
                var _data = JSON.parse(_storage.getItem(_storageName));
            
            return {
                save: function(fieldName, fieldValue){
                    _data[fieldName] = fieldValue;
                    _storage.setItem(_storageName, JSON.stringify(_data));
                },
                get: function(fieldName){
                    return _data[fieldName];
                },
                remove: function(fieldName){
                    if(_data[fieldName]){
                        delete _data[fieldName];
                        _storage.setItem(_storageName, JSON.stringify(_data));
                    }
                },
                debugStorage: function(){
                    return _storage;
                },
                debugData: function(){
                    return _data;
                }
            };
        })(),
       
        // Функция для формирования url страницы запроса
        getUrl: function(uri){
            return 'http://' + window.location.hostname + uri;
        },

        // Статусы
        StatusList: [
            {id: '1', name: 'Водитель свободен'},
            {id: '2', name: 'Взял заказ'},
            {id: '3', name: 'Выполняет заказ'},
            {id: '4', name: 'Водитель занят'},
            {id: '5', name: 'Водитель не в сети'},
            {id: '6', name: 'Заказ доступен'},
            {id: '7', name: 'Заказ взят'},
            {id: '8', name: 'Заказ выполняется'},
            {id: '9', name: 'Заказ выполнен'},
            {id: '10', name: 'Заказ удалён'},
            {id: '11', name: 'В ожидании пассажира'},
            {id: '12', name: 'Пассажир не вышел'},
            {id: '13', name: 'Опаздываю на 5 минут'},
            {id: '14', name: 'Опаздываю на 10 минут'},
            {id: '15', name: 'Опаздываю на 15 минут'},
            {id: '16', name: 'Отказ от принятия персонального заказа'},
            {id: '17', name: 'Заказ закрыт (не выполнен)'},
            {id: '18', name: 'Заказ закрыт (нет машины)'},
            {id: '19', name: 'Водитель заблокирован'},
            {id: '20', name: 'Водитель удалён'},
            {id: '21', name: 'Байкал'},
            {id: '22', name: 'Заказ закрыт (Не завершён по уважительной причине)'},
            {id: '23', name: 'Водитель недоступен'},
            {id: '24', name: 'Заказ закрыт (отказ клиента)'},
            {id: '25', name: 'Заказ удалён (ошибочно созданный)'}
        ],

        StatusToColor: {
            '1' : 'green',
            '2' : 'yellow',
            '3' : 'yellow',
            '4' : 'blue',
            '5' : 'gray',
            '19': 'white',
            '20': 'white',
            '21': 'red',
            '23': 'gray'
        },

        // Соответствие статуса заказа вкладке
        StatusToTab: {
            4   : '#tabs-2',
            6   : '#tabs-1',
            7   : '#tabs-1',
            8   : '#tabs-3',
            11  : '#tabs-1'
        },

        getStatusName: function(id){
            for(var i = 0; i < this.StatusList.length; i++){
                if(this.StatusList[i].id === id){
                    return this.StatusList[i].name;
                }
            }
        },

        // Утвержденные цвета автомобилей
        TaxiColors: [
            'Бежевый',
            'Белый',
            'Бордовый',
            'Голубой',
            'Желтый',
            'Зелёный',
            'Золотистый',
            'Коричневый',
            'Красный',
            'Оливковый',
            'Оранжевый',
            'Серый',
            'Серебристый',
            'Синий',
            'Фиолетовый',
            'Черный'
        ],

        // Типы тарифов для авто
        CarTypes: [
            {id: '1', type: 'Бизнес'},
            {id: '2', type: 'Премиум'},
            {id: '3', type: 'Груз'},
            {id: '4', type: 'Универсал'},
            {id: '5', type: 'Микроавтобус'},
            {id: '6', type: 'Базовый'}
        ],

        CarTypeToColor: {
            '1' : 'default',
            '2' : 'default',
            '3' : 'default',
            '4' : 'paleYellow',
            '5' : 'default',
            '6' : 'default'
        },

        PaymentToColor: {
            'cash_payment_tarif'        : 'default',
            'non_cash_payment_tarif'    : 'paleBrown'
        },

        getTypeById: function(id){
            for(var i = 0; i < this.CarTypes.length; i++){
                if(this.CarTypes[i].id === id){
                    return this.CarTypes[i].type;
                }
            }
        },

        GoogleMap: (function(){
            var maps = google.maps;
            return {
                // Ключ на сервере: AIzaSyC-vCIMjc9uDjAtDogy3A9J9NXPLxxI4-0
                get GoogleMapKey() { return "AIzaSyCppCmUuNf9PJdQOnFP6JgD7HaDDFKU6Eg"; },
                
                gMaps: maps,
                
                centerMap: new maps.LatLng(48.464717, 35.046183),
                
                getCodeByAddress: function(address, callback){
                    address = "Украина, Днепропетровск, " + address;
                    var geocoder = new maps.Geocoder();
                        geocoder.geocode( { 'address': address }, function(results, status) {
                        if (status === maps.GeocoderStatus.OK) {
                            callback(results[0].geometry.location);
                        }
                    });
                }
            };
        })(),

        makePreview: function(img, size){
            var w = img.width, h = img.height, s = w / h;
            if(w > size && h > size) {
                if(img.width > img.height) {
                    img.width = size;
                    img.height = size / s;
                }
                else {
                    img.height = size;
                    img.width = size * s;
                }
            }
            return img;
        },

        Logger: {
            log: function(message, error){
                var mes = [$.format.date($.now(), "dd-MM-yyyy HH:mm:ss")];
                mes.push(message);
                if(error){
                    error = error.stack || '';
                    mes.push(error);
                }
    //            TAXIAVENUE.dialog.debug(mes);
                console.log(mes);
            }
        }
    };    
    
    return General;
});
