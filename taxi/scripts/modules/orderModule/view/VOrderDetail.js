/* 
 * Представление заказа в таблице (строка)
 */
define([
    'jqueryui', 
    'underscore', 
    'backbone',  
    'dialog', 
    'general',   
    'templates'
], function($, _, Backbone, Dialog, General, templates) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'form',
        className: 'orderDetail group',
        attributes: { name: "orderDetail" },
        template: _.template(templates.orderDetail),
        
        events: {
            "click button.plusWay"                  :      "addPoint",
            "click button.minusWay"                 :      "removePoint",
            "change input[name='point[0][S]']"      :      "findDrivers",
            "change input[name='point[0][N]']"      :      "findDrivers",
            "keyup label.street input"              :      "loadAddresses",
            "click #loadAddress option"             :      "setSelectedAddress"
        },
        
        initialize: function() {
            this.createDialog();
            
            this.$el.on("change", $.proxy(this, "getCostInfo"));
//            this.listenTo(this.model, "change", this.render);
            
            this.render();
        },
        
        render: function() {
            var view = this.template(this.model.toDetailForm());
            this.$el.html(view);
            this.setUI();
            return this;
        },
        
        // Вызов в функции render
        setUI: function() {
            this.$el.find("input[name='reservDate']").datepicker({ 
                dateFormat: "dd-mm-yy", changeMonth: true, changeYear: true 
            });
            this.$el.find("fieldset.fluidTariffing button").button();
        },
        
        // Вызов при иннициализации
        createDialog: function() {
            var options = {
                modal   : true,
                title   : this.model.isNew() ? "Новый заказ" : "Редактирование заказа",
                width: 950,
                height: 850,
                buttons: [
                    {
                        text: 'Сохранить',
                        click: $.proxy(this, 'saveOrder'),
                        id: 'saveOrder'
                    },
                    {
                        text: 'Отмена',
                        click: function(){ $(this).dialog("close"); }
                    }
                ]
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        /*
         * Сохранение заказа
         * Обратный вызов из диалога (createDialog)
         */
        saveOrder: function() {
            this.dialog.showLoader();
            $("#saveOrder").prop("disabled", true).addClass("ui-state-disabled");
                       
            $.ajax({
                type: 'POST',
                context: this,
                url: General.getUrl('/order/saveOrder'),
                data: this.$el.serializeArray(),
                success: function(data){
                    var result = (eval('(' + data + ')')).result;
                    var title, message;
                    if(result.status === "OK"){
                        title = "Успех";
                        message = "Данные сохранены";
                    }
                    else {
                        title = "Ошибка";
                        message = "При сохранении данных произошла ошибка. Повторите попытку позже.";
                    }
                    this.dialog.removeLoader();
                    this.dialog.close({ title: title, message: message, reload: true });
                },
                error: function(){
                    General.Logger.log("VOrderDetail/saveOrder: Ошибка при сохранении данных о заказе.");
                }
            });
        },
        
        /*
         * Обработчик событий изменений полей формы
         * Определяется при иннициализации
         */
        getCostInfo: function() {
            $.ajax({
                type: "POST",
                context: this,
                url: General.getUrl('/order/getOrderCostInfo'),
                data: this.$el.serializeArray(),
                success: this.showCostInfo,
                error: function(data, message){
                    General.Logger.log(message);
                }
            });            
        },
        
        // Обратный вызов из функции getCostInfo
        showCostInfo: function(data) {
            try{
                var result = (eval('(' + data + ')')).costInfo;
//                console.log(result);
                if(result.error){
                    return;
                }

                var length = "" + result.length;
                this.$el.find("fieldset.costInfo p.routeLength span").text(length.slice(0, -3) + "," + length.slice(-3) + " км");
                this.$el.find("fieldset.costInfo p.routeCost span").text(result.cost + " грн");
            }
            catch(e){
                General.Logger.log("VOrderDetail/showCostInfo: " + e.message);
            }
        },
        
        // Обработчик события "click #loadAddress option"
        setSelectedAddress: function(e){
            var $select = this.$el.find("#loadAddress");
            var $point = $select.prev("div.point");
            $point.find("label.street input").val($(e.target).text());
            $select.remove();
            this.setAddress();
        },
        
        /*
         * Обработчик событий 
         *      "change input[name='point[0][S]']"
         *      "change input[name='point[0][N]']"
         */
        findDrivers: function() {
            var addr = this.setAddress();
            if(!addr) return;
            
            var view = this;
            General.GoogleMap.getCodeByAddress(addr, function(location){
                $.ajax({
                    type: 'POST',
                    url: General.getUrl('/driver/findDriver'),
                    data: { lat: location.lat(), lng: location.lng() },
                    success: $.proxy(view, "showDriversCallsign"),
                    error: function(jqXHR, message){
                        General.Logger.log("VOrderDetail/findDrivers: " + message);
                    }
                });
            });
        },
        
        /*
         * Вызов из функций
         *      findDrivers
         *      setSelectedAddress
         */
        setAddress: function() {
            var $point = this.$el.find("div.point").first();
            var addr = this.trimField($point.find("input[name='point[0][S]']"));
            if(addr === ""){
                this.$el.find("input[name='addr']").val("").end()
//                        .find("input[name='point[0][N]']").val("").end()
                        .find('input[name="forcedOrder"]').removeAttr("checked").end()
                        .find('input[name="callsigns"]').val('').end()
                        .find('input[name="callsign"]').val('');
                return;
            }
            
            var number = this.trimField($point.find("input[name='point[0][N]']"));
            if(number !== ""){
                addr += ", " + number;
            }
            this.$el.find("input[name='addr']").val(addr);
            return addr;
        },
        
        // Обратный вызов из функции findDrivers
        showDriversCallsign: function(data) {
            var data = eval('(' + data + ')');
//            console.log(data);
            
            var $callsigns = this.$el.find('div.callsigns p').first();
            var callsign = this.model.get("callsign");
            $callsigns.text("");
            if(data.message) {
                this.$el.find('input[name="forcedOrder"]').prop('checked', false);
                if(!callsign){
                    $callsigns.text(data.message);
                    this.$el.find('input[name="callsign"]').val('');
                }
                else{
                    $callsigns.append($("<span></span>").text(callsign));
                }
            }
            else if(Array.isArray(data)) {
                this.$el.find('input[name="forcedOrder"]').prop('checked', true);
                for(var i = 0; i < data.length; i++){
                    $callsigns.append($("<span></span>").text(data[i]));
                }
                if(!callsign){
                    this.$el.find('input[name="callsign"]').val(data[0]);
                }
            }
        },
        
        // Обработчик события "keyup label.street input"
        loadAddresses: function(e) {
            var $point = $(e.target).closest("div.point");
//            var street = this.trimField($point.find("label.street input"));
//            var number = this.trimField($point.find("label.house input"));
            var street = $point.find("label.street input").val();
            var number = $point.find("label.house input").val();
            
            $.ajax({
                type: "POST",
                context: this,
                url: General.getUrl('/dispatcher/getCoord'),
                data: {
                    street : street,
                    number : number
                },
                success: function(data){
                    this.showAddresses(data, $point);
                },
                error: function(data, message){
                    General.Logger.log(message);
                }
            });
        },
        
        // Обратный вызов из функции loadAddresses
        showAddresses: function(data, $point){
            var result = eval('(' + data + ')');
//            console.log(result);
            if(!result) return;
            
            var $select = this.$el.find("#loadAddress");
            if($select.length === 0){
                $select = this.createAddressSelect();
            }
            else {
                $select.html('');
            }
            
            $select.css({
                left: $point.css("left"),
                top: $point.css("top")
            }).insertAfter($point);
            for(var i = 0; i < result.length; i++){
                var $option = $("<option></option>").val(i).text(result[i]);
                $select.append($option);
            }
        },
        
        // Вызов из функции showAddresses
        createAddressSelect: function() {
            return $("<select></select>").attr({
                id: "loadAddress",
                size: 20
            });
        },
        
        // Обработчик события "click button.plusWay"
        addPoint: function() {
            var $route = this.$el.find("fieldset.route");
            var $allPoints = this.$el.find("div.point");
            var $newPoint = $allPoints.first().clone();
            $newPoint.find("button.minusWay")
                    .removeClass("hide").end()
                    .find("label.street span").text("Куда: ").end()
                    .find("label.street input").val("").end()
                    .find("label.house input").val("");
            $newPoint.insertBefore($route.find("div.dir"));
            this.updatePoints();
        },
        
        // Обработчик события "click button.minusWay"
        removePoint: function(e) {
            $(e.target).closest("div.point").remove();
            this.updatePoints();
            this.$el.trigger("change");
        },
        
        /*
         * Вызов из функций
         *      addPoint
         *      removePoint
         */
        updatePoints: function() {
            try{
                // Меняем индексы имеющихся точек
                var $points = this.$el.find("div.point");
                $points.each(function(idx){
                    if(idx < 1)
                        return;
                    $(this).find("label.street input").attr("name", "point[" + idx + "][S]")
                           .end().find("label.house input").attr("name", "point[" + idx + "][N]");
                });

                // Устанавливаем флаг "По городу"
                if($points.length > 1){
                    this.$el.find('input[name="city"]').removeAttr("checked");
                }
                else {
                    this.$el.find('input[name="city"]').click();
                }
            }
            catch(e){
                General.Logger.log("VOrderDetail/updatePoints: " + e.message);
            }
        },
        
        trimField: function($elem) {
            var value = $.trim($elem.val());
            $elem.val(value);
            return value;
        }
        
    });
});
