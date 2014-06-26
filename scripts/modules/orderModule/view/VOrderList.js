/* 
 * Представление списка заказов (таблица)
 */
define([
    'jquery', 
    'underscore', 
    'backbone',  
    'general',
    'modules/orderModule/view/VOrderRow',  
    'modules/orderModule/view/routeMap',  
    'templates'
], function($, _, Backbone, General, VOrderRow, Map, templates) {
    "use strict";
    
    return Backbone.View.extend({
        
        routeMap: new Map(),
        
        template        : _.template(templates.orderList),
        
        storageName     : "settingsMainPageOrders",
        visibleRows     : [],
        selectedOrder   : undefined,
        
        events: {
            "click tr"                      :       "setSelectedRow"
        },

        initialize: function(params) {
            this.viewOrders = {};       // Объект для хранения представлений вкладки
            this.parent = params.parent;
            this.collection = params.collection;
            
//            this.listenTo( this.collection, 'reset', this.render );
            this.listenTo( this.collection, 'change', this.render );
            
            this.setElement(this.template());
            this.render();
        },
        
        // Создаем представление для вкладки с заказами
        render: function() {
            if(! _.isEmpty(this.viewOrders) ){
                this.removeOldOrdersView();
            }
            
            this.collection.each(function( model ) {
                if(this.parent.belongsToTab(model.get("status"))){
                    this.viewOrders[model.get("id")] = this.renderOrder( model );
                }
            }, this );
            this.applySettings();
            
            return this;
        },
        
        remove: function() {
            this.undelegateEvents();
            this.stopListening();
            this.$el.remove();
        },
        
        // Удаляем старые представления для заказов
        removeOldOrdersView: function() {
            _.each(this.viewOrders, function(view, key){
                if(view){
                    view.remove();
                    delete this.viewOrders[key];
                }
            }, this );
        },
        
        // Создаем представление для строки заказа
        renderOrder: function(model) {
            var view = new VOrderRow({ parent: this, model: model });
//            console.log(view.$el.attr("data-id"));
            if(model.get("id") === this.selectedOrder){
                view.$el.addClass("selectedRow");
            }
            this.$el.find("tbody").append(view.$el);
            return view;
        },
        
        // Устанавливаем выделение на строке
        setSelectedRow: function(e) {
            this.selectedOrder = $(e.target).closest("tr").attr("data-id");
            this.$el.find("tr").removeClass('selectedRow')
                .filter('[data-id="' + this.selectedOrder + '"]')
                .addClass('selectedRow');
        },
        
        applySettings: function() {
            if(_.isEmpty(this.visibleRows) ){
                var settings = General.storage.get(this.storageName);
                this.visibleRows = settings.visibleFields;
            }
            
            var $rows = this.$el.find("th, td").not(".actions");
            for(var i = 0; i < $rows.length; i++){
                var $elem = $rows.eq(i);
                if(! this.isVisibleElem($elem)){
                    $elem.addClass("hide");
                }
            }
        },
        
        isVisibleElem: function($elem) {
            for(var i = 0; i < this.visibleRows.length; i++){
                if($elem.hasClass(this.visibleRows[i])){
                    return true;
                }
            }
            return false;
        }
        
    });
});

