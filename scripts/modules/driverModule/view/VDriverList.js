/* 
 * 
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'modules/driverModule/view/VDriverRow',   
    'templates'
], function($, _, Backbone, VDriverRow, templates){
    "use strict";
    
    return Backbone.View.extend({
        
        tagName     : 'div',
        className   : 'list',
        template    : _.template(templates.driverList),
        
        $caption    : null,

        events: {
            "click div.namesOfFields > span"        :       "sort"
        },
        
        initialize: function(params) {
            this.collection = params.collection;
            
            this.$el.html(this.template());
            this.$caption = this.$el.find("div.namesOfFields").first();
            
            this.$caption.attr("data-sort-dir", "DESC");
            this.$caption.attr("data-sort-field", "callsign");
            
            // Устанавливаем слушателей
            this.listenTo( this.collection, 'load', this.update );
        },
        
        render: function() {
            for(var i = 0; i < this.collection.length; i++){
                this.addDraver(this.collection.models[i]);
            }
            return this;
        },
        
        update: function() {            
            this.$el.find("div.driverInfo").remove();
            return this.render();
        },

        addDraver: function(model) {
            var row = new VDriverRow({model: model});
            this.$el.append(row.render().$el);
        },
        
        sort: function(e) {
            var fieldName = e.currentTarget.className,
                sortField = this.$caption.attr("data-sort-field"),
                sortDir = this.$caption.attr("data-sort-dir");
            
            if(sortDir === "ASC" && fieldName === sortField){
                sortDir = "DESC";
            }
            else {
                sortDir = "ASC";
            }
            
            this.$caption.attr("data-sort-dir", sortDir);
            this.$caption.attr("data-sort-field", fieldName);
            
            switch(fieldName){
                case "driverCallsign":
                    this.collection.sortBy("callsign", sortDir);
                    break;
                case "driverSurname":
                    this.collection.sortBy("surname", sortDir);
                    break;
                case "driverName":
                    this.collection.sortBy("name", sortDir);
                    break;
                case "driverPatronymic":
                    this.collection.sortBy("patronymic", sortDir);
                    break;
                case "carNumber":
                    this.collection.sortBy("car_number", sortDir);
                    break;
                case "carModel":
                    this.collection.sortBy("car_model", sortDir);
                    break;
                case "carType":
                    this.collection.sortBy("car_type", sortDir);
                    break;
                case "carColor":
                case "carNotes":
                    break;
            }
        }
    });
});

