/* 
 * 
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'templates'
], function($, _, Backbone, templates) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'tr',
        template: _.template(templates.clientRow),
        //
        events: {
            "dblclick td"               :       "showDetail",
            "click td.actions"          :       "showDetail"
        },
        
        initialize: function(params) {
            this.model = params.model;
            
            this.listenTo(this.model, "change", this.render);
            this.render();
        },
        
        render: function() {
            var view = this.template(this.model.toRowOfList());
            this.$el.attr("data-id", this.model.get("id")).html(view);            
            return this;
        },
        
        showDetail: function() {
            console.log("showDetail");
        }
        
    });
});


