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
        className: 'commonTariffication',
        attributes: { name: "commonTariffication" },
        
        dialog  : null,
        title   : 'Общая тарификация',
        
        initialize: function() {
            
            this.createDialog();
            this.getTariffication();
        },
        
        createDialog: function() {
            var self = this;
            var options = {
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
        
        getTariffication: function(){
            this.dialog.showLoader();
            $.ajax({
		type: 'POST',
		context: this,
		url: General.getUrl('/tariffication/showCommonTariffication'),
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
            
//            this.dialog.showLoader();
//            $.ajax({
//                type: 'POST',
//		context: this,
//		url: General.getUrl('/settings/saveTarif'),
//                data: this.$el.serializeArray(),
//		success: function(data) {
////                    console.log(data);
//                    this.dialog.removeLoader();
//		}
//            });
        }
        
    });
    
});