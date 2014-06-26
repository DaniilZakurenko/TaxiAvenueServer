/* 
 * 
 */
define([
    'jqueryui',
    'underscore', 
    'backbone', 
    'general',
    'dialog'
], 
function($, _, Backbone, General, Dialog) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'form',
        className: 'tarifGrid',
        attributes: { name: "tarifGrid" },
        
        dialog  : null,
        type    : '',
        title   : 'Гибкая тарификация :: ',
        
        initialize: function(params) {
            this.type = params.type;
            this.title += params.title;
            
            this.createDialog();
            this.getTarifGrid();
        },
        
        createDialog: function() {
            var self = this;
            var options = {
                modal: false,
                height: 360,
                resizable: false,
                title: self.title,
                buttons: [
                    {
                        text: 'Редактировать',
                        click: $.proxy(self, 'saveTarif')
                    },
                    {
                        text: 'Отмена',
                        click: function(){ $(this).dialog("close"); }
                    }
                ]
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        getTarifGrid: function(){
            this.dialog.showLoader();
            $.ajax({
		type: 'POST',
		context: this,
		url: General.getUrl('/settings/getTarifGrid'),
		data: { type: this.type },
		success: function(data) {
                    this.$el.html(data);
                    this.dialog.removeLoader();
		}
            });
        },
        
        saveTarif: function(e){
            var $button = $(e.currentTarget);
            if($button.text() === "Редактировать"){
                $button.find("span.ui-button-text").text("Сохранить");
                this.$el.find("input").prop("disabled", false);
                return;
            }
            
            this.dialog.showLoader();
            $button.prop("disabled", true).addClass("ui-state-disabled");
            var formData = {};
            formData.data = this.$el.serializeArray();
            formData.type = this.type;
            $.ajax({
                type: 'POST',
		context: this,
		url: General.getUrl('/settings/saveTarif'),
                data: formData,
		success: function(data) {
                    this.dialog.removeLoader();
                    var result = eval('(' + data + ')');
                    console.log(result.response);
                    if(result.response === "OK"){
                        this.dialog.close({
                            message: "Данные успешно изменены"
                        });
                    }
                    else {
                        this.dialog.close({
                            message: "При сохранении данных произошла ошибка."
                        });
                    }
		}
            });
        }
        
    });
    
});