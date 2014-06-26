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
        className: 'orderDelete',
        attributes: { name: "orderDelete" },
        template: _.template(templates.orderDelete),
        
        initialize: function() {
            this.createDialog();            
            this.render();
        },
        
        render: function() {
            var view = this.template(this.model.toDeleteForm());
            this.$el.html(view);
            this.setUI();
            return this;
        },
        
        // Вызов в функции render
        setUI: function() {
            var now = new Date();
            this.$el.find("input[name='date_executed']").datepicker({ 
                dateFormat: "dd-mm-yy", changeMonth: true, changeYear: true 
            }).val($.format.date(now, "dd-MM-yyyy"));
            this.$el.find("input[name='hour_executed']").val($.format.date(now, "HH"));
            this.$el.find("input[name='min_executed']").val($.format.date(now, "mm"));
            this.$el.find("input[name='sec_executed']").val($.format.date(now, "ss"));
        },
        
        // Вызов при иннициализации
        createDialog: function() {
            var options = {
                modal   : true,
                title   : "Закрытие заказа",
                width: 550,
                height: 600,
                buttons: [
                    {
                        text: 'OK',
                        click: $.proxy(this, 'deleteOrder'),
                        id: 'deleteOrder'
                    },
                    {
                        text: 'Отмена',
                        click: function(){ $(this).dialog("close"); }
                    }
                ]
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        getDatetime: function(){
            var date = this.$el.find("input[name='date_executed']").datepicker("getDate");
            var hour = parseInt(this.$el.find("input[name='hour_executed']").val(), 10);
            hour = isNaN(hour) ? "00" : hour;
            date.setHours(hour);
            var min = parseInt(this.$el.find("input[name='min_executed']").val(), 10);
            min = isNaN(min) ? "00" : min;
            date.setMinutes(min);
            var sec = parseInt(this.$el.find("input[name='sec_executed']").val(), 10);
            sec = isNaN(sec) ? "00" : sec;
            date.setSeconds(sec);
            
            return (date.getTime() / 1000);
        },
        
        /*
         * Удаление заказа
         * Обратный вызов из диалога (createDialog)
         */
        deleteOrder: function() {
            this.dialog.showLoader();
            $("#deleteOrder").prop("disabled", true).addClass("ui-state-disabled");
            
            var callsign = $.trim(this.$el.find("input[name='callsign']").val());
            if(callsign === "") {
                this.dialog.removeLoader();
                this.dialog.close({ 
                    title: "Ошибка", 
                    message: "Без позывного заказ не может быть удален"
                });
                return;
            }
            
            var formData = this.$el.serializeArray();
            formData.push({
                name: "datetime",
                value: this.getDatetime()
            });
//            console.log(formData); return;
            $.ajax({
                type: 'POST',
                context: this,
                url: General.getUrl('/order/closeOrder'),
                data: formData,
                success: function(data){
                    var result = (eval('(' + data + ')'));
                    var title, message;
                    if(result.status === "OK"){
                        title = "Успех";
                        message = "Заказ удален";
                    }
                    else {
                        title = "Ошибка";
                        message = "При удалении заказа произошла ошибка. Повторите попытку позже.";
                    }
                    this.dialog.removeLoader();
                    this.dialog.close({ title: title, message: message, reload: true });
                },
                error: function(){
                    General.Logger.log("VOrderDelete/deleteOrder: Ошибка при удалении заказа.");
                }
            });
        }
        
    });
});
