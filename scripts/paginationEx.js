/* 
 * Представление вкладки с заказами
 */
define([
    'jquery',
    'underscore',
    'backbone',
    'templates'
], function($, _, Backbone, templates) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName         : 'div',
        className       : 'paginationWrap',        
        template        : _.template(templates.pagination),
        $input          : null,
        
        limit           : 5,
        maxPage         : 1,
        idxCurPage	: 0,
        idxNewPage	: 0,
        pageString      : '',
        
        events: {
            "click a.first"         :       "getFirstPage",
            "click a.previous"      :       "getPreviousPage",
            "click a.next"          :       "getNextPage",
            "click a.last"          :       "getLastPage",
            "keypress input"        :       "keypress",
            "focus input"           :       "focus"
        },

        initialize: function(params) {
            this.collection = params.collection;
            this.limit = this.collection.getLimit();
            
            this.listenTo( this.collection, 'load', this.update );
            
            this.render();
        },
        
        render: function() {
            this.$el.html(this.template());
            this.$input = this.$el.find("input");
            return this;
        },
        
        update: function(count) {            
            this.maxPage = Math.ceil( count / this.limit );
//            console.log("count: " + count + "; limit: " + this.limit + "; maxPage: " + this.maxPage + "; length: " + this.collection.length);
            
            if(this.maxPage <= 1){
                this.$el.hide();
                return;
            }
            else {
                this.$el.show();
            }
            
            this.idxCurPage = this.idxNewPage;
            this.setPageString();
            this.setUI();
        },
        
        scrollHandler: function(e) {
            var target = e.currentTarget;
            this.$el.css({
                "width": $(target).width(),
                "margin-left": target.scrollLeft
            });
        },
        
        focus: function() {
            this.$input.val('');
        },
        
        setPageString: function() {
            this.pageString = "Страница " + (this.idxCurPage + 1) + " из " + this.maxPage;
            this.$input.val(this.pageString);
        },
        
        setUI: function() {
            if(this.idxCurPage === 0){
                this.$el.find("a.first, a.previous").addClass("disabled");
            }
            else if(this.$el.find("a.first").hasClass("disabled")){
                this.$el.find("a.first, a.previous").removeClass("disabled");
            }
            
            if(this.idxCurPage === this.maxPage-1){
                this.$el.find("a.last, a.next").addClass("disabled");
            }
            else if(this.$el.find("a.next").hasClass("disabled")){
                this.$el.find("a.last, a.next").removeClass("disabled");
            }
        },
        
        getPage: function() {
            this.collection.setRequestData({
                limit: this.limit,
                offset: this.idxNewPage * this.limit
            });
            this.collection.getList();
        },
        
        setPage: function(e, idxPage) {
            e.preventDefault();
            if($(e.currentTarget).hasClass("disabled")){
                return;
            }
            
            if(isNaN(idxPage) || idxPage < 0 || idxPage >= this.maxPage){
                return;
            }
            
            this.idxNewPage = idxPage;
            this.getPage(idxPage);
        },
        
        keypress: function(e) {
            if (e.keyCode !== 13)
                return;
            
            var numPage = parseInt(this.$input.val(), 10);            
            this.setPage(e, numPage-1);
            this.$input.blur();
        },
        
        getFirstPage: function(e) {
            this.setPage(e, 0);
        },
        
        getPreviousPage: function(e) {
            this.setPage(e, this.idxCurPage - 1);
        },
        
        getNextPage: function(e) {
            this.setPage(e, this.idxCurPage + 1);
        },
        
        getLastPage: function(e) {
            this.setPage(e, this.maxPage-1);
        }
        
    });
});

