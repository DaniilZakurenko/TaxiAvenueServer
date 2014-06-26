<?php

class Application_Controller_Mobile extends Engine_Controller
{

    private $callsign;

    private $driverId;

    private $driverPassword;

    private $driverSessionId;

    private $driverStatus;

    private $orderId;

    public function __construct()
    {
        $this->callsign = isset($_POST['callsign']) ? (int) $_POST['callsign'] : null;
        $this->driverId = isset($_POST['id']) ? (int) $_POST['id'] : null;
        $this->driverPassword = isset($_POST['password']) ? $_POST['password'] : null;
        $this->driverSessionId = isset($_POST['sessionId']) ? $_POST['sessionId'] : null;
        $this->driverStatus = isset($_POST['status']) ? $_POST['status'] : null;
        $this->orderId = isset($_POST['orderId']) ? (int) $_POST['orderId'] : null;
    }

    public function index()
    {}

    public function login()
    {
        $error = array();
        if ($this->callsign == null)
            $error[] = "Введите позывной";
        if ($this->driverPassword == null)
            $error[] = "Введите пароль";
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $auth = new Engine_Auth(new Engine_Database(DB_TYPE, CENTRAL_DB_HOST, CENTRAL_DB_NAME, CENTRAL_DB_USER, CENTRAL_DB_PASS));
        $authResult = $auth->auth($this->callsign, $this->driverPassword, 'mobile');
        
        echo json_encode($authResult);
    }

    public function setLocation()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = "Параметр id не указан";
        if ($this->driverSessionId == null)
            $error[] = "Параметр session не указан";
        
        $loc['lng'] = isset($_POST['lng']) ? $_POST['lng'] : null;
        $loc['lat'] = isset($_POST['lat']) ? $_POST['lat'] : null;
        
        if ($loc['lng'] == null)
            $error[] = "Параметр lng не указан";
        if ($loc['lat'] == null)
            $error[] = "Параметр lat не указан";
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $driverModel = new Application_Model_Driver();
        $saveLocationResult = $driverModel->setLocation($this->driverId, $loc);
        if ($saveLocationResult)
            echo json_encode(array(
                "response" => "OK"
            ));
        else
            echo json_encode(array(
                "error" => "Не удалось сохранить координаты"
            ));
        return;
    }

    public function setPushRegistrationId()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = "Параметр id не указан";
        if ($this->driverSessionId == null)
            $error[] = "Параметр session не указан";
        
        $gRegId = isset($_POST['registrationId']) ? $_POST['registrationId'] : null;
        
        if ($gRegId == null)
            $error[] = "Параметр registrationId не указан";
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $driverModel = new Application_Model_Driver();
        if ($driverModel->setPushRegistrationId($this->driverId, $this->driverSessionId, $gRegId))
            echo json_encode(array(
                "response" => "OK"
            ));
        else {
            echo json_encode(array(
                "error" => "Не удалось сохранить id для отправки PUSH уведомлений"
            ));
        }
    }

    public function getOrderList()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = "Параметр id не указан";
        if ($this->driverSessionId == null)
            $error[] = "Параметр session не указан";
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $orderModel = new Application_Model_Order();
        $orders = $orderModel->getOrderListJSON(array(
            6
        ), false);
        
        $orderList = array();
        foreach ($orders['orderList'] as $order) {
            $orderModel->addDriverToSentList($order['orderId'], array(
                $this->driverId
            ));
            $orderList['orders'][] = $orderModel->createOrderPushMessage($order['orderId']);
        }
        
        echo json_encode($orderList);
    }

    public function takeOrder()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = "Параметр id не указан";
        if ($this->driverSessionId == null)
            $error[] = "Параметр session не указан";
        if ($this->orderId == null)
            $error[] = "Параметр orderId не указан";
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $arriveMinutes = isset($_POST['arrive_minutes']) ? $_POST['arrive_minutes'] : null;
        
        $orderModel = new Application_Model_Order();
        $orderStatus = $orderModel->getOrderStatus($this->orderId);

        $order = $orderModel->getOrderById($this->orderId);
        if ($orderStatus != 6) {
            if ($orderStatus == 7) {
                if ($order['driver'] == $this->driverId) {
                    echo json_encode(array(
                        "response" => "OK"
                    ));
                } else {
                    echo json_encode(array(
                        "error" => "Заказ уже взят. Для продолжения работы с программой откажитесь от заказа"
                    ));
                }
            } else {
                echo json_encode(array(
                    "error" => "Заказ уже взят. Для продолжения работы с программой откажитесь от заказа"
                ));
            }
            return;
        }

        if ($orderStatus == 6) {
            $takeResult = $orderModel->takeOrder($this->driverId, $this->driverPassword, $this->driverSessionId, $this->orderId, $arriveMinutes);
            
            if ($takeResult) {
                $modelDriver = new Application_Model_Driver();
                $driver = $modelDriver->getDriverById($this->driverId);
                
                if (isset($order['properties'][0]['customerPhone']) && ! empty($order['properties'][0]['customerPhone'])) {
                    $sms = new Lib_Sms_Sms();
                    $smsText = 'В ' . date("d-m-Y H:i:s", time() + $arriveMinutes * 60) . ' ,будет ' . $driver[0]['car_color'] . ' ' . $driver[0]['car_model'] . ' ' . $driver[0]['car_number'];
                    $smsResult = $sms->sendSms($order['properties'][0]['customerPhone'], $smsText);
                }

                $history = new Application_Controller_History();
                $history->addOrderToHistory($this->driverId, $this->orderId, date('Y-m-d H:i:s'), 2);
                echo json_encode(array(
                    "response" => "OK"
                ));
            } else {
                echo json_encode(array(
                    // "error" => "Не удалось взять заказ."
                    "error" => $takeResult
                ));
            }
            return;
        }
    }

    public function cancelOrder()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = "Параметр id не указан";
        if ($this->driverSessionId == null)
            $error[] = "Параметр session не указан";
        if ($this->orderId == null)
            $error[] = "Параметр orderId не указан";

        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $orderModel = new Application_Model_Order();
        $orderStatus = $orderModel->getOrderStatus($this->orderId);
        if ($orderStatus != 6) {
            echo json_encode(array(
                "response" => "OK"
            ));
            return;
        }
        
        if ($orderModel->cancelOrder($this->driverId, $this->driverPassword, $this->driverSessionId, $this->orderId)) {
            $history = new Application_Controller_History();
            $history->addOrderToHistory($this->driverId, $this->orderId, date('Y-m-d H:i:s'), 16);
            echo json_encode(array(
                "response" => "OK"
            ));
        }
    }

    public function setDriverStatus()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = 'Параметр id не указан';
        if ($this->driverSessionId == null)
            $error[] = 'Параметр session не указан';
        if ($this->driverStatus == null)
            $error[] = 'Параметр status не указан';
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $driverModel = new Application_Model_Driver();
        $driverStatus = $driverModel->getDriverStatus($this->driverId);
        
        if ($this->driverStatus != 19) {
            if ($driverModel->setDriverStatus($this->driverId, $this->driverStatus)) {
                echo json_encode(array(
                    "response" => "OK"
                ));
                return;
            } else {
                echo json_encode(array(
                    "error" => "Не удалось обновить статус"
                ));
                return;
            }
        }
        
        if ($driverStatus == 23) {
            echo json_encode(array(
                "response" => "OK"
            ));
            return;
        }
        
        echo json_encode(array(
            "response" => "OK"
        ));
        return;
    }

    public function sendOrderMessage()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = 'Параметр id не указан';
        if ($this->driverSessionId == null)
            $error[] = 'Параметр session не указан';
        
        $messageType = isset($_POST['messageType']) ? $_POST['messageType'] : null;
        
        if ($messageType == null)
            $error[] = "Параметр messageType не указан";
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $orderModel = new Application_Model_Order();
        $date = date('Y-m-d H:i:s');
        
        switch ($messageType) {
            case 'KICK_PASSENGER':
                if ($orderModel->setOrderStatus($this->orderId, 11))
                    $order = $orderModel->getOrderById($this->orderId);
                if (isset($order['properties'][0]['customerPhone']) && ! empty($order['properties'][0]['customerPhone'])) {
                    $sms = new Lib_Sms_Sms();
                    $smsText = 'Машина по адресу ' . $order['startPoint'] . '. Пожалуйста выходите';
                    $smsResult = $sms->sendSms($order['properties'][0]['customerPhone'], $smsText);
                }
                echo json_encode(array(
                    "response" => "OK"
                ));
                return true;
                break;
            case 'NO_PASSENGER':
                if ($orderModel->setOrderStatus($this->orderId, 12))
                    echo json_encode(array(
                        "response" => "OK"
                    ));
                return true;
                break;
            case 'PASSENGER_HERE':
                if ($orderModel->setOrderStatus($this->orderId, 8))
                    echo json_encode(array(
                        "response" => "OK"
                    ));
                return true;
                break;
            case 'LATE_TO_ORDER_5':
                if ($orderModel->setOrderStatus($this->orderId, 13))
                    echo json_encode(array(
                        "response" => "OK"
                    ));
                return true;
                break;
            case 'LATE_TO_ORDER_10':
                if ($orderModel->setOrderStatus($this->orderId, 14))
                    echo json_encode(array(
                        "response" => "OK"
                    ));
                return true;
                break;
            case 'LATE_TO_ORDER_15':
                if ($orderModel->setOrderStatus($this->orderId, 15))
                    echo json_encode(array(
                        "response" => "OK"
                    ));
                return true;
                break;
            case 'ORDER_COMPLETE':
                // echo json_encode(array(
                // 'error' => $_POST
                // ));
                // return;
                
                $locationTrack = isset($_POST['locationTrack']) ? json_decode($_POST['locationTrack']) : null;
                
                if ($locationTrack != null) {
                    $result = $orderModel->orderComplete($this->orderId, $this->driverId, $date, 9, $locationTrack);
                    $driverModel = new Application_Model_Driver();
                    $driverRegId = $driverModel->getPushRegistrationId($this->driverId);
                    $driverRegId = $driverRegId[0]['g_reg_id'];
                    
                    $push = new Lib_Push_GCM();
                    $push->push1006(array(
                        $driverRegId
                    ), array(
                        'id' => $this->orderId,
                        'subject' => 'Заказ с одной точкой',
                        'from' => 'TaxiAvenue',
                        'datetime' => date('Y-m-d H:i:s'),
                        'body' => "Стоимость заказа: $result"
                    ));
                } else
                    $orderModel->orderComplete($this->orderId, $this->driverId, $date, 9, $locationTrack);
                
                $history = new Application_Controller_History();
                $history->updateOrderInHistory($this->driverId, $this->orderId, $date, 9);
                
                echo json_encode(array(
                    "response" => "OK"
                ));
                return true;
                break;
            default:
                echo json_encode(array(
                    "error" => "Wrong message type - $messageType"
                ));
                break;
        }
    }

    public function getBalans()
    {
        $a['data'] = "0";
        echo json_encode($a);
    }

    public function getHistory()
    {
        $error = array();
        if ($this->driverId == null)
            $error[] = 'Параметр id не указан';
        if ($this->driverSessionId == null)
            $error[] = 'Параметр session не указан';
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return;
        }
        
        $dateStart = isset($_POST['dateB']) ? $_POST['dateB'] : null;
        $dateEnd = isset($_POST['dateE']) ? $_POST['dateE'] : null;
        $page = isset($_POST['page']) ? $_POST['page'] : null;
        $entriesPerPage = isset($_POST['entriesPerPage']) ? $_POST['entriesPerPage'] : null;
        
        $historyController = new Application_Controller_History();
        $historyController->getOrderHistory($this->driverId, $dateStart, $dateEnd, $page, $entriesPerPage);
    }

    public function getMsg()
    {
        $a['data'] = "0";
        echo json_encode($a);
    }
}

//APA91bEQKg_qM_uhE4_r4EWGRlqWYGRVqhvBWiSrDQ2ZfLcSQRGXGnC4ziLXzo5x5fGm1xgBPBnLMrhjw3DIRV1wfZiV9xZqUE5ZAtZvyketAZQnMWSb327UKog9N0Ovo8boIEQBm9sN9l9NusyfgCmK6XBWfKTESzoWYjRE0ThsONaT6Tybce0