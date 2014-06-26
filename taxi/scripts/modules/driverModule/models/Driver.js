/* 
 * 
 */
"use strict";  
define([ 
    'jqueryui', 
    'underscore', 
    'backbone', 
    'point', 
    'general' 
], function($, _, Backbone, Point, General) {
    
    return Backbone.Model.extend({
        
        defaults: {
            driver_photo: '/images/background_Preview_picture.png',
            car_color: '#000',
            car_type: '6',
            car_terminal: '0',
            car_condition: '0',
            taxi_status: '5'
        },

        initialize: function(params) {            
            this.set({
                id: params.driver_id,
                driver_id: params.driver_id,
                driver_callsign: params.driver_callsign,
                driver_surname: params.driver_surname,
                driver_name: params.driver_name,
                driver_patronymic: params.driver_patronymic,
                driver_mobile_phone: params.driver_mobile_phone,
                driver_phone: params.driver_phone,
                driver_address: params.driver_address,
                driver_passport: params.driver_passport,
                driver_dob: params.driver_dob,
                driver_admission_date: params.driver_admission_date,
                driver_dismissal_date: params.driver_dismissal_date,
                driver_see_non_cash: params.driver_see_non_cash,
                driver_only_non_cash: params.driver_only_non_cash,
                driver_passenger_phone: params.driver_passenger_phone,
                driver_photo: params.driver_photo || this.defaults.driver_photo,

                car_year: params.car_year,
                car_type: params.car_type || this.defaults.car_type,
                car_terminal: params.car_terminal || this.defaults.car_terminal,
                car_condition: params.car_condition || this.defaults.car_condition,
                car_commission: params.car_commission,
                car_fee: params.car_fee,
                car_tariff_ind: params.car_tariff_ind,
                car_number: params.car_number,
                car_model: params.car_model,
                car_color: params.car_color || this.defaults.car_color,
                car_commission_period_pay: params.car_commission_period_pay,
                car_fee_period: params.car_fee_period,
                car_notes: params.car_notes,
                car_self_carport: params.car_self_carport,

                taxi_status: params.taxi_status || this.defaults.taxi_status,
                
                taxi_location: new Point({
                    street: "",
                    number: "",
                    lat: params.taxi_location_lat,
                    lng: params.taxi_location_lng
                }),
                taxi_status_update: params.taxi_status_update
            });
            
        },
        
        toDetailForm: function(){            
            var data = this.toJSON();
            data.defaults = this.defaults;
            data.TaxiColors = General.TaxiColors;
            data.CarTypes = General.CarTypes;
            data.getUrl = General.getUrl;
            data.StatusTypes = [      // Статусы водителей
                {id: '1',  name: 'Водитель свободен'},           // green        +
                {id: '2',  name: 'Взял заказ'},                  // yellow       +
                {id: '3',  name: 'Выполняет заказ'},             // yellow       +
                {id: '4',  name: 'Водитель занят'},              // yellow       +
                {id: '5',  name: 'Водитель не в сети'},          // ---          -
                {id: '19', name: 'Водитель заблокирован'},      // gray         -
                {id: '20', name: 'Водитель удалён'},            // gray         -
                {id: '21', name: 'Байкал'},                     // red          +
                {id: '23', name: 'Водитель недоступен'}
            ];
            
            return data;
        },
        
        toRowOfList: function(){
            var data = $.extend({}, this.attributes);
            data.General = General;           
            return data;
        },

        save: function($form, callback) {
            $form.ajaxSubmit({
                type: 'POST',
                url: General.getUrl('/driver/saveDriver'),
                context: this,
                success: function(data){
                    var parseData = eval('(' + data + ')');
                    if(parseData.result.status === "OK"){
                        this.set(parseData.result.driver);
                        callback({ status: "Успех", mes: "Данные успешно сохранены" });
                    }
                    else {
                        callback({ status: "Ошибка", mes: "Произошла ошибка, попробуйте сохранить данные позже" });
                    }
                },
                error: function(data, message){
                    General.Logger.log("Driver/save: Ошибка при сохранении данных. (" + message + ")");
                }
            });
        },

        removeFromCollection: function() {
            this.trigger('removeFromCollection', this);
        },

        validate: function(attrs) {
            this.checkSurname(attrs.driver_surname);
            this.checkName(attrs.driver_name);
            this.checkPatronymic(attrs.driver_patronymic);
            this.checkDob(attrs.driver_dob);
            this.checkPassport(attrs.driver_passport);
            this.checkPhone(attrs.driver_mobile_phone);
            this.checkAddress(attrs.driver_address);
            this.checkAdmissionDate(attrs.driver_admission_date);
            this.checkCallsign(attrs.driver_callsign);
            this.checkPassword(attrs.driver_password);
            this.checkCarCommission(attrs.car_commission);
            this.checkCarCommissionPeriodPay(attrs.car_commission_period_pay);
            this.checkCarFee(attrs.car_fee);
            this.checkCarFeePeriod(attrs.car_fee_period);
            this.checkCarNumber(attrs.car_number);
            this.checkCarModel(attrs.car_model);
            this.checkCarYear(attrs.car_year);
        },

        checkName: function(name) {
            if(name.length < 2){
                throw new Error("Поле 'Имя' должно быть не менее 2 символов");
//                this.trigger('invalidCallsign', { message: mes });
//                throw {
//                    name: "Error",
//                    message: "Error",
//                    field: "driver_name"
//                };
            }
        },
        
        checkSurname: function(surname) {
            if(surname.length < 2){
                throw new Error("Поле 'Фамилия' должно быть не менее 2 символов");
            }
        },

        checkPatronymic: function(patronymic) {
            if(patronymic.length < 2){
                throw new Error("Поле 'Отчество' должно быть не менее 2 символов");
            }
        },

        checkPassport: function(passport) {
            if(passport.length < 8){
                throw new Error("Поле 'Паспорт' должно быть не менее 8 символов");
            }
        },

        checkPhone: function(phone) {
            if(phone.length < 6){
                throw new Error("Поле 'Телефон' должно быть не менее 6 символов");
            }
        },

        checkAddress: function(phone) {
            if(phone.length < 4){
                throw new Error("Поле 'Адрес' должно быть не менее 4 символов");
            }
        },

        checkCallsign: function(callsign) {
            var mes;
            callsign = $.trim(callsign);
            if (callsign.length === 0){
                mes = "Необходимо заполнить поле 'Позывной'";
            }
            
            if(!this.attributes['driver_id']){
                var drivers = this.collection.models;
                for(var i = 0; i < drivers.length; i++){
                    if(drivers.models[i].get("driver_callsign") === callsign){
                        mes = "Указанный позывной уже существует.";
                        break;
                    }
                }
            }
            
            if(mes !== undefined){
                throw new Error(mes);
            }
        },
        
        checkDob: function(dob) {
            if(dob.length  === 0){
                throw new Error("Необходимо заполнить поле 'Дата рождения'");
            }
        },
        
        checkAdmissionDate: function(admission_date) {
            if(admission_date.length  === 0){
                throw new Error("Необходимо заполнить поле 'Дата приёма'");
            }
        },
        
        checkPassword: function(password) {
            // Проверяем при добавлении нового водителя
            if(this.isNew() && password.length < 3){
                throw new Error("Поле 'Пароль' должно быть не менее 3 символов");
            }
        },
        
        checkCarCommission: function(car_commission) {
            if(car_commission.length  === 0){
                throw new Error("Необходимо заполнить поле 'Комиссия за заказ'");
            }
        },
        
        checkCarColor: function(car_color) {
            if(car_color.length  === 0){
                throw new Error("Необходимо заполнить поле 'Цвет'");
            }
        },
        
        checkCarFee: function(car_fee) {
            if(car_fee.length  === 0){
                throw new Error("Необходимо заполнить поле 'Абонплата (грн)'");
            }
        },
        
        checkCarFeePeriod: function(car_fee_period) {
            if(car_fee_period.length  === 0){
                throw new Error("Необходимо заполнить поле 'Абонплата (период)'");
            }
        },
        
        checkCarNumber: function(car_number) {
            if(car_number.length  === 0){
                throw new Error("Необходимо заполнить поле 'Номер автомобиля'");
            }
        },
        
        checkCarModel: function(car_model) {
            if(car_model.length  === 0){
                throw new Error("Необходимо заполнить поле 'Марка автомобиля'");
            }
        },
        
        checkCarYear: function(car_year) {
            if(car_year.length  === 0){
                throw new Error("Необходимо заполнить поле 'Год выпуска'");
            }
        }
        
    });
});

