<?php

// /hsphere/shared/php5/bin/php-cgi taxiavenue.corvus.dp.ua/cron/cron.php
include_once 'config.php';

checkOrder();

function checkOrder()
{
    $orderModel = new Application_Model_Order();
    $orderList = $orderModel->getOrderListJSON(array(
        6
    ));
    
    $driverModel = new Application_Model_Driver();
    $push = new Lib_Push_GCM();
    $sms = new Lib_Sms_Sms();
    
    $orderListCnt = count($orderList);
    if ($orderListCnt > 0) {
        foreach ($orderList['orderList'] as $order) {
            $orderCreateDateTime = makeUnixDateTime($order['createDatetime']);
            $timeDiff = time() - $orderCreateDateTime;
            
            if (! empty($order['driverId'])) {
                if ($timeDiff > 20) {
                    $orderModel->cancelOrder($order['driverId'], '', '', $order['orderId']);
                }
            } else {
                if($timeDiff > 120) {
                    $orderModel->orderComplete($order['orderId'], null, date('Y-m-d H:i:s'), 18);
                    //$sms->sendSms($order['properties'][0]['customerPhone'], 'Простите, мы не смогли найти для Вас свободную машину');
                    $driverOrderSent = $orderModel->getDriverOrderSentList($order['orderId']);
                    $drivers = $driverModel->getPushRegistrationId($driverOrderSent);
                
                    if($driverOrderSent > 0 && $drivers != false) {
                        if (count($drivers) > 0) {
                            $push = new Lib_Push_GCM();
                
                            $regIds = array();
                            $driverIds = array();
                            foreach ($drivers as $driver) {
                                $regIds[] = $driver['g_reg_id'];
                                $driverIds[] = $driver['id'];
                            }
                
                            $message1003 = array(
                                "messageType" => 1003,
                                "orderId" => $order['orderId']
                            );
                
                            $pushResult = $push->sendNotification($regIds, $message1003);
                        }
                    }
                }
            }
        }
    }
    
    $fp = fopen('data.txt', 'w');
    fwrite($fp, date('Y-m-d H:i:s'));
    fclose($fp);
}

function makeUnixDateTime($dateTime)
{
    $date_elems = explode(" ", $dateTime);
    $date = explode("-", $date_elems[0]);
    $time = explode(":", $date_elems[1]);
    $updateTime = mktime($time[0], $time[1], $time[2], $date[1], $date[2], $date[0]);
    return $updateTime;
}