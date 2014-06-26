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
        className: 'reportOrderDetail group',
        
        map: null,
        directionsDisplay: null,
        directionsService: null,
        
        cloneAttr: {},
        toSaveModel: false,
        
        template: _.template(templates.reportOrderDetail),
        $route: null,
        
        events: {
            "click button.plusWay"                  :      "addPoint",
            "click button.minusWay"                 :      "removePoint",
            "keyup label.street input"              :      "loadAddresses",
            "change label.street input"             :      "updatePointAtMap",
            "change label.house input"              :      "updatePointAtMap",
            "click .loadAddress option"             :      "setSelectedAddress"
        },
        
        initialize: function() {
            this.createDialog();
            
            this.listenTo(this.model, "change:route", this.showRoute);
            
            this.render();
        },
        
        render: function() {
            var view = this.template(this.model.toDetailForm());
            this.$el.html(view);
            this.$route = this.$el.find("fieldset.route").first();
            
            if(!this.directionsDisplay){
                this.createMap();
            }
            this.showRoute();
            
            return this;
        },
        
        // Вызов при иннициализации 
        createDialog: function() {
            var self = this;
            var options = {
                modal   : true,
                title   : "Отчет по заказу детально",
                width: 950,
                height: 850,
                close   : function(){
                    if(!self.toSaveModel && !_.isEmpty(self.cloneAttr)){
                        self.model.set(self.cloneAttr);
                    }
                    self.remove(); 
                    $(this).dialog('destroy');
                },
                buttons: [
                    {
                        text: 'Редактировать',
                        click: $.proxy(this, 'editReport'),
                        id: 'edit'
                    },
                    {
                        text: 'История изменений',
                        click: $.proxy(this, 'historyOfReport')
                    },
                    {
                        text: 'Закрыть',
                        click: function(){ $(this).dialog("close"); }
                    }
                ]
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        createMap: function(){
            var mapElem = this.$el.find("div.map").get(0);
            
            this.directionsService = new General.GoogleMap.gMaps.DirectionsService();
            this.directionsDisplay = new General.GoogleMap.gMaps.DirectionsRenderer();
            
            this.map = new General.GoogleMap.gMaps.Map(mapElem, {
                zoom: 14,
                maxZoom: 16,
                mapTypeId: General.GoogleMap.gMaps.MapTypeId.ROADMAP,
                center: General.GoogleMap.centerMap
            });
            this.directionsDisplay.setMap(this.map);
        },
        
        showRoute: function(){
            var points = this.model.get("route").get("points"),
                waypts = [],
                count = points.length;
            
            for(var i = 1; i < count - 1; i++){
                waypts.push({
                    location: points[i].toGoogleMapPoint(),
                    stopover: true
                });
            }
            var request = {
                origin: points[0].toGoogleMapPoint(),
                destination: points[count-1].toGoogleMapPoint(),
                waypoints: waypts,
                travelMode: General.GoogleMap.gMaps.TravelMode.DRIVING
            };
            
            var routeMap = this;
            this.directionsService.route(request, function(response, status) {
                if (status === General.GoogleMap.gMaps.DirectionsStatus.OK) {
                    routeMap.directionsDisplay.setDirections(response);
                }
            });
        },
        
        /*
         * Сохранение изменений
         * Обратный вызов из диалога (createDialog)
         */
        editReport: function(e) {
            var $button = $(e.currentTarget);
            if($button.text() === "Редактировать"){
                $button.find("span.ui-button-text").text("Сохранить");
                this.$el.find("input, select, textarea, button")
                        .not("[name='orderId'], [name='createDatetime'], [name='arriveDatetime'], [name='finishDatetime']")
                        .prop("disabled", false);
                
                this.$el.find("input[name='cost']").val(this.model.get("cost"));
                this.$el.find("input[name='length']").val(this.model.get("route").length());
                
                this.cloneAttr = this.model.cloneAttr();
//                console.log(this.model.get("route"));
//                console.log(this.cloneAttr);
            }
            else {
                this.toSaveModel = true;
                this.save();
//                $button.find("span.ui-button-text").text("Редактировать");
//                this.$el.find("input, select, textarea, button").prop("disabled", true);
            }
        },
        
        /*
         * Сохранение изменений
         * Вызов из editReport
         */
        save: function() {
            this.dialog.showLoader();
            $("#edit").prop("disabled", true).addClass("ui-state-disabled");
            
            var formData = {
                addr: this.$el.find("input[name='address']").val(),
                address: this.$el.find("input[name='address']").val(),
                apartment: this.$el.find("input[name='apartment']").val(),
                callsign: this.$el.find("input[name='callsign']").val(),
                customerName: this.$el.find("input[name='customerName']").val(),
                customerPhone: this.$el.find("input[name='customerPhone']").val(),
                cost: this.$el.find("input[name='cost']").val(),
                dispatcher_note: this.$el.find("textarea[name='dispatcherNote']").val(),
                driver_note: this.$el.find("textarea[name='driverNote']").val(),
                dispatcherNote: this.$el.find("textarea[name='dispatcherNote']").val(),
                driverNote: this.$el.find("textarea[name='driverNote']").val(),
                length: this.$el.find("input[name='length']").val(),
                porch: this.$el.find("input[name='porch']").val(),
                status: this.$el.find("select[name='status'] option:selected").val(),
                tarif_id: this.$el.find("select[name='tarif'] option:selected").val(),
                tarif: this.$el.find("select[name='tarif'] option:selected").val()
            };
            
            var $form = this.$el;
            this.$route.find("div.point").each(function(idx){
                formData["point[" + idx + "][S]"] = $form.find("input[name='point[" + idx + "][S]']").val();
                formData["point[" + idx + "][N]"] = $form.find("input[name='point[" + idx + "][N]']").val();
            });
//            console.log(this.$route.find("div.point"));
            
            var self = this;
            this.model.save(formData, function(data){
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
                self.dialog.removeLoader();
                self.dialog.close({ title: title, message: message });
            });
        },
        
        /*######################## Обработчики ###########################*/
        
        // Обработчик события "click button.plusWay"
        addPoint: function() {
            var $allPoints = this.$route.find("div.point");
            var $newPoint = $allPoints.first().clone();
            $newPoint.find("button.minusWay")
                    .removeClass("hide").end()
                    .find("label.street span").text("Куда").end()
                    .find("label.street input").val("").end()
                    .find("label.house input").val("");
            $newPoint.insertBefore(this.$route.find("div.dir"));
            
            this.updatePointsIdx();
            
            var pointCid = this.model.addPoint({idx: $newPoint.attr("data-idx")});
            $newPoint.attr("data-point-cid", pointCid);
        },
        
        // Обработчик события "click button.minusWay"
        removePoint: function(e) {
            var $point = $(e.target).closest("div.point");
            var cid = $point.attr("data-point-cid");
//            console.log("view/removePoint: " + cid);
            $point.remove();
            this.updatePointsIdx();
            if(cid !== ""){
                this.model.removePoint(cid);
            }
        },
        
        historyOfReport: function() {
            alert("Функционал не реализован");
        },
        
        /*
         * Вызов из функций
         *      addPoint
         *      removePoint
         */
        updatePointsIdx: function() {
            // Меняем индексы имеющихся точек
            this.$route.find("div.point").each(function(idx){
                if(idx < 1)
                    return;
                $(this).attr("data-idx", idx)
                       .find("label.street input").attr("name", "point[" + idx + "][S]")
                       .end().find("label.house input").attr("name", "point[" + idx + "][N]");
            });
        },
        
        // Обработчик события "keyup label.street input"
        loadAddresses: function(e) {
            var $point = $(e.target).closest("div.point");
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
            if(!result) return;
            
            var $select = this.$route.find(".loadAddress").first();
            if($select.length === 0){
                $select = $("<select></select>").attr({
                    class: "loadAddress",
                    size: 15
                });
            }
            else {
                $select.html('');
            }
            
            var position = $point.position();
            $select.css({
                left: position.left + 60,
                top: position.top + 25
            }).insertAfter($point);
            for(var i = 0; i < result.length; i++){
                var $option = $("<option></option>").val(i).text(result[i]);
                $select.append($option);
            }
        },
        
        // Обработчик события "click .loadAddress option"
        setSelectedAddress: function(e){
            var $select = this.$route.find(".loadAddress").first();
            var $point = $select.prev("div.point");
            $point.find("label.street input").val($(e.target).text());
            $select.remove();
        },
        
        /*
         * 
         */
        updatePointAtMap: function(e) {
//            console.log("view/updatePointAtMap");
            var $point = $(e.currentTarget).closest("div.point");            
            this.model.updatePoint({
                cid: $point.attr("data-point-cid"),
                street: $.trim($point.find("label.street input").val()),
                number: $.trim($point.find("label.house input").val())
            });
        }
        
    });
});
