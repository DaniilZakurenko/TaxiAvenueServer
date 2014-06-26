<?php

class Application_Controller_Order extends Engine_Controller
{

    public function __construct()
    {
        Engine_Auth::handleLogin();
    }

    public function createOrder()
    {
        $model = new Application_Model_Order();
        $tarifTypes = $model->getTarifTypes();
        $template = $this->getTemplate('order/editOrder', array(
            'tarifTypes' => $tarifTypes
        ));
        echo json_encode($template);
    }

    public function saveOrder()
    {
        $model = new Application_Model_Order();
        if (isset($_POST['orderId']) && ! empty($_POST['orderId'])) {
            $model->setOrderEditMark($_POST['orderId'], 0);
        }
        
        // echo json_encode(array('orderPost' => $_POST));
        
        $orderSaveResult = $model->saveOrder($_POST);
        if ($orderSaveResult) {
            echo json_encode(array(
                'result' => array(
                    'status' => 'OK'
                )
            ));
            return;
        } else {
            echo json_encode(array(
                'result' => array(
                    'status' => 'Error'
                )
            ));
            return;
        }
    }

    public function editOrder()
    {
        $orderId = str_replace('orderID', '', $_POST['orderId']);
        $model = new Application_Model_Order();
        
        $orderEditStatus = $model->getOrderEditMark($orderId);
        if ($orderEditStatus['editing'] == false || $orderEditStatus['editing'] == true && $orderEditStatus['dispatcher'] == $_SESSION['userId']) {
            $model->setOrderEditMark($orderId, 1);
            $model->setOrderEditTime($orderId);
            $order = $model->getOrderById($orderId);
            $tarifTypes = $model->getTarifTypes();
            $template = $this->getTemplate('order/editOrder', array(
                'order' => $order,
                'tarifTypes' => $tarifTypes
            ));
            echo json_encode($template);
            return;
        } else {
            $editTime = $model->getOrderEditTime($orderId);
            
            $editTime = explode(' ', $editTime);
            
            $date = explode('-', $editTime[0]);
            $time = explode(':', $editTime[1]);
            
            $diff = time() - mktime($time[0], $time[1], $time[2], $date[1], $date[2], $date[0]);
            
            if ($diff < 300) {
                echo json_encode(array(
                    'error' => 'Заказ уже редактируется.'
                ));
                return;
            } else {
                $model->setOrderEditMark($orderId, 1);
                $model->setOrderEditTime($orderId);
                $order = $model->getOrderById($orderId);
                $tarifTypes = $model->getTarifTypes();
                $template = $this->getTemplate('order/editOrder', array(
                    'order' => $order,
                    'tarifTypes' => $tarifTypes
                ));
                echo json_encode($template);
                return;
            }
        }
    }

    public function closeOrder()
    {
        $orderId = isset($_POST['orderId']) ? (int) $_POST['orderId'] : null;
        $reasonId = isset($_POST['reason']) ? (int) $_POST['reason'] : null;
        
        $error = array();
        if ($orderId == null)
            $error[] = "Order id is null";
        if ($reasonId == null)
            $error[] = "Reason id is null";
        
        if (! empty($error)) {
            $errorMessage = implode('. ', $error);
            echo json_encode(array(
                'error' => $error
            ));
            return false;
        }
        
        $params['callsign'] = isset($_POST['callsign']) ? (int) $_POST['callsign'] : null;
        $params['datetime'] = isset($_POST['datetime']) ? (int) $_POST['datetime'] : null;
        $params['driverRejectionReason'] = isset($_POST['driverRejectionReason']) ? $_POST['driverRejectionReason'] : null;
        $params['customerRejectionReason'] = isset($_POST['customerRejectionReason']) ? $_POST['customerRejectionReason'] : null;
        $params['others'] = isset($_POST['others']) ? $_POST['others'] : null;
        
        $orderModel = new Application_Model_Order();
        $closeResult = $orderModel->closeOrder($orderId, $reasonId, $params);
        
        if($closeResult === true) {
            echo json_encode(array(
                'status' => 'OK'
            ));
            return;
        } else {
            echo('false');
        }
        // print_r($closeResult);
    }

    public function getOrderListJSON()
    {
        $model = new Application_Model_Order();
        
        if (isset($_POST['offset'])) {
            $limit = isset($_POST['limit']) ? (int) $_POST['limit'] : 5;
            $offset = (int) $_POST['offset'];
            $sortField = isset($_POST['sortField']) ? $_POST['sortField'] : null;
            $sortDir = isset($_POST['sortDir']) ? $_POST['sortDir'] : null;
            
            $filter = isset($_POST['filter']) ? $_POST['filter'] : null;
            
            $status = isset($filter['status']) ? $filter['status'] : array(
                9,
                10,
                12,
                17,
                18,
                22
            );
            
            $orders = $model->getOrderListJSON($status, false, $offset, $limit, $sortField, $sortDir, $filter);
            
            echo json_encode(array(
                'orders' => $orders
            ));
            return;
        }
        
        $orders = $model->getOrderListJSON(array(
            6,
            7,
            8,
            11
        ), null);
        
        $statusModel = new Application_Model_Status();
        $statusList = $statusModel->getStatusList();
        
        echo json_encode(array(
            'orders' => $orders['orderList'],
            'statusList' => $statusList
        ));
    }

    public function setOrderEditMark()
    {
        $model = new Application_Model_Order();
        if ($model->setOrderEditMark($_POST['orderId'], 0)) {
            echo json_encode(array(
                'response' => true
            ));
        } else {
            echo json_encode(array(
                'response' => 'Error'
            ));
        }
    }

    public function getOrderCostInfo()
    {
        $order = $_POST;
        $model = new Application_Model_Order();
        $cost = $model->calculate($order);
        // echo json_encode(array('costInfo' => $cost));
        echo json_encode($cost);
        return true;
    }

    public function getReport()
    {}

    public function getOrderDriverNoteList()
    {
        $model = new Application_Model_Order();
        $noteList = $model->getOrderDriverNoteList();
        echo json_encode($noteList);
    }

    public function getOrderDispNoteList()
    {
        $model = new Application_Model_Order();
        $noteList = $model->getOrderDispNoteList();
        echo json_encode($noteList);
    }
}