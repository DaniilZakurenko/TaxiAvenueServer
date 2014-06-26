<?php

class Application_Controller_Test extends Engine_Controller
{

    public function testOrderEntity()
    {
        $orderModel = new Application_Model_Order_Model();
        $orderList = $orderModel->getOrder(null, array(
            'field' => 'status',
            'dir' => 'DESC'
        ), '');
        
        $statusModel = new Application_Model_Status_Model();
        $statusList = $statusModel->getStatusList();
        
        if ($orderList)
            echo json_encode(array(
                'orderList' => $orderList,
                'statusList' => $statusList
            ));
    }

    public function getDriverStatus()
    {
        $model = new Application_Model_Driver();
        print_r($model->getDriverStatus(54346));
    }

    public function findDriver()
    {
        $model = new Application_Model_Driver();
        echo '<pre>';
        print_r($model->findDriver2('48.473211', '35.02618400000006'));
        echo '</pre>';
    }

    public function setDriverStatus()
    {
        $model = new Application_Model_Driver();
        echo '<pre>';
        print_r($model->setDriverStatus(22, 123, 'FREE'));
        echo '</pre>';
    }

    public function setLocation()
    {
        $model = new Application_Model_Driver();
        $model->setLocation(23, array(
            'lat' => 48.4253796,
            'lng' => 35.0272519
        ));
    }

    public function push1003()
    {
        // print_r($_GET);
        $driverId = $_GET['driverId'];
        $orderId = $_GET['orderId'];
        
        $model = new Application_Model_Driver();
        $regId = $model->getPushRegistrationId($driverId);
        
        $message = array(
            "messageType" => 1003,
            "orderId" => $orderId
        );
        
        $push = new Lib_Push_GCM();
        $pushResult = $push->sendNotification(array(
            $regId
        ), $message);
    }

    public function push1006()
    {
        // print_r($_GET);
        $driverId = $_GET['driverId'];
        // $orderId = $_GET['orderId'];
        
        $driverModel = new Application_Model_Driver();
        $driverRegId = $driverModel->getPushRegistrationId($driverId);
        $driverRegId = $driverRegId[0]['g_reg_id'];
        
        // print_r($driverRegId);
        
        $push = new Lib_Push_GCM();
        $result = $push->push1006(array(
            $driverRegId
        ), array(
            'message' => array(
                'id' => 1,
                'subject' => 'John',
                'from' => 'Me',
                'datetime' => date('Y-m-d H:i:s'),
                'body' => 'BODY'
            )
        ));
        
        print_r($result);
    }

    public function testTakeOrder()
    {
        $order = new Application_Model_Order();
        $order->takeOrder($_GET['order'], $_GET['driver']);
    }
    
    /*
     * public function sendMessage() { $driverModel = new Application_Model_Driver(); $regIds = $driverModel->getPushRegistrationId(); echo '<pre>'; print_r($regIds); echo '</pre><hr>'; $message = array( "messageType" => 1006, "message" => array( "id" => 123, "subject" => 'subject', "from" => 'TaxiAvenue', "datetime" => date('Y-m-d H:i:s'), "body" => 'text' ) ); echo '<pre>'; print_r($message); echo '</pre<hr>>'; $push = new Lib_Push_GCM(); $pushResult = $push->sendNotification($regIds, $message); echo '<pre>'; print_r($pushResult); echo '</pre><hr>'; }
     */
    public function getMessages()
    {
        $driverId = isset($_GET['id']) ? $_GET['id'] : null;
        if ($driverId == null) {
            echo json_encode(array(
                'error' => 'id is null'
            ));
            die();
        }
        
        $sessionId = isset($_GET['sessionId']) ? $_GET['sessionId'] : null;
        if ($sessionId == null) {
            echo json_encode(array(
                'error' => 'sessionId is null'
            ));
            die();
        }
        
        $pageNum = isset($_GET['pageNum']) ? $_GET['pageNum'] : null;
        if ($pageNum == null) {
            echo json_encode(array(
                'error' => 'pageNum is null'
            ));
            die();
        }
        
        $itemsOnPage = isset($_GET['itemsOnPage']) ? $_GET['itemsOnPage'] : null;
        if ($itemsOnPage == null) {
            echo json_encode(array(
                'error' => 'itemsOnPage is null'
            ));
            die();
        }
    }

    public function sendMessage()
    {
        $messageModel = new Application_Model_Message();
        
        $message = $_GET['message'];
        $ids = $_GET['ids'];
        
        echo '<pre>';
        print_r($message);
        echo '<hr>';
        print_r($ids);
        echo '</pre>';
        echo '<hr>';
        
        $messageModel->sendMessage(1, $message, $ids);
    }

    public function addOrderToHistory()
    {
        $history = new Application_Controller_History();
        $result = $history->addOrderToHistory(21, 13, date('Y-m-d H:i:s'), 3);
        if ($result)
            echo 'OK';
        else
            echo 'Err';
    }

    public function updateOrderInHistory()
    {
        $history = new Application_Controller_History();
        $result = $history->updateOrderInHistory(23, 5, date('Y-m-d H:i:s'), 3);
        if ($result)
            echo 'OK';
        else
            echo 'Err';
    }

    public function getHistory()
    {
        $history = new Application_Controller_History();
        print_r($result = $history->getOrderHistory(23, null, null, null, null));
        // $result = $history->getOrderHistory(23, '2013-01-01', '2014-02-01', null, null);
        // $result = $history->getOrderHistory(23, null, '2013-02-01', null, null);
        // if($result) echo 'OK';
        // else echo 'Err';
    }

    public function getStatusList()
    {
        $model = new Application_Model_Status();
        echo '<pre>';
        print_r($model->getStatusList());
        echo '</pre>';
    }

    public function sendSms()
    {
        $sms = new Lib_Sms_Sms();
        $result = $sms->sendSms('+380957536866', 'За вами уже выехали, ожидайте');
        print_r($result);
    }

    public function getOnlineDrivers()
    {
        $model = new Application_Model_Driver();
        $drivers = $model->getOnlineDrivers();
        echo json_encode($drivers);
    }

    public function getDriverList()
    {
        $model = new Application_Model_Driver();
        $drivers = $model->getDriverList('callsign', 2);
        echo '<pre>';
        print_r($drivers);
        echo '</pre>';
    }

    public function testPushRedirect()
    {
        $driverModel = new Application_Model_Driver();
        $callsigns = $driverModel->findDriver('48.473211', '35.02618400000006', null, false);
        
        echo '<pre>';
        print_r($callsigns);
        echo '</pre>';
        
        $drivers = $driverModel->getDriverByCallsign($callsigns);
        
        echo '<pre>';
        print_r($drivers);
        echo '</pre>';
        
        $driverIds = array();
        foreach ($drivers as $driver) {
            $driverIds[] = $driver['id'];
            $driverClsngs[$driver['id']] = $driver['callsign'];
        }
        
        $orderModel = new Application_Model_Order();
        // echo json_encode(array("error" => 967)); die();
        $refusedDrivers = $orderModel->getDriverOrderRefusedList(266);
        // echo json_encode(array("error" => 960)); die();
        $availableDrivers = $orderModel->formOrderSendDriverList($driverIds, $refusedDrivers);
        
        echo '<pre>';
        print_r($driverClsngs);
        echo '</pre>';
        
        echo '<pre>';
        print_r($availableDrivers);
        echo '</pre>';
    }

    public function getOrderListJSONwSort()
    {
        $model = new Application_Model_Order();
        
        $limit = isset($_POST['limit']) ? (int) $_POST['limit'] : 5;
        $offset = isset($_POST['offset']) ? (int) $_POST['offset'] : 0;
        $sortField = isset($_POST['sortField']) ? $_POST['sortField'] : null;
        $sortDir = isset($_POST['sortDir']) ? $_POST['sortDir'] : null;
        
        // $sortDir = 'ASC';
        
        $orders = $model->getOrderListJSON(array(
            9,
            10,
            12,
            17,
            18,
            22
        ), false, $offset, $limit, 'firstPoint', 'DESC');
        
        echo '<pre>';
        print_r($orders);
        echo '</pre>';
    }

    public function pushDelete()
    {
        $message = array(
            'action' => 'DELETE'
        );
        
        $push = new Lib_Push_GCM();
        $push->setGCMKey('AIzaSyD7BUD0RczQxajS8vjCmEwlg0RjjtUAQt4');
        $pushResult = $push->sendNotification(array(
            $_GET['pushId']
        ), $message);
        
        echo '<pre>';
        print_r($message);
        print_r($pushResult);
        echo '</pre>';
    }
    
    public function pushGeoposition()
    {
        $message = array(
            'action' => 'GPS'
        );
    
        $push = new Lib_Push_GCM();
        $push->setGCMKey('AIzaSyD7BUD0RczQxajS8vjCmEwlg0RjjtUAQt4');
        $pushResult = $push->sendNotification(array(
            $_GET['pushId']
        ), $message);
    
        echo '<pre>';
        print_r($message);
        print_r($pushResult);
        echo '</pre>';
    }
}