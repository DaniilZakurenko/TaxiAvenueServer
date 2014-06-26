/* 
 * 
 */
define([
    'jqueryui',
    'underscore', 
    'backbone', 
    'general', 
    'dialog',
    'templates'
], 
function($, _, Backbone, General, Dialog, templates) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'div',
        className: 'settingsReportOrders group',
        template    : _.template(templates.settingsReportOrders),
        
        dialog  : null,
        settings  : {},
        storageName  : "settingsReportOrders",
        
        initialize: function() {
            this.settings = General.storage.get(this.storageName);
            this.$el.html(this.template());
            this.createDialog();
            this.setData();
            this.$el.find("div").not("[class='countOfRecords']").find("label").button();
        },
        
        createDialog: function() {
            var self = this;
            var options = {
                modal: false,
//                width: 500,
                height: 480,
                resizable: false,
                title: 'Настройки отображения заказов в отчете',
                buttons: [
                    {
                        text: 'Редактировать',
                        click: $.proxy(self, 'save')
                    },
                    {
                        text: 'Закрыть',
                        click: function(){ $(this).dialog("close"); }
                    }
                ]
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        setData: function() {
            var visibleFields = this.settings.visibleFields, 
                countOfRecords = this.settings.countOfRecords;
            this.$el.find("input").each(function(){
                var $input = $(this);
                $input.prop("disabled", true);
                if(_.contains(visibleFields, $input.attr("name"))){
                    $input.attr("checked", "checked");
                }
                if($input.attr("name") === "countOfRecords"){
                    $input.val(countOfRecords);
                }
            });
        },
        
        remove: function() {
            delete this.settings;
            this.stopListening();
            this.undelegateEvents();
            this.$el.remove();
        },
        
        save: function(e){
            var $button = $(e.currentTarget);
            if($button.text() === "Редактировать"){
                $button.find("span.ui-button-text").text("Сохранить");
                this.$el.find("input").prop("disabled", false);
                return;
            }
            
            var checked = [];
            this.$el.find("input").each(function(){
                if($(this).prop("checked")){
                    checked.push($(this).attr("name"));
                }
                $(this).prop("disabled", true);
            });
            $.extend(this.settings, {
                visibleFields: checked,
                countOfRecords: this.$el.find("input[name='countOfRecords']").val()
            });
            console.log(this.settings);
            General.storage.save(this.storageName, this.settings);
            $button.find("span.ui-button-text").text("Редактировать");
        }
        
    });
    
});