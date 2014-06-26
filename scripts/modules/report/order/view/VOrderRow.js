/* 
 * Представление заказа в таблице (строка)
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'templates',  
    'modules/report/order/view/VOrderDetail'
], function($, _, Backbone, templates, VOrderDetail) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'tr',
        template: _.template(templates.reportOrderRow),
        
        events: {
            "dblclick td"               :       "showDetail",
            "click td.detail"           :       "showDetail"
        },
        
        initialize: function(params) {
            this.model = params.model;
            this.parent = params.parent;
            this.listenTo(this.model, "change", this.render);
            this.render();
        },
        
        remove: function() {
            this.stopListening();
            this.undelegateEvents();
            this.$el.remove();
        },
        
        render: function() {
            var view = this.template(this.model.toRowOfTable());
            this.$el.attr("data-id", this.model.get("id")).html(view);
            var hideRows = this.parent.getHideRows();
            for(var i = 0; i < hideRows.length; i++){
                this.$el.find("." + hideRows[i]).each(function(){
                    $(this).addClass("hide");
                });
            }
            
            return this;
        },
        
        showDetail: function(e) {
//            console.log("showDetail");
//            if (e.keyCode !== 13)
//                return;
            new VOrderDetail({model: this.model});
        }
        
    });
});


