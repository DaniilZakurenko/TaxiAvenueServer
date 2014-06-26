/* 
 * Представление заказа в таблице (строка)
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'general',  
    'templates',  
    'modules/orderModule/view/VOrderDetail',  
    'modules/orderModule/view/VOrderDelete'
], function($, _, Backbone, General, templates, VOrderDetail, VOrderDelete) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'tr',
        
        template: _.template(templates.orderRow),
        
        events: {
            "click img.edit"                :       "editOrder",
            "click img.view"                :       "showRoute",
            "click img.perform"             :       "performOrder",
            "click img.delete"              :       "deleteOrder"
        },
        
        initialize: function(params) {
            this.model = params.model;
            this.parent = params.parent;
            this.listenTo(this.model, "change", this.render);
            this.render();
        },
        
        render: function() {
            var view = this.template(this.model.toRowOfTable());
            this.$el.attr("data-id", this.model.get("id")).html(view);
            return this;
        },
        
        editOrder: function() {
            new VOrderDetail({model: this.model});
        },
        
        performOrder: function() {
            console.log("performOrder");
        },
        
        deleteOrder: function() {
            new VOrderDelete({model: this.model});
        },
        
        showRoute: function() {
            var map = this.parent.routeMap;
            map.showRoute(this.model.get("route").get("points"));
        }
        
    });
});


