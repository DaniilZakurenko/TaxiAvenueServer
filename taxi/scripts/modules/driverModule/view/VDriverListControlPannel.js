/* 
 * 
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'general',  
    'templates', 
    'modules/driverModule/models/Driver', 
    'modules/driverModule/view/VDriverDetail'
], function($, _, Backbone, General, templates, Driver, VDriverDetail){
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'div',
        className: 'controlPannel group',
        
        template : function() {
            return _.template(templates.driverListControlPannel, {
                getUrl: General.getUrl,
                StatusTypes: [      // Статусы водителей
                    {id: '1',  name: 'Водитель свободен'},           // green        +
                    {id: '2',  name: 'Взял заказ'},                  // yellow       +
                    {id: '3',  name: 'Выполняет заказ'},             // yellow       +
                    {id: '4',  name: 'Водитель занят'},              // yellow       +
                    {id: '5',  name: 'Водитель не в сети'},          // ---          -
                    {id: '19', name: 'Водитель заблокирован'},      // gray         -
                    {id: '20', name: 'Водитель удалён'},            // gray         -
                    {id: '21', name: 'Байкал'},                     // red          +
                    {id: '23', name: 'Водитель недоступен'}
                ]
            });
        },

        events: {
            "click .addNewDraver"                       :       "showDraverForm",
            "change select[name='filterByStatus']"      :       "filterByStatus",
            "change input[name='driverSearchCallsign']" :       "searchByCallsign"
        },
        
        initialize: function(params) {
            this.collection = params.collection;            
            this.render();
        },
        
        render: function() {
            this.$el.html(this.template());
            this.setUI();
            return this;
        },
        
        setUI: function() {
            this.$el.find("button").button();
        },
        
        searchByCallsign: function(e) {
            var callsign = $.trim($(e.currentTarget).val());
            callsign = parseInt(callsign, 10);
            if(callsign){
                this.collection.addFilter("driver_callsign", callsign);
            }
            else {
                this.collection.removeFilter("driver_callsign");
            }
            
            this.collection.getList();
        },

        filterByStatus: function(e) {
            var statusId = $(e.currentTarget).val();
            if(statusId){
                this.collection.addFilter("taxi_status", statusId);
            }
            else {
                this.collection.removeFilter("taxi_status");
            }
            
            this.collection.getList();
        },
        
        // 
        showDraverForm: function(){
            var view = new VDriverDetail({
                model: new Driver({})
            });
            view.render();
        }
    });
});

