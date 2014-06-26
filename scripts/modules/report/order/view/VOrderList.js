/* 
 * Представление списка заказов (таблица)
 * clientPhone
 * cost
 * length
 */
define([
    'jquery', 
    'underscore', 
    'backbone',
    'general',
    'dialog', 
    'pagination',
    'modules/report/order/collections/OrderList',
    'modules/report/order/view/VOrderRow',
    'templates'
], function($, _, Backbone, General, Dialog, VPagination, OrderList, VOrderRow, templates) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName             : 'div',
        className           : 'orderReport',
        
        $table              : null,
        $tbody              : null,
        $sortRow            : null,
        $controlPannel      : null,
        $controlButtons     : null,
        $settings           : null,
        $filters            : null,
        $countOfRecords     : null,
        $selectNotes        : null,
        
        paginationView      : null,
        
        template            : _.template(templates.reportOrder),
        
        sortDir             : null,
        sortField           : null,
        selectedOrder       : undefined,
        
        hideRows            : [],
        visibleRows         : [],
        
        storageName         : "settingsReportOrders",
        filters             : {
            _filters: {},
            setStatus: function(status){
                this._filters['status'] = [status];
            },
            clearStatus: function(){
                if(this._filters['status']){
                    delete this._filters['status'];
                }
            },
            setFilterNotes: function(filterName, note){
                if(filterName === 'filterByDriverNote'){
                    this._filters['driverNote'] = note;
                }
                else if(filterName === 'filterByDispatcherNote'){
                    this._filters['dispatcherNote'] = note;
                }
            },
            clearFilterNotes: function(filterName){
                if(filterName === 'filterByDriverNote' && this._filters['driverNote']){
                    delete this._filters['driverNote'];
                }
                else if(filterName === 'filterByDispatcherNote' && this._filters['dispatcherNote']){
                    delete this._filters['dispatcherNote'];
                }
            },
            setLength: function(length){
                this._filters['length'] = length;
            },
            clearLength: function(){
                if(this._filters['length']){
                    delete this._filters['length'];
                }
            },
            setСost: function(cost){
                this._filters['cost'] = cost;
            },
            clearСost: function(){
                if(this._filters['cost']){
                    delete this._filters['cost'];
                }
            },
            setСlientPhone: function(clientPhone){
                this._filters['clientPhone'] = clientPhone;
            },
            clearСlientPhone: function(){
                if(this._filters['clientPhone']){
                    delete this._filters['clientPhone'];
                }
            },
            setDispatcherId: function(dispatcherId){
                this._filters['dispatcherId'] = dispatcherId;
            },
            clearDispatcherId: function(){
                if(this._filters['dispatcherId']){
                    delete this._filters['dispatcherId'];
                }
            },
            setCallsign: function(callsign){
                this._filters['callsign'] = callsign;
            },
            clearCallsign: function(){
                if(this._filters['callsign']){
                    delete this._filters['callsign'];
                }
            },
            setTarif: function(tarifId){
                this._filters['tarif_id'] = [tarifId];
            },
            clearTarif: function(){
                if(this._filters['tarif_id']){
                    delete this._filters['tarif_id'];
                }
            },
            setDatetime: function(dateDatetime){
                this.clearDatetime();
                $.extend(this._filters, dateDatetime);
            },
            clearDatetime: function(){
                if(this._filters['createDatetime']){
                    delete this._filters['createDatetime'];
                }
                if(this._filters['arriveDatetime']){
                    delete this._filters['arriveDatetime'];
                }
                if(this._filters['finishDatetime']){
                    delete this._filters['finishDatetime'];
                }
            },
            setPoint: function(point){
//                this.clearPoint();
                $.extend(this._filters, point);
            },
            clearPoint: function(pointName){
                if(this._filters[pointName]){
                    delete this._filters[pointName];
                }
            },
            clearAll: function(){
                for(var prop in this._filters){
                    delete this._filters[prop];
                }
            },
            getAll: function(){
                return this._filters;
            }
        },
        
        countOfRecords      : 0,
        
        StatusTypes: [
            {id: '6',   name: 'Заказ доступен'},
            {id: '7',   name: 'Заказ взят'},
            {id: '8',   name: 'Заказ выполняется'},
            {id: '9',   name: 'Заказ выполнен'},
            {id: '10',  name: 'Заказ удалён'},
            {id: '12',  name: 'Пассажир не вышел'},
            {id: '17',  name: 'Заказ закрыт (не выполнен)'},
            {id: '18',  name: 'Заказ закрыт (нет машины)'},
            {id: '22',  name: 'Заказ закрыт (Не завершён по уважительной причине)'},
            {id: '24',  name: 'Заказ закрыт (отказ клиента)'},
            {id: '25',  name: 'Заказ удалён (ошибочно созданный)'}
        ],
        
        events: {
            // Сортировка
            "click tr.sortRow th.orderId"                   :       "sortBy",
            "click tr.sortRow th.status"                    :       "sortBy",
            "click tr.sortRow th.callsign"                  :       "sortBy",
            "click tr.sortRow th.firstPoint"                :       "sortBy",
            "click tr.sortRow th.lastPoint"                 :       "sortBy",
            "click tr.sortRow th.clientPhone"               :       "sortBy",
            "click tr.sortRow th.cost"                      :       "sortBy",
            "click tr.sortRow th.arriveDatetime"            :       "sortBy",
            "click tr.sortRow th.length"                    :       "sortBy",
            "click tr.sortRow th.createDatetime"            :       "sortBy",
            "click tr.sortRow th.dispatcherId"              :       "sortBy",
            "click tr.sortRow th.tarifId"                   :       "sortBy",
            "click tr.sortRow th.clientPaymentType"         :       "sortBy",
            "click tr.sortRow th.additionalCard"            :       "sortBy",
            "click tr.sortRow th.downTimes"                 :       "sortBy",
            "click tr.sortRow th.downTimeCost"              :       "sortBy",
            "click tr.sortRow th.driverNote"                :       "sortBy",
            "click tr.sortRow th.dispatcherNote"            :       "sortBy",
            "click tr.sortRow th.discount"                  :       "sortBy",
            "click tr.sortRow th.paymentType"               :       "sortBy",
            "click tr.sortRow th.travelNumber"              :       "sortBy",
            "click tr.sortRow th.taxiFrom"                  :       "sortBy",
            "click tr.sortRow th.taxiFromTitle"             :       "sortBy",
            "click tr.sortRow th.taxiTo"                    :       "sortBy",
            "click tr.sortRow th.taxiToTitle"               :       "sortBy",
            "click tr.sortRow th.statusTransfer"            :       "sortBy",
            
            // Выделение строки
            "click tbody tr"                                :       "setSelectedRow",
            
            // Открытие-закрытие блоков "Настройки", "Фильтры"
            "click div.control.buttons button.settings"     :       "visibilityBlock",
            "click div.control.buttons button.filters"      :       "visibilityBlock",
            
            // Сохранение в Excel
            "click div.control.buttons button.excel"        :       "saveAsExcel",
            
            // Настройка таблицы (видимость столбцов)
            "click div.controlPannel div.settings input"    :       "visibilityColumn",
            
            // Фильтры
            "click div.filters button.apply"                :       "applyFilterDatetimes",
            "click div.filters button.clear"                :       "clearFilterDatetimes",
            "keyup input[name='hour_from']"                 :       "checkHour",
            "keyup input[name='hour_to']"                   :       "checkHour",
            "keyup input[name='min_from']"                  :       "checkMinSec",
            "keyup input[name='sec_from']"                  :       "checkMinSec",
            "keyup input[name='min_to']"                    :       "checkMinSec",
            "keyup input[name='sec_to']"                    :       "checkMinSec",
            "change select[name='filterByStatus']"          :       "applyFilterStatus",
            "change select[name='filterByTarif']"           :       "applyFilterTarif",
            "keyup input[name='filterByFirstPoint']"        :       "applyFilterPoint",
            "keyup input[name='filterByLastPoint']"         :       "applyFilterPoint",
            "keyup input[name='filterByCallsign']"          :       "applyFilterCallsign",
            "keyup input[name='filterByСlientPhone']"       :       "applyFilterСlientPhone",
            "keyup input[name='filterByСost']"              :       "applyFilterСost",
            "keyup input[name='filterByLength']"            :       "applyFilterLength",
            "keyup input[name='filterByDispatcherId']"      :       "applyFilterDispatcherId",
            
            "click input[name='filterByDriverNote']"        :       "setFilterDriverNote",
            "keypress input[name='filterByDriverNote']"     :       "preventDefault",
            "click input[name='filterByDispatcherNote']"    :       "setFilterDispatcherNote",
            "keypress input[name='filterByDispatcherNote']" :       "preventDefault",
            "click select#notes option"                     :       "applyFilterNote",
            
            // Количество строк в таблице
            "change input[name='countOfRecords']"            :       "setCountOfRecords"
        },

        initialize: function() {
            this.getSettings();
            
            // Генерируем вьюшку
            this.$el.html( this.template(this.getTemplateAttr()) );
            
            // Устанавливаем вспомогательные поля
            this.$table = this.$el.find("table").first();
            this.$tbody = this.$table.find("tbody").first();
            this.$sortRow = this.$table.find("thead tr.sortRow").first();
            this.$controlPannel = this.$el.find("div.controlPannel").first();
            this.$controlButtons = this.$controlPannel.find("div.control.buttons").first();
            this.$settings = this.$el.find("div.controlPannel div.settings").first();
            
            // Применяем сохраненные настройки
            this.setVisibilityColumns(this.visibleRows);
            
            this.$filters = this.$el.find("div.controlPannel div.filters").first();
            this.$countOfRecords = this.$el.find("input[name='countOfRecords']").first();
            
            // Иннициируем коллекцию
            this.collection = new OrderList();
            
            // Иннициируем модуль пагинации
            this.paginationView = new VPagination({collection: this.collection, limit: this.countOfRecords});
            this.$el.append(this.paginationView.$el);
            
            // Устанавливаем слушателей
            this.listenTo( this.collection, 'load', this.render );
            this.$el.on("scroll", $.proxy(this.paginationView, "scrollHandler"));
            this.collection.listenTo( this, 'filter', this.collection.getFilteredList );
            this.collection.listenTo( this.paginationView, 'paged', this.collection.getList );
            
            // Создаем диалоговое окно, которое содержит эту вьюшку
            this.createDialog();
            
            // Создаем элементы UI
            this.setUI();
            
            // Генерируем список
            this.render();
        },
        
        preventDefault: function(e) {
            e.preventDefault();
        },
        
        setFilterDispatcherNote: function() {
            var self = this;
            $.ajax({
                type: 'post',
                url: General.getUrl('/order/getOrderDispNoteList'),
                error: function(){
                    General.Logger.log("modules/report/order/view/VOrderList/setFilterDispatcherNote: не удалось получить данные.");
                },
                success: function(data){
                    var list = eval('(' + data + ')');
                    if(Array.isArray(list)){
                        self.showNotes({
                            list: list, 
                            target: 'filterByDispatcherNote'
                        });
                    }
                }
            });
        },
        
        setFilterDriverNote: function() {
            var self = this;
            $.ajax({
                type: 'post',
                url: General.getUrl('/order/getOrderDriverNoteList'),
                error: function(){
                    General.Logger.log("modules/report/order/view/VOrderList/setFilterDriverNote: не удалось получить данные.");
                },
                success: function(data){
                    var list = eval('(' + data + ')');
                    if(Array.isArray(list)){
                        self.showNotes({
                            list: list, 
                            target: 'filterByDriverNote'
                        });
                    }
                }
            });
        },
        
        showNotes: function(data){
            var tbodyPosition = this.$tbody.position(), 
                width = this.$tbody.width(), 
                list = data.list,
                size = list.length;
            
            this.$selectNotes = $("select#notes");
            if(this.$selectNotes.length === 0){
                this.$selectNotes = $("<select></select>").attr({
                    id: "notes",
                    size: (size + 1 < this.countOfRecords) ? size + 1 : 10
                }).css({
                    width: width,
                    position: "absolute",
                    top: tbodyPosition.top,
                    left: tbodyPosition.left,
//                    overflow: "auto",
                    'background-color': 'rgba(255, 255, 255, 0.9)'
                }).appendTo(this.$el);
            }
            else {
                this.$selectNotes.html("");
            }
            
            this.$selectNotes.attr("data-filter-target", data.target).append($("<option></option>"));
            for(var i = 0; i < size; i++){
                $("<option></option>").val(list[i].order_id).text(list[i].note).appendTo(this.$selectNotes);
            }
        },
        
        applyFilterNote: function(e) {
            var $option = $(e.currentTarget), 
                note = $.trim($option.text()), 
                target = this.$selectNotes.attr("data-filter-target");
            
            if(note){
                this.filters.setFilterNotes(target, note);
            }
            else {
                this.filters.clearFilterNotes(target);
            }
            
            this.$table.find("input[name='" + target + "']").val(note);
            this.$selectNotes.remove();
            this.applyFilters();
        },
        
        setCountOfRecords: function() {
            var count = parseInt(this.$countOfRecords.val(), 10);            
            if(isNaN(count)){
                this.$countOfRecords.val(this.countOfRecords);
                return;
            }
            else if (count < 1){
                count = 1;
                this.$countOfRecords.val(count);
            }
            
            this.countOfRecords = count;
            this.saveSettings();
            this.paginationView.setCountOfRecords(count);
            this.collection.getList({
                limit: this.countOfRecords,
                sortField: this.sortField,
                sortDir: this.sortDir,
                offset: 0
            }, true);
        },
        
        getSettings: function() {
            var settings = General.storage.get(this.storageName);
            this.visibleRows = settings.visibleFields;
            this.countOfRecords = settings.countOfRecords;
        },
        
        saveSettings: function() {
            General.storage.save(this.storageName, {
                countOfRecords: this.countOfRecords,
                visibleFields: this.visibleRows
            });
        },
        
        setVisibilityColumns: function(visibleRows) {
            var rows = this.hideRows = [];
            this.$settings.find("input").each(function(){
                var name = $(this).attr("name");
                if(_.contains(visibleRows, name)){
                    $(this).attr("checked", "checked");
                }
                else {
                    rows.push(name);
                }
            });
        },
        
        // Вызов в функции render
        createDialog: function() {
            var options = {
                title: "Отчёт по заказам",
                buttons : { "Ok": function(){ $(this).dialog("close"); } }
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        render: function() {
            this.$tbody.find("tr").remove();
            for(var i = 0; i < this.collection.length; i++){
                this.addOrder(this.collection.models[i]);
            }
            this.hideSelectedRows();
            
            return this;
        },
        
        remove: function() {
            this.stopListening();
            this.filters.clearAll();
            this.undelegateEvents();
            this.$el.remove();
        },
        
        // Создаем представление для строки заказа
        addOrder: function(model) {
            var view = new VOrderRow({ parent: this, model: model });
            
            if(model.get("id") === this.selectedOrder){
                view.$el.addClass("selectedRow");
            }
            this.$tbody.append(view.$el);
        },
        
        // 
        getHideRows: function() {
            return this.hideRows;
        },
        
        // Скрываем выбранные столбцы
        hideSelectedRows: function() {
            for(var i = 0; i < this.hideRows.length; i++){
                this.$table.find("." + this.hideRows[i]).each(function(){
                    $(this).addClass("hide");
                });
            }
        },
        
        setUI: function() {
            this.$controlButtons.find("button").not(".excel").button({
                icons: { primary: "ui-icon-circle-plus" }
            });
            this.$controlButtons.find("button.excel").button();
            this.$settings.find("label").button();
            
            this.$filters.find("input[name='date_from'], input[name='date_to']").datepicker({ 
                dateFormat: "dd-mm-yy", changeMonth: true, changeYear: true 
            });
            this.$filters.find("div.buttons button").button();
        },

        getTemplateAttr: function() {
            return {
                countOfRecords: this.countOfRecords,
                StatusTypes: this.StatusTypes,
                CarTypes: General.CarTypes
            };
        },
        
        applyFilters: function(){
            this.trigger("filter", {
                filter: this.filters.getAll()
            });
        },
        
        /*####################### Обработчики ################################*/

        sortBy: function(e) {
            var field = $(e.currentTarget).attr("class");
            var dir = this.$sortRow.attr("data-sort-dir");
            
            if(this.sortField !== field){
                this.sortDir = "DESC";
            }
            else if(dir === "ASC") {
                this.sortDir = "DESC";
            }
            else {
                this.sortDir = "ASC";
            }
            
            this.sortField = field;
            this.$sortRow.attr("data-sort-dir", this.sortDir);
            
            var sortFunc = this.collection.sortBy(this.sortDir);
            sortFunc[this.sortField]();
            this.collection.getList({
                limit: this.countOfRecords,
                sortField: this.sortField,
                sortDir: this.sortDir,
                offset: 0
            }, true);
        },
        
        // Устанавливаем выделение на строке
        setSelectedRow: function(e) {
            this.selectedOrder = $(e.currentTarget).attr("data-id");
            this.$tbody.find("tr").removeClass('selectedRow')
                .filter('[data-id="' + this.selectedOrder + '"]')
                .addClass('selectedRow');
        },
        
        // Устанавливаем видимость блока в контрольной панели
        visibilityBlock: function(e) {
            var $button = $(e.currentTarget);
            var targetBlockName = $button.attr("data-target");
            this.$controlButtons.find("button")
                    .not("." + targetBlockName + ", .excel")
                    .button("option", "icons", {primary: "ui-icon-circle-plus"});
            
            this.$controlPannel.children("div").not(".buttons, ." + targetBlockName).addClass("hide").hide(300);
            var $targetBlock = this.$controlPannel.children("." + targetBlockName).first();
            if($targetBlock.hasClass("hide")){
                $targetBlock.show(500).removeClass("hide");
                $button.button( "option", "icons", { primary: "ui-icon-circle-minus" } );
            }
            else {
                $targetBlock.hide(500).addClass("hide");
                $button.button( "option", "icons", { primary: "ui-icon-circle-plus" } );
            }
        },
        
        // Устанавливаем видимость столбцов 
        visibilityColumn: function(e) {
            var colName = $(e.currentTarget).attr("name");
            if($(e.currentTarget).prop("checked")){
                this.$table.find("." + colName).removeClass("hide");
                this.hideRows = _.without(this.hideRows, colName);
                this.visibleRows.push(colName);
            }
            else {
                this.$table.find("." + colName).addClass("hide");
                this.visibleRows = _.without(this.visibleRows, colName);
                this.hideRows.push(colName);
            }
            this.saveSettings();
        },
        
        applyFilterDatetimes: function() {
            var datetime = this.getDatetimeFields();
            if(datetime){
                this.filters.setDatetime(datetime);
                this.applyFilters();
            }
        },
        
        clearFilterDatetimes: function() {
            var input = "input[name='date_from'], input[name='date_to']";
            this.$filters.find(input).val('');
            input = "input[name='hour_from'], input[name='min_from'], input[name='sec_from'], ";
            input += "input[name='hour_to'], input[name='min_to'], input[name='sec_to']";
            this.$filters.find(input).val('0');
            this.$filters.find("select option").prop('selected', false);
            
            this.filters.clearDatetime();
            this.applyFilters();
        },
        
        getDatetimeFields: function() {
            var date = {};
            var dateFieldName = this.$filters.find("select[name='selectTime'] option:selected").val();
            date[dateFieldName] = {};
            
            var dateFrom = this.$filters.find("input[name='date_from']").val();
            var dateTo = this.$filters.find("input[name='date_to']").val();
            if(!dateFrom || !dateTo){
                return false;
            }
            
            var dateFromArr = dateFrom.split("-"), 
                year = parseInt(dateFromArr[2], 10), 
                month = parseInt(dateFromArr[1], 10)-1, 
                day = parseInt(dateFromArr[0], 10), 
                hour = parseInt(this.$filters.find("input[name='hour_from']").val(), 10) || 0, 
                min = parseInt(this.$filters.find("input[name='min_from']").val(), 10) || 0, 
                sec = parseInt(this.$filters.find("input[name='sec_from']").val(), 10) || 0;
            dateFrom = this.getTimeFromField(year, month, day, hour, min, sec);
            
            var dateToArr = dateTo.split("-");
            year = parseInt(dateToArr[2], 10);
            month = parseInt(dateToArr[1], 10)-1;
            day = parseInt(dateToArr[0], 10);
            hour = parseInt(this.$filters.find("input[name='hour_to']").val(), 10) || 0;
            min = parseInt(this.$filters.find("input[name='min_to']").val(), 10) || 0;
            sec = parseInt(this.$filters.find("input[name='sec_to']").val(), 10) || 0;
            dateTo = this.getTimeFromField(year, month, day, hour, min, sec);
            
            date[dateFieldName]['from'] = dateFrom;
            date[dateFieldName]['to'] = dateTo;
            
            return date;
        },
        
        getTimeFromField: function(year, month, day, hour, min, sec) {
            var date = new Date();
            date.setYear(year);
            date.setMonth(month);
            date.setDate(day);
            date.setHours(hour);
            date.setMinutes(min);
            date.setSeconds(sec);
            return date.getTime() / 1000;
        },
        
        applyFilterStatus: function() {
            var status = this.$table.find("select[name='filterByStatus'] option:selected").val();
            if(status){
                this.filters.setStatus(status);
            }
            else {
                this.filters.clearStatus();
            }
            this.applyFilters();
        },
        
        applyFilterTarif: function() {
            var tarifId = this.$table.find("select[name='filterByTarif'] option:selected").val();
            if(tarifId){
                this.filters.setTarif(tarifId);
            }
            else {
                this.filters.clearTarif();
            }
            this.applyFilters();
        },
        
        applyFilterPoint: function(e) {
            var $point = $(e.currentTarget), 
                name = $point.closest("th").attr("class"), 
                val = $.trim($point.val());
            
            if(val !== ""){
                var requestData = {};
                requestData[name] = val;
                this.filters.setPoint(requestData);
            }
            else {
                this.filters.clearPoint(name);
            }
            this.applyFilters();
            
        },
        
        applyFilterCallsign: function() {
            var callsign = parseInt(this.$table.find("input[name='filterByCallsign']").val(), 10);
            if(callsign){
                this.filters.setCallsign(callsign);
            }
            else {
                this.filters.clearCallsign();
            }
            this.applyFilters();
        },
        
        applyFilterDispatcherId: function() {
            var id = parseInt(this.$table.find("input[name='filterByDispatcherId']").val(), 10);
            if(!isNaN(id)){
                this.filters.setDispatcherId(id);
            }
            else {
                this.filters.clearDispatcherId();
            }
            this.applyFilters();
        },
        
        applyFilterLength: function() {
            var $filterLength = this.$table.find("input[name='filterByLength']"),
                length = parseInt($filterLength.val(), 10);
            if(!isNaN(length)){
                $filterLength.val(length);
                this.filters.setLength(length);
            }
            else {
                this.filters.clearLength();
            }
            this.applyFilters();
        },
        
        applyFilterСost: function() {
            var $filterByСost = this.$table.find("input[name='filterByСost']"),
                cost = parseInt($filterByСost.val(), 10);         
            if(!isNaN(cost)){
                $filterByСost.val(cost);
                this.filters.setСost(cost);
            }
            else {
                this.filters.clearСost();
            }
            this.applyFilters();
        },
        
        applyFilterСlientPhone: function() {
            var $filterByСlientPhone = this.$table.find("input[name='filterByСlientPhone']"),
                clientPhone = $.trim($filterByСlientPhone.val());
            
            if(clientPhone){
                this.filters.setСlientPhone(clientPhone);
            }
            else {
                this.filters.clearСlientPhone();
            }
            this.applyFilters();
        },
        
        checkHour: function(e) {
            var $field = $(e.currentTarget), val = parseInt($field.val(), 10);
            if(val < 0 || isNaN(val)){
                $field.val("0");
            }
            if(val > 23){
                $field.val("23");
            }
        },
        
        checkMinSec: function(e) {
            var $field = $(e.currentTarget), val = parseInt($field.val(), 10);
            if(val < 0 || isNaN(val)){
                $field.val("0");
            }
            if(val > 59){
                $field.val("59");
            }
        },
        
        // Сохранение отчета в Excel
        saveAsExcel: function() {
            var rows = [];
            this.$settings.find("input").each(function(){
                if($(this).prop("checked")){
                    rows.push($(this).attr("name"));
                }
            });
            this.collection.saveAsExcel({fields: rows});
        }
        
    });
});

