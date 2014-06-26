/* 
 * 
 */
(function(MapModule){
    "use strict";
    
    var MDriver = Backbone.Model.extend( {
        
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
                taxi_location: new MapModule.Point({ 
                    location: { lat: params.taxi_location_lat, lng: params.taxi_location_lng } 
                }),
                taxi_status_update: params.taxi_status_update,
                
                marker: {
                    title: params.driver_name,
                    position: new MapModule.gMaps.LatLng(params.taxi_location_lat, params.taxi_location_lng),
                    visible: MapModule.StatusToVisible[params.taxi_status || this.defaults.taxi_status],
                    icon: MapModule.MarkerImages.default
                }
            });
        },
        
        setMarker: function(){
            var text = "" + this.attributes['driver_callsign'], 
                model = this, 
                height = 42,
                width = 24, 
                left = 0,
                top = 0, 
                canvas = document.createElement("canvas");
            
            canvas.width = width;
            canvas.height = height;
            var context = canvas.getContext("2d");

            for(var i = text.length; i <= 3; i++){
                text = " " + text;
            }

            var img = new Image();
            var color = MapModule.StatusToColor[this.attributes['taxi_status']];
            if(this.attributes['car_self_carport'] === '0'){
                img.src = MapModule.MarkerImages.out[color];
            }
            else {
                img.src = MapModule.MarkerImages.own[color];
            }
            img.onload = function(){
                context.drawImage(img, left, top, width, height);
                context.moveTo(left, top);

                context.fillStyle = "#000";
                context.font = "bold 11px sans-serif";
                context.fillText(text, left, top+17);
                
                model.updateMarker(canvas.toDataURL());
                
                model.trigger('loadIcon', model);
            };
        },
        
        updateMarker: function(img){
            this.attributes['marker'] = {
                title: this.attributes.driver_callsign + " (" + this.attributes.driver_name + ")",
                position: new MapModule.gMaps.LatLng(this.attributes.taxi_location_lat, this.attributes.taxi_location_lng),
                visible: MapModule.StatusToVisible[this.attributes.taxi_status],
                icon: img
            };
            this.trigger('loadIcon', this);
        }
    });
    
    MapModule.MDriver = MDriver;
    
})(MapModule);

