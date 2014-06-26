/* 
 * 
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'templates',
    'modules/clientModule/view/VClientRow'
], function($, _, Backbone, templates, VClientRow) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'table',
        className: 'clientList',
        template: _.template(templates.clientList),
        
        events: {
//            "dblclick td"               :       "showDetail",
        },
        
        initialize: function(params) {
            this.collection = params.collection;
            
            this.$el.html(this.template());
            this.$tbody = this.$el.find("tbody").first();
            
            this.listenTo( this.collection, 'load', this.update );
        },
        
        render: function() {
            for(var i = 0; i < this.collection.length; i++){
                this.addRow(this.collection.models[i]);
            }
            return this;
        },
        
        update: function() {            
            this.$tbody.find("tr").remove();
            return this.render();
        },

        addRow: function(model) {
            var row = new VClientRow({model: model});
            this.$tbody.append(row.render().$el);
        }
        
    });
});


