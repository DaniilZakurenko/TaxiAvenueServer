/* 
 * Представление водителя в списке (строка)
 */ 
define([ 
    'jqueryui', 
    'underscore', 
    'backbone', 
    'general', 
    'modules/driverModule/view/VDriverDetail', 
    'templates'
], function($, _, Backbone, General, VDriverDetail, templates){
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'div',
        className: 'driverInfo',
        
        template: _.template(templates.driverRow),
        
        events: {
            "click .driverDetail"       :       "showDriverDetailInfo",
            "click .editDriver"         :       "showDraverForm"
        },

        initialize: function() {
            this.listenTo(this.model, "change", this.render);
        },
        
        render: function() {
            var view = this.template(this.model.toRowOfList());
            this.$el.html(view).attr("data-id-driver", this.model.get("driver_id"))
                .removeClass("green yellow gray red blue").addClass(General.StatusToColor[this.model.get("taxi_status")]);
        
            return this;
        },
        
        // 
        showDraverForm: function(){
            var detailForm = new VDriverDetail({
                model: this.model
            });
            detailForm.render();
        },
        
        // 
        showDriverDetailInfo: function(){
            var $target = this.$el.find("span.driverDetail"),
                $detailDriverInfo = this.$el.find("div.detailDriverInfo");
            if($target.hasClass("view")){
                $detailDriverInfo.hide(500);
                $target.removeClass("view");
            }
            else {
                $detailDriverInfo.show(500);
                $target.addClass("view");
            }
        }
    });
});
