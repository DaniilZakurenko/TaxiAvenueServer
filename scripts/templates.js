/*
 * 
 */
define(function (require) {
    'use strict';

    return {
        clientList                      : require('text!templates/clientList.html'),
        clientRow                       : require('text!templates/clientRow.html'),
        driverDetail                    : require('text!templates/driverDetail.html'),
        driverList                      : require('text!templates/driverList.html'),
        driverListControlPannel         : require('text!templates/driverListControlPannel.html'),
        driverRow                       : require('text!templates/driverRow.html'),
        orderDetail                     : require('text!templates/orderDetail.html'),
        orderDelete                     : require('text!templates/orderDelete.html'),
        orderList                       : require('text!templates/orderList.html'),
        orderRow                        : require('text!templates/orderRow.html'),
        reportOrder                     : require('text!templates/reportOrder.html'),
        reportOrderControlPannel        : require('text!templates/reportOrderControlPannel.html'),
        reportOrderDetail               : require('text!templates/reportOrderDetail.html'),
        reportOrderRow                  : require('text!templates/reportOrderRow.html'),
//        paginationEx                    : require('text!templates/paginationEx.html'),
        pagination                      : require('text!templates/pagination.html'),
        settingsMod                     : require('text!templates/settingsMod.html'),
        settingsMainPageOrders          : require('text!templates/settingsMainPageOrders.html'),
        settingsReportOrders            : require('text!templates/settingsReportOrders.html')
    };
});

