/* 
 * 
 */
define([
    'jqueryui',
    'underscore', 
    'backbone', 
    'dialog',   
    'templates', 
    'modules/control/settings/tariffication/FlexTariffication', 
    'modules/control/settings/tariffication/CommonTariffication', 
    'modules/control/settings/personal/MainPageOrders', 
    'modules/control/settings/personal/ReportModuleOrders'
], 
function($, _, Backbone, Dialog, templates, FlexTarif, CommonTarif, MainPageOrders, ReportModuleOrders) {
    "use strict";
    
    return Backbone.View.extend({
        
        tagName     : 'div',
        className   : 'settingsMod',
        template    : _.template(templates.settingsMod),

        events: {
            "click #tarifficationMod li.cashPaymentTarif"       :       "showСashPaymentTarif",
            "click #tarifficationMod li.nonCashPaymentTarif"    :       "showNonCashPaymentTarif",
            "click #tarifficationMod li.paymentOrders"          :       "showPaymentOrders",
            "click #tarifficationMod li.commonTarif"            :       "showCommonTariffication",
            "click #personal li.mainPageOrders"                 :       "showMainPageOrders",
            "click #personal li.reportModuleOrders"             :       "showReportModuleOrders"
        },
        
        dialog      : null,
        
        initialize: function() {
            this.$el.html(this.template());
            this.createDialog();
            this.setUI();
        },
        
        setUI: function() {
            this.$el.tabs({
                heightStyle: "auto"
//                active: 1
//                collapsible: true
            });
        },
        
        showСashPaymentTarif: function() {
            new FlexTarif({
                type: 'cash_payment_tarif',
                title: 'наличный расчёт'
            });
        },
        
        showNonCashPaymentTarif: function() {
            new FlexTarif({
                type: 'non_cash_payment_tarif',
                title: 'безналичный расчёт'
            });
        },
        
        showPaymentOrders: function() {
            console.log("showPaymentOrders");
//            this.dialog.close();
        },
        
        showCommonTariffication: function() {
            new CommonTarif();
        },
        
        showReportModuleOrders: function() {
            new ReportModuleOrders();
        },
        
        showMainPageOrders: function() {
            new MainPageOrders();
//            this.dialog.close();
        },
        
        createDialog: function() {
            var self = this;
            var options = {
                width: 600,
                height: 400,
                position: 'center top',
                resizable: false,
                title: 'Настройки',
                close   : function(){ 
                    self.close();
                    self.remove(); 
                    $(this).dialog('destroy');
                },
                buttons : null
            };
            this.dialog = new Dialog({widget: this, options: options});
        }
        
//        close: function(){
//            this.driverList.close();
//            this.controlPannelView.remove();
//            this.driverListView.remove();
//            this.paginationView.remove();
//        }
        
    });
    
});