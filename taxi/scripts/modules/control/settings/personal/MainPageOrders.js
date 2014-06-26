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
        className: 'settingsMainPageOrders group',
        template    : _.template(templates.settingsMainPageOrders),
        
        dialog  : null,
        settings  : {},
        storageName  : "settingsMainPageOrders",
        
        initialize: function() {
            this.settings = General.storage.get(this.storageName);
            this.$el.html(this.template());
            this.createDialog();
            this.setUI();
        },
        
        createDialog: function() {
            var self = this;
            var options = {
                modal: false,
//                width: 500,
                height: 320,
                resizable: false,
                title: 'Настройки отображения заказов на главной странице',
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
        
        setUI: function() {
            var visibleFields = this.settings.visibleFields;
            this.$el.find("label").button().each(function(){
                var $input = $(this).find("input").first();
                $input.prop("disabled", true);
                if(_.contains(visibleFields, $input.attr("name"))){
                    $input.prop("checked", true);
                }
            });
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
                visibleFields: checked
            });
            General.storage.save(this.storageName, this.settings);
            window.location.reload();
        }
        
    });
    
});