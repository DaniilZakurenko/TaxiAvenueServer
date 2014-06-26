<?php

class Application_Model_Order extends Engine_Model
{

    private $sortableFields = array(
        'default' => ' ORDER BY createDatetime',
        'status' => ' ORDER BY status',
        'callsign' => ' ORDER BY taxi_driver_info.callsign',
        'firstPoint' => ' ORDER BY order_start_point.address',
        'cost' => ' ORDER BY order_info.cost',
        'length' => ' ORDER BY order_info.length',
        'createDatetime' => ' ORDER BY createDatetime',
        'arriveDatetime' => ' ORDER BY arriveDatetime',
        'takeDatetime' => ' ORDER BY takeDatetime',
        'finishDatetime' => ' ORDER BY finishDatetime',
        'phone' => ' ORDER BY order_cl_info.phone'
    );

    private $orderClosedStatus = array(
        9,
        17,
        18,
        22,
        24,
        25
    );

    public function __construct()
    {}

    public function calculate($order)
    {
        $pointsCount = count($order['point']) >= 1 ? count($order['point']) : null;
        if ($pointsCount == null || empty($order['point'][0]['S']))
            return array(
                'error' => 'Not enough points'
            );
        
        if ($pointsCount == 1 && ! isset($order['city'])) {
            return array(
                'error' => 'Not enough points'
            );
        }
        
        $path = '';
        
        $db = $this->getDbCentral();
        $payment = isset($order['nonCashPayment']) ? 'non_cash_payment_tarif' : 'cash_payment_tarif';
        $tarifId = $tarif = $db->select('SELECT * FROM ' . $payment . ' WHERE type = ' . $order['tarif']);
        
        if ($pointsCount == 1) {
            $path = $this->getPathLength($order);
            $length = $path['length'];
            $points_loc = $path['pointsLoc'];
            
            return array(
                'costInfo' => array(
                    'cost' => '25',
                    'length' => $length,
                    'tarif' => $tarif[0],
                    'points_loc' => $points_loc
                )
            );
        }
        
        if ($pointsCount > 1) {
            $path = $this->getPathLength($order);
            $length = $path['length'];
            $points_loc = $path['pointsLoc'];
            
            $cost = 0;
            
            if ($length <= $tarif[0]['kmMin']) {
                $cost += $tarif[0]['fluidTarifMin'];
            } else {
                $dif = $length - $tarif[0]['kmMin'];
                $cost += $tarif[0]['fluidTarifMin'] + ($dif / 1000) * $tarif[0]['fluidTarification'];
            }
            
            $cost += $this->getAdditionalOrderCost($order, $pointsCount, $cost);
            
            $cost = round($cost, 0);
            
            return array(
                'costInfo' => array(
                    'cost' => $cost,
                    'length' => $length,
                    'tarif' => $tarif[0],
                    'points_loc' => $points_loc
                )
            );
        }
    }

    public function getAdditionalOrderCost($order, $pointCount, $cost)
    {
        $model = new Application_Model_Tariffication();
        
        $commonTariff = $model->getCommonTariffication();
        $additionalTariff = $model->getAdditionalServices();
        
        $extraCost = 0;
        
        if (isset($order['nonCashPayment']))
            $extraCost += ($cost / 100) * $commonTariff->nonCash->value;
        
        if ($pointCount > $commonTariff->eachPointExtra->point) {
            $extraCost += ($pointCount - $commonTariff->eachPointExtra->point) * $commonTariff->eachPointExtra->value;
        }
        
        if (isset($order['grach']) && $commonTariff->grach->active == true) {
            if ($commonTariff->grach->type == 'UAH')
                $extraCost += $commonTariff->grach->value;
            if ($commonTariff->grach->type == 'CNT')
                $extraCost += ($cost / 100) * $commonTariff->grach->value;
        }
        
        if ($commonTariff->snowExtra->active == true) {
            if ($commonTariff->snowExtra->type == 'UAH')
                $extraCost += $commonTariff->snowExtra->value;
            if ($commonTariff->snowExtra->type == 'CNT')
                $extraCost += ($cost / 100) * $commonTariff->snowExtra->value;
        }
        
        if (isset($order['addService'])) {
            foreach ($order['addService'] as $key => $value) {
                for ($j = 0, $addTariffCnt = count($additionalTariff); $j < $addTariffCnt; $j ++) {
                    if ($additionalTariff[$j]['name'] == $key) {
                        if ($additionalTariff[$j]['type'] == 'UAH')
                            $extraCost += $additionalTariff[$j]['value'];
                        if ($additionalTariff[$j]['type'] == 'CNT')
                            $extraCost += ($cost / 100) * $additionalTariff[$j]['value'];
                        
                        break;
                    }
                }
            }
        }
        return $extraCost;
    }

    public function getPathLength($order)
    {
        $pointsCount = count($order['point']);
        $path = '';
        
        if ($pointsCount > 1) {
            for ($i = 1; $i < $pointsCount; $i ++) {
                $path .= str_replace(' ', '+', $order['point'][$i]['S']) . '+' . $order['point'][$i]['N'] . '+Днепропетровск|';
            }
            
            $from = str_replace(' ', '+', $order['point'][0]['S']) . '+' . $order['point'][0]['N'] . '+Днепропетровск|';
            
            $path = rtrim($path, '|');
            $path = str_replace(',', '+', $path);
            $path = str_replace('.', '+', $path);
            
            $ch = curl_init();
            
            curl_setopt($ch, CURLOPT_URL, "http://maps.googleapis.com/maps/api/directions/json?origin=$from&waypoints=$path&units=metric&mode=driving&sensor=false");
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            
            $result = json_decode(curl_exec($ch), true);
            curl_close($ch);
            
            $length = 0;
            
            foreach ($result['routes'][0]['legs'] as $leg) {
                $length += $leg['distance']['value'];
                $points_loc[] = (array) $leg['start_location'];
            }
            
            $points_loc[] = (array) $result['routes'][0]['legs'][count($result['routes'][0]['legs']) - 1]['end_location'];
            
            return array(
                'pointsLoc' => $points_loc,
                'length' => $length
            );
        } else {
            $address = 'Днепропетровск,' . str_replace(' ', '+', $order['point'][0]['S']) . '+' . $order['point'][0]['N'];
            $ch = curl_init();
            
            curl_setopt($ch, CURLOPT_URL, "http://maps.googleapis.com/maps/api/geocode/json?address=$address&sensor=false");
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            
            $result = json_decode(curl_exec($ch), true);
            curl_close($ch);
            
            $point_loc[] = $result['results'][0]['geometry']['location'];
            
            return array(
                'pointsLoc' => $point_loc,
                'length' => ''
            );
        }
    }

    public function saveOrder($order)
    {
        if (isset($order['orderId']) && empty($order['orderId']))
            unset($order['orderId']);
        
        if ($order['point'][0]['S'] == '')
            return false;
        
        $callsign = isset($order['callsign']) ? $order['callsign'] : null;
        // $forcedOrder = isset($order['forcedOrder']) ? true : false;
        if ($callsign != null)
            $forcedOrder = true;
        else
            $forcedOrder = false;
        
        for ($i = 0, $pointCnt = count($order['point']); $i < $pointCnt; $i ++) {
            if ($order['point'][$i]['S'] == '')
                unset($order['point'][$i]);
        }
        ksort($order['point']);
        
        if (count($order['point']) == 0)
            return;
        
        if (isset($order['orderId'])) {
            $oldOrder = $this->getOrderById($order['orderId']);
            $this->updateOrder($order, $oldOrder);
            if (in_array($oldOrder['properties'][0]['status'], $this->orderClosedStatus))
                return true;
            $orderId = $order['orderId'];
            $orderStatus = $this->getOrderStatus($orderId);
        } else {
            $orderId = $this->saveNewOrder($order);
            $orderStatus = 6;
        }
        
        if (! $orderId) {
            return false;
        }
        
        $driverOrderSent = $this->getDriverOrderSentList($orderId);
        
        $push = new Lib_Push_GCM();
        $driverModel = new Application_Model_Driver();
        
        if (! empty($driverOrderSent)) {
            $drivers = $driverModel->getPushRegistrationId($driverOrderSent);
            
            if (! empty($drivers)) {
                foreach ($drivers as $driver) {
                    $regIds[] = $driver['g_reg_id'];
                    $driverIds[] = $driver['id'];
                }
                
                $message1003 = array(
                    "messageType" => 1003,
                    "orderId" => $orderId
                );
                
                $pushResult = $push->sendNotification($regIds, $message1003);
            }
        }
        
        if ($callsign == null || $forcedOrder == false) {
            $drivers = $driverModel->getPushRegistrationId(null, 1, null);
            
            if (! empty($drivers)) {
                foreach ($drivers as $driver) {
                    $regIds[] = $driver['g_reg_id'];
                    $driverIds[] = $driver['id'];
                }
                
                if (count($driverIds) > 0) {
                    $message = $this->createOrderPushMessage($orderId, 1002);
                    
                    $regIds = array_unique($regIds);
                    sort($regIds);
                    
                    $pushResult = $push->sendNotification($regIds, $message);
                    
                    $db = $this->getDbCentral();
                    $db->insert('push', array(
                        'drivers' => json_encode($driverIds),
                        'order_id' => $orderId,
                        'message' => json_encode($message),
                        'date' => date('Y-m-d H:i:s'),
                        'result' => $pushResult
                    ));
                    
                    $this->addDriverToSentList($orderId, $driverIds);
                }
            }

            return true;
        }

        if ($callsign != null || $forcedOrder == true) {
            if ($orderStatus == 7 || $orderStatus == 8) {
                $db = $this->getDbCentral();
                
                $currentDriver = $db->select('SELECT order_list.driver FROM order_list WHERE order_list.id = :orderId', array(
                    ':orderId' => $orderId
                ));
                
                if (! empty($currentDriver)) {
                    $regId = $driverModel->getPushRegistrationId($currentDriver[0]['driver']);
                    
                    $message = $this->createOrderPushMessage($orderId, 1007);
                    $pushResult = $push->sendNotification(array(
                        $regId
                    ), $message);
                }
            } else {
                $driver = $driverModel->getDriverByCallsign($callsign);
                if (! empty($driver)) {
                    $driverModel->setDriverStatus($driver[0]['id'], 'BUSY');
                    $this->setOrderDriver($orderId, $driver[0]['id']);
                    
                    $message = $this->createOrderPushMessage($orderId, 1001);
                    $pushResult = $push->sendNotification(array(
                        $driver[0]['g_reg_id']
                    ), $message);
                }
            }
            return true;
        }
        
        return true;
    }

    private function saveNewOrder($order)
    {
        $calculate = $this->calculate($order);
        if (isset($calculate['error']))
            return false;
        
        $customerModel = new Application_Model_Customer();
        $customer = $customerModel->getCustomerByPhone($order['customerPhone']);
        if (empty($customer))
            $customerId = $customerModel->saveCustomer($order['customerPhone'], $order['customerName']);
        else
            $customerId = $customer[0]['id'];
        
        $db = $this->getDbCentral();
        $db->insert('order_list', array(
            'dispatcher' => $_SESSION['userId'],
            'customer' => $customerId
        ));
        $orderId = $db->lastInsertId();
        $db->insert('order_cl_info', array(
            'order_id' => $orderId,
            'phone' => $order['customerPhone'],
            'name' => $order['customerName']
        ));
        
        $type = 1;
        $payment = isset($order['nonCashPayment']) ? 'non_cash_payment_tarif' : 'cash_payment_tarif';
        
        $db->insert('order_info', array(
            'order_id' => $orderId,
            'type' => $type,
            'payment' => $payment,
            'tarif_id' => $order['tarif'],
            'tarif' => isset($calculate['costInfo']['tarif']) ? json_encode($calculate['costInfo']['tarif']) : '',
            'length' => isset($calculate['costInfo']['length']) ? $calculate['costInfo']['length'] : '',
            'cost' => isset($calculate['costInfo']['cost']) ? $calculate['costInfo']['cost'] : '',
            'driver_note' => $order['driverNote'],
            'dispatcher_note' => $order['dispatcherNote']
        ));
        
        $pointCount = count($order['point']);
        $db->delete('order_points', "`order_id` = " . $orderId);
        for ($i = 0; $i < $pointCount; $i ++) {
            $db->insert('order_points', array(
                'order_id' => $orderId,
                'point_id' => $i,
                'point' => $order['point'][$i]['S'] . ', ' . $order['point'][$i]['N'],
                'location' => json_encode($calculate['costInfo']['points_loc'][$i])
            ));
        }
        
        $db->insert('order_status', array(
            'order_id' => $orderId,
            'status' => 6,
            'dispatcher' => $_SESSION['userId']
        ));
        $db->insert('order_time', array(
            'order_id' => $orderId,
            'add' => date('Y-m-d H:i:s')
        ));
        
        $airCondition = isset($order['addService']['airCondition']) ? 1 : 0;
        $salonLoading = isset($order['addService']['salonLoading']) ? 1 : 0;
        $animal = isset($order['addService']['animal']) ? 1 : 0;
        $city = isset($order['city']) ? 1 : 0;
        $courierDelivery = isset($order['addService']['courierDelivery']) ? 1 : 0;
        $terminal = isset($order['terminal']) ? 1 : 0;
        $nameSign = isset($order['addService']['nameSign']) ? 1 : 0;
        $hour = isset($order['hour']) ? 1 : 0;
        $grach = isset($order['grach']) ? 1 : 0;
        $ticket = isset($order['ticket']) ? 1 : 0;
        
        $db->insert('order_properties', array(
            'order_id' => $orderId,
            'airCondition' => $airCondition,
            'salonLoading' => $salonLoading,
            'animal' => $animal,
            'city' => $city,
            'courierDelivery' => $courierDelivery,
            'terminal' => $terminal,
            'nameSign' => $nameSign,
            'hour' => $hour,
            'grach' => $grach,
            'ticket' => $ticket
        ));
        
        $db->insert('order_start_point', array(
            'order_id' => $orderId,
            'address' => $order['addr'],
            'apartment' => $order['apartment'],
            'porch' => $order['porch']
        ));
        
        $db->insert('order_sent', array(
            'order_id' => $orderId
        ));
        
        return $orderId;
    }

    private function updateOrder($newOrder, $oldOrder)
    {
        $oldPoints = '';
        for ($i = 0; $i < count($oldOrder['points']); $i ++) {
            $oldPoints .= $oldOrder['points'][$i]['address'] . '|';
        }
        
        $oldPoints = rtrim($oldPoints, '|');
        
        $newPoints = '';
        for ($i = 0; $i < count($newOrder['point']); $i ++) {
            $newPoints .= $newOrder['point'][$i]['S'] . ', ' . $newOrder['point'][$i]['N'] . '|';
        }
        
        $newPoints = rtrim($newPoints, '|');
        
        $db = $this->getDbCentral();
        $db->update('order_cl_info', array(
            'phone' => $newOrder['customerPhone'],
            'name' => $newOrder['customerName']
        ), "`order_id` = " . $newOrder['orderId']);
        
        $payment = isset($newOrder['nonCashPayment']) ? 'non_cash_payment_tarif' : 'cash_payment_tarif';
        
        $calculate = $this->calculate($newOrder);
        // print_r($calculate);
        
        $db->update('order_info', array(
            // 'type' => $type,
            'payment' => $payment,
            'tarif_id' => $calculate['costInfo']['tarif']['type'],
            'tarif' => isset($calculate['costInfo']['tarif']) ? json_encode($calculate['costInfo']['tarif']) : '',
            'length' => isset($calculate['costInfo']['length']) ? $calculate['costInfo']['length'] : '',
            'cost' => isset($calculate['costInfo']['cost']) ? $calculate['costInfo']['cost'] : '',
            'driver_note' => $newOrder['driverNote'],
            'dispatcher_note' => $newOrder['dispatcherNote']
        ), "`order_id` = " . $newOrder['orderId']);
        
        $db->update('order_properties', array(
            'airCondition' => isset($newOrder['addService']['airCondition']) ? 1 : 0,
            'salonLoading' => isset($newOrder['addService']['salonLoading']) ? 1 : 0,
            'animal' => isset($newOrder['addService']['animal']) ? 1 : 0,
            'city' => isset($newOrder['city']) ? 1 : 0,
            'courierDelivery' => isset($newOrder['addService']['courierDelivery']) ? 1 : 0,
            'terminal' => isset($newOrder['terminal']) ? 1 : 0,
            'nameSign' => isset($newOrder['addService']['nameSign']) ? 1 : 0,
            'hour' => isset($newOrder['hour']) ? 1 : 0,
            'grach' => isset($newOrder['grach']) ? 1 : 0,
            'ticket' => isset($newOrder['ticket']) ? 1 : 0
        ), "`order_id` = " . $newOrder['orderId']);
        
        $db->delete('order_points', "`order_id` = " . $newOrder['orderId']);
        for ($i = 0, $pointCount = count($newOrder['point']); $i < $pointCount; $i ++) {
            $db->insert('order_points', array(
                'order_id' => $newOrder['orderId'],
                'point_id' => $i,
                'point' => $newOrder['point'][$i]['S'] . ', ' . $newOrder['point'][$i]['N'],
                'location' => json_encode($calculate['costInfo']['points_loc'][$i])
            ));
        }
        
        $db->update('order_start_point', array(
            'address' => isset($newOrder['addr']) ? $newOrder['addr'] : '',
            'apartment' => $newOrder['apartment'],
            'porch' => $newOrder['porch']
        ), "`order_id` = " . $newOrder['orderId']);
        
        $db->update('order_time', array(
            'update' => date('Y-m-d H:i:s')
        ), "`order_id` = " . $newOrder['orderId']);
    }

    public function addDriverToSentList($orderId, $driverId)
    {
        $db = $this->getDbCentral();
        
        $driverSent = $this->getDriverOrderSentList($orderId);
        
        if (empty($driverSent)) {
            if (is_array($driverId))
                if (is_array($driverSent))
                    $driverSent = array_merge($driverSent, $driverId);
                else
                    $driverSent = $driverId;
            else
                $driverSent[] = $driverId;
        } else {
            if (is_array($driverId))
                $driverSent = array_merge($driverSent, $driverId);
            else
                $driverSent[] = $driverId;
        }
        
        $driverSent = array_unique($driverSent);
        sort($driverSent);
        $db->update('order_sent', array(
            'driver_ids' => json_encode($driverSent)
        ), "`order_id` = " . $orderId);
    }

    public function getDriverOrderSentList($orderId)
    {
        $db = $this->getDbCentral();
        
        $row = $db->select('SELECT driver_ids FROM order_sent WHERE order_id = :orderId', array(
            ':orderId' => $orderId
        ));
        
        if (empty($row) || $row[0]['driver_ids'] == '[null]' || empty($row[0]['driver_ids']))
            return false;
        $driverIds = json_decode($row[0]['driver_ids']);
        
        return (array) $driverIds;
    }

    private function addDriverToRefusedList($orderId, $driverId)
    {
        $db = $this->getDbCentral();
        
        $driverRefused = $this->getDriverOrderRefusedList($orderId);
        
        if ($driverRefused) {
            if (! in_array($driverId, $driverRefused)) {
                $driverRefused[] = $driverId;
            }
        } else {
            $driverRefused = array(
                $driverId
            );
        }
        $db->update('order_sent', array(
            'driver_refused' => json_encode($driverRefused)
        ), "`order_id` = " . $orderId);
    }

    public function getDriverOrderRefusedList($orderId)
    {
        $db = $this->getDbCentral();
        
        $row = $db->select('SELECT driver_refused FROM order_sent WHERE order_id = :orderId', array(
            ':orderId' => $orderId
        ));
        if ($row[0]['driver_refused'] == '[null]')
            return false;
        $driverIds = json_decode($row[0]['driver_refused']);
        
        return $driverIds;
    }

    public function formOrderSendDriverList($availableDrivers, $refusedDrivers)
    {
        if (! $refusedDrivers)
            return $availableDrivers;
        
        for ($i = 0, $available = count($availableDrivers); $i < $available; $i ++) {
            for ($j = 0, $refused = count($refusedDrivers); $j < $refused; $j ++) {
                if ($availableDrivers[$i] == $refusedDrivers[$j]) {
                    unset($availableDrivers[$i]);
                    break;
                }
            }
        }
        
        return $availableDrivers;
    }

    public function getOrderById($id)
    {
        $db = $this->getDbCentral();
        
        $order['properties'] = $db->select('SELECT
                    order_list.id AS orderId,
                    order_list.dispatcher AS dispatcher,
                    order_list.driver AS driver,
                    order_list.customer AS customer,
                    taxi_driver_info.callsign AS callsign,
                    order_cl_info.name AS customerName,
                    order_cl_info.phone AS customerPhone,
                    order_info.cost AS cost,
                    order_info.payment,
                    order_info.tarif_id,
                    order_info.length,
                    order_info.dispatcher_note,
                    order_info.tarif_id,
                    order_properties.airCondition,
                    order_properties.salonLoading,
                    order_properties.animal,
                    order_properties.city,
                    order_properties.courierDelivery,
                    order_properties.terminal,
                    order_properties.namesign,
                    order_properties.hour,
                    order_properties.grach,
                    order_properties.ticket,
                    order_start_point.apartment,
                    order_start_point.porch,
                    order_status.status,
                    order_time.add AS createDatetime,
                    order_time.take AS takeDatetime,
                    order_time.arrive AS arriveDatetime
                FROM order_list
                LEFT OUTER JOIN taxi_driver_info ON order_list.driver = taxi_driver_info.id
                LEFT OUTER JOIN order_cl_info ON order_list.id = order_cl_info.order_id
                LEFT OUTER JOIN order_info ON order_list.id = order_info.order_id
                LEFT OUTER JOIN order_status ON order_list.id = order_status.order_id
                LEFT OUTER JOIN order_properties ON order_list.id = order_properties.order_id
                LEFT OUTER JOIN order_start_point ON order_list.id = order_start_point.order_id
                LEFT OUTER JOIN order_time ON order_list.id = order_time.order_id            	
            WHERE order_list.id = :id', array(
            ':id' => $id
        ));
        
        if (empty($order['properties']))
            return false;
        
        $points = $db->select('SELECT
				point_id AS id,
				point AS address,
				location AS location
			FROM
				order_points
			WHERE
				order_id = :id', array(
            ':id' => $id
        ));
        
        $driver = $db->select('SELECT driver FROM order_list WHERE id = :id', array(
            ':id' => $id
        ));
        
        $startPoint = $db->select('SELECT apartment, porch FROM order_start_point WHERE order_id = :id', array(
            ':id' => $id
        ));
        if ($startPoint) {
            if (! empty($startPoint[0]['porch']))
                $points[0]['address'] .= ', подъезд ' . $startPoint[0]['porch'];
            if (! empty($startPoint[0]['apartment']))
                $points[0]['address'] .= ', квартира ' . $startPoint[0]['apartment'];
        }
        
        for ($i = 0, $pointsCount = count($points); $i < $pointsCount; $i ++) {
            $location = json_decode($points[$i]['location']);
            
            if (! empty($location)) {
                $points[$i]['longitude'] = $location->lng;
                $points[$i]['latitude'] = $location->lat;
                unset($points[$i]['location']);
            }
        }
        
        $order['points'] = ! empty($points) ? $points : null;
        $order['startPoint'] = $points[0]['address'];
        $order['driver'] = $driver[0]['driver'];
        
        return $order;
    }

    public function getOrderListJSON(array $status, $personal = null, $offsetVal = null, $limitVal = null, $sortField = 'id', $sortDir = 'DESC', $filter = null)
    {
        $status = implode(',', $status);
        
        $db = $this->getDbCentral();
        
        if (isset($this->sortableFields[$sortField]))
            $orderBy = $this->sortableFields[$sortField];
        else
            $orderBy = $this->sortableFields['default'];
        
        if ($sortDir == 'ASC' || $sortDir == 'DESC')
            $orderBy .= " $sortDir";
        else {
            $orderBy .= " DESC";
        }
        
        $filterString = '';
        
        if ($filter != null) {
            if (isset($filter['callsign'])) {
                $filterString .= ' AND taxi_driver_info.callsign = ' . (int) $filter['callsign'];
            }
            
            if (isset($filter['createDatetime']['from']) && isset($filter['createDatetime']['to'])) {
                $filterString .= ' AND order_time.add BETWEEN \'' . date('Y-m-d H:i:s', $filter['createDatetime']['from']) . '\' AND \'' . date('Y-m-d H:i:s', $filter['createDatetime']['to']) . '\'';
            }
            if (isset($filter['arriveDatetime']['from']) && isset($filter['arriveDatetime']['to'])) {
                $filterString .= ' AND order_time.arrive BETWEEN \'' . date('Y-m-d H:i:s', $filter['arriveDatetime']['from']) . '\' AND \'' . date('Y-m-d H:i:s', $filter['arriveDatetime']['to']) . '\'';
            }
            if (isset($filter['finishDatetime']['from']) && isset($filter['finishDatetime']['to'])) {
                $filterString .= ' AND order_time.finish BETWEEN \'' . date('Y-m-d H:i:s', $filter['finishDatetime']['from']) . '\' AND \'' . date('Y-m-d H:i:s', $filter['finishDatetime']['to']) . '\'';
            }
            if (isset($filter['tarif_id'])) {
                if (is_array($filter['tarif_id'])) {
                    $filterTarifString = ' AND order_info.tarif_id IN (';
                    for ($i = 0, $tarifCnt = count($filter['tarif_id']); $i < $tarifCnt; $i ++) {
                        $filterTarifString .= $filter['tarif_id'][$i] . ',';
                    }
                    $filterTarifString = rtrim($filterTarifString, ',');
                    $filterTarifString .= ')';
                    $filterString .= $filterTarifString;
                }
            }

            if (isset($filter['cost'])) {
                $filterString .= ' AND order_info.cost = ' . (int) $filter['cost'];
            }

            if (isset($filter['clientPhone'])) {
                $filterString = " AND order_cl_info.phone LIKE '%{$filter['clientPhone']}%'";
            }

            if (isset($filter['dispatcherId'])) {
                $filterString = " AND order_list.dispatcher = {$filter['dispatcherId']}";
            }

            if (isset($filter['length'])) {
                $filterString = 'AND order_info.length = ' . (float)$filter['length'];
            }

            if (isset($filter['firstPoint']) && ! empty($filter['firstPoint'])) {
                $orderIds = $db->select("SELECT order_id AS id FROM order_points WHERE point LIKE '%" . $filter['firstPoint'] . "%' AND point_id = 0");
                if (! empty($orderIds)) {
                    $firstPointIds = array();
                    for ($i = 0, $idsCnt = count($orderIds); $i < $idsCnt; $i ++) {
                        $firstPointIds[] = $orderIds[$i]['id'];
                    }
                } else {
                    $result['orderList'] = array();
                    $result['count'] = 0;
                    return $result;
                }
            }
            
            if (isset($filter['lastPoint']) && ! empty($filter['lastPoint'])) {
                $orderLastPointIds = $db->select("SELECT order_id AS id FROM order_points FIRST WHERE point LIKE '%" . $filter['lastPoint'] . "%' AND point_id = (SELECT COUNT( point_id ) - 1 FROM order_points SECOND WHERE SECOND.order_id = FIRST.order_id )");
                if (! empty($orderLastPointIds)) {
                    $lastPointIds = array();
                    for ($i = 0, $idsCnt = count($orderLastPointIds); $i < $idsCnt; $i ++) {
                        $lastPointIds[] = $orderLastPointIds[$i]['id'];
                    }
                } else {
                    $result['orderList'] = array();
                    $result['count'] = 0;
                    return $result;
                }
            }
            
            if (isset($filter['driverNote'])) {
                $filterString .= " AND order_info.driver_note LIKE '%" . $filter['driverNote'] . "%'";
            }
            
            if (isset($filter['dispatcherNote'])) {
                $filterString .= " AND order_info.dispatcher_note LIKE '%" . $filter['dispatcherNote'] . "%'";
            }
            
            if (isset($firstPointIds) && isset($lastPointIds)) {
                $ids = array();
                for ($i = 0, $firstCnt = count($firstPointIds); $i < $firstCnt; $i ++) {
                    for ($j = 0, $lastCnt = count($lastPointIds); $j < $lastCnt; $j ++) {
                        if ($firstPointIds[$i] == $lastPointIds[$j]) {
                            $ids[] = $firstPointIds[$i];
                        }
                    }
                }
                
                $filterString .= ' AND order_list.id IN (' . implode(',', $ids) . ')';
            } else {
                if (isset($firstPointIds)) {
                    $filterString .= ' AND order_list.id IN (' . implode(',', $firstPointIds) . ')';
                } elseif (isset($lastPointIds)) {
                    $filterString .= ' AND order_list.id IN (' . implode(',', $lastPointIds) . ')';
                }
            }
        }
        
        $limit = '';
        
        if ($offsetVal !== null) {
            $limit = " LIMIT $offsetVal";
            if ($limitVal !== null) {
                $limit .= ",$limitVal";
            }
            
            $orderListCount = $db->select("SELECT
                COUNT(order_list.id)
                FROM order_list
                LEFT OUTER JOIN taxi_driver_info ON order_list.driver = taxi_driver_info.id
                LEFT OUTER JOIN order_cl_info ON order_list.id = order_cl_info.order_id
                LEFT OUTER JOIN order_info ON order_list.id = order_info.order_id
                LEFT OUTER JOIN order_status ON order_list.id = order_status.order_id
                LEFT OUTER JOIN order_properties ON order_list.id = order_properties.order_id
                LEFT OUTER JOIN order_time ON order_list.id = order_time.order_id
                WHERE order_status.status
                IN ($status) $filterString");
            
            $result['count'] = $orderListCount[0]['COUNT(order_list.id)'];
        }
        
        $orderList = $db->select("SELECT
                order_list.id AS orderId,
                order_list.driver AS driverId,
                order_list.dispatcher AS dispatcherId,
                taxi_driver_info.callsign AS callsign,
                order_cl_info.name AS customerName,
                order_cl_info.phone AS customerPhone,
                order_info.cost AS cost,
                order_info.payment,
                order_info.tarif_id,
                order_info.length,
                order_info.dispatcher_note,
                order_info.driver_note,
                order_info.tarif_id,
                order_properties.airCondition,
                order_properties.salonLoading,
                order_properties.animal,
                order_properties.city,
                order_properties.courierDelivery,
                order_properties.terminal,
                order_properties.namesign,
                order_properties.hour,
                order_properties.grach,
                order_properties.ticket,
                order_status.status,
                order_start_point.address,
                order_start_point.apartment,
                order_start_point.porch,
                order_time.add AS createDatetime,
                order_time.take AS takeDatetime,
                order_time.arrive AS arriveDatetime,
                order_time.finish AS finishDatetime
            FROM order_list
            LEFT OUTER JOIN taxi_driver_info ON order_list.driver = taxi_driver_info.id
            LEFT OUTER JOIN order_cl_info ON order_list.id = order_cl_info.order_id
            LEFT OUTER JOIN order_info ON order_list.id = order_info.order_id
            LEFT OUTER JOIN order_status ON order_list.id = order_status.order_id
            LEFT OUTER JOIN order_start_point ON order_list.id = order_start_point.order_id
            LEFT OUTER JOIN order_properties ON order_list.id = order_properties.order_id
            LEFT OUTER JOIN order_time ON order_list.id = order_time.order_id
        WHERE order_status.status
        IN ($status) $filterString $orderBy $limit");
        
        for ($i = 0, $orderCnt = count($orderList); $i < $orderCnt; $i ++) {
            $orderList[$i]['points'] = $this->getOrderPoints($orderList[$i]['orderId']);
            
            for ($j = 0, $pointCnt = count($orderList[$i]['points']); $j < $pointCnt; $j ++) {
                $orderList[$i]['points'][$j]['point'] = array(
                    'street' => substr($orderList[$i]['points'][$j]['point'], 0, strpos($orderList[$i]['points'][$j]['point'], ',')),
                    'number' => trim(substr($orderList[$i]['points'][$j]['point'], strpos($orderList[$i]['points'][$j]['point'], ',') + 1))
                );
                
                if (! empty($orderList[$i]['points'][$j]['location']))
                    $orderList[$i]['points'][$j]['location'] = json_decode($orderList[$i]['points'][$j]['location']);
                else {
                    $location = new StdClass();
                    $location->lat = '';
                    $location->lng = '';
                    
                    $orderList[$i]['points'][$j]['location'] = $location;
                }
            }
        }
        
        $result['orderList'] = $orderList;
        
        return $result;
    }

    public function getTarifTypes()
    {
        $db = $this->getDbCentral();
        return $db->select("SELECT id, type FROM taxi_car_type");
    }

    public function getTarif($type = 6)
    {
        $db = $this->getDbCentral();
        return $db->select("SELECT fluidTarification, extraCost, fluidTarifMin, kmMin, downtime, hourTarif, minHourTarif, ootOneWayTarif, ootTnbTarif FROM cash_payment_tarif WHERE type = $type");
    }

    public function getOrderList($status, $personal = false)
    {
        $db = $this->getDbCentral();
        if ($personal == null)
            $personal = '';
        elseif ($personal)
            $personal = ' AND order_status.personal = 1 ';
        else
            $personal = ' AND order_status.personal = 0 ';
        if (is_array($status)) {
            $status = implode(', ', $status);
            return $db->select("SELECT order_list.id AS orderId, taxi_driver_info.callsign AS callsign, order_cl_info.name AS name, order_cl_info.phone AS phone, order_info.cost AS cost, (
				SELECT GROUP_CONCAT( order_points.point
				ORDER BY order_points.point_id
				SEPARATOR '|' )
				FROM order_points
				WHERE order_points.order_id = order_list.id
				) AS points, order_status.status
				FROM order_list
				LEFT OUTER JOIN taxi_driver_info ON order_list.driver = taxi_driver_info.id
				LEFT OUTER JOIN order_cl_info ON order_list.id = order_cl_info.order_id
				LEFT OUTER JOIN order_info ON order_list.id = order_info.order_id
				LEFT OUTER JOIN order_status ON order_list.id = order_status.order_id
				WHERE order_status.status
				IN ($status) $personal");
        }
    }

    public function getOrderPoints($orderId)
    {
        $db = $this->getDbCentral();
        
        $points = $db->select('SELECT point_id, point, location FROM order_points WHERE order_id = :orderId', array(
            ':orderId' => $orderId
        ));
        return $points;
    }

    public function orderRun($id, $driverId)
    {
        $db = $this->getDbCentral();
        $order = $db->select('SELECT id, status, driver FROM order_list WHERE id = :id AND driver = :driverId AND status = 1', array(
            ':id' => $id,
            ':driverId' => $driverId
        ));
        if (! empty($order)) {
            $db->update('order_list', array(
                'status' => 2,
                'start_time' => date('Y-m-d H:i:s')
            ), "`id` = $id");
            
            $db->update('taxi_status', array(
                'status' => 2
            ), "`id` = $driverId");
            return true;
        }
        return false;
    }

    public function orderComplete($id, $driverId = null, $date = '', $orderStatus = 9, $locationTrack = null)
    {
        $db = $this->getDbCentral();
        
        if ($locationTrack != null) {
            $pointsArray = $locationTrack->pointsArray;
            
            $pointsCnt = count($pointsArray);
            
            for ($i = 0; $i < $pointsCnt; $i ++) {
                $pointsArray[$i]->logDateTime = $this->makeUnixDateTime($pointsArray[$i]->logDateTime);
            }
            
            for ($i = 0; $i < $pointsCnt; $i ++) {
                $min = $i;
                for ($j = $i + 1; $j < $pointsCnt; $j ++) {
                    if ($pointsArray[$j]->logDateTime < $pointsArray[$min]->logDateTime) {
                        $min = $j;
                    }
                }
                
                $temp = $pointsArray[$i];
                $pointsArray[$i] = $pointsArray[$min];
                $pointsArray[$min] = $temp;
            }
            
            $path = '';
            for ($i = 1; $i < $pointsCnt - 1; $i ++) {
                $path .= $pointsArray[$i]->latitude . ',' . $pointsArray[$i]->longitude . '|';
            }
            $path = rtrim($path, '|');
            
            $startPoint = $pointsArray[0]->latitude . ',' . $pointsArray[0]->longitude;
            $destination = $pointsArray[$pointsCnt - 1]->latitude . ',' . $pointsArray[$pointsCnt - 1]->longitude;
            
            $ch = curl_init();
            
            curl_setopt($ch, CURLOPT_URL, "http://maps.googleapis.com/maps/api/directions/json?origin=$startPoint&destination=$destination&waypoints=$path&units=metric&mode=driving&sensor=false");
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            
            $result = json_decode(curl_exec($ch), true);
            curl_close($ch);
            
            $order = $this->getOrderById($id);
            
            $length = 0;
            
            foreach ($result['routes'][0]['legs'] as $leg) {
                $length += $leg['distance']['value'];
                $points_loc[] = (array) $leg['start_location'];
            }
            
            // $points_loc[] = (array) $result['routes'][0]['legs'][count($result['routes'][0]['legs']) - 1]['end_location'];
            
            // $qwe = array(
            // 'pointsLoc' => $points_loc,
            // 'length' => $length
            // );
            
            // echo json_encode(array(
            // 'error' => $qwe
            // ));
            // die();
            
            // $payment = isset($order['nonCashPayment']) ? 'non_cash_payment_tarif' : 'cash_payment_tarif';
            $tarif = $tarif = $db->select('SELECT * FROM ' . $order['properties'][0]['payment'] . ' WHERE type = ' . $order['properties'][0]['tarif_id']);
            
            $cost = 0;
            
            if ($length <= $tarif[0]['kmMin']) {
                $cost += $tarif[0]['fluidTarifMin'];
            } else {
                $dif = $length - $tarif[0]['kmMin'];
                $cost += $tarif[0]['fluidTarifMin'] + ($dif / 1000) * $tarif[0]['fluidTarification'];
            }
            
            // $cost += $this->getAdditionalOrderCost($order, 1, $cost);
            
            // $cost += $this->getAdditionalOrderCost($order, $pointsCount, $cost);
            
            $model = new Application_Model_Tariffication();
            
            $commonTariff = $model->getCommonTariffication();
            $additionalTariff = $model->getAdditionalServices();
            
            $extraCost = 0;
            
            if ($order['properties'][0]['payment'] == 'non_cash_payment')
                $extraCost += ($cost / 100) * $commonTariff->nonCash->value;
                
                // if ($pointCount > $commonTariff->eachPointExtra->point) {
                // $extraCost += ($pointCount - $commonTariff->eachPointExtra->point) * $commonTariff->eachPointExtra->value;
                // }
            
            if ($order['properties'][0]['grach'] == true && $commonTariff->grach->active == true) {
                if ($commonTariff->grach->type == 'UAH')
                    $extraCost += $commonTariff->grach->value;
                if ($commonTariff->grach->type == 'CNT')
                    $extraCost += ($cost / 100) * $commonTariff->grach->value;
            }
            
            if ($commonTariff->snowExtra->active == true) {
                if ($commonTariff->snowExtra->type == 'UAH')
                    $extraCost += $commonTariff->snowExtra->value;
                if ($commonTariff->snowExtra->type == 'CNT')
                    $extraCost += ($cost / 100) * $commonTariff->snowExtra->value;
            }
            
            for ($j = 0, $addTariffCnt = count($additionalTariff); $j < $addTariffCnt; $j ++) {
                if (array_key_exists($additionalTariff[$j]['name'], $order['properties'][0])) {
                    if ($additionalTariff[$j]['type'] == 'UAH')
                        $extraCost += $additionalTariff[$j]['value'];
                    if ($additionalTariff[$j]['type'] == 'CNT')
                        $extraCost += ($cost / 100) * $additionalTariff[$j]['value'];
                    
                    break;
                }
            }
            
            $cost += $extraCost;
            
            $cost = round($cost, 0);
            
            $ch = curl_init();
            
            curl_setopt($ch, CURLOPT_URL, 'http://maps.googleapis.com/maps/api/geocode/json?address=' . $points_loc[count($points_loc) - 1]['lat'] . ',' . $points_loc[count($points_loc) - 1]['lng'] . '&sensor=false&language=ru');
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            
            $lastPointInfo = json_decode(curl_exec($ch), true);
            curl_close($ch);
            
            $streetName = $lastPointInfo['results'][0]['address_components'][1]['short_name'];
            $streetNum = $lastPointInfo['results'][0]['address_components'][0]['short_name'];
            
            $db->update('order_info', array(
                'cost' => $cost,
                'length' => $length
            ), "`order_id` = $id");
            
            // echo json_encode(array(
            // 'error' => $lastPointInfo['results'][0]['address_components'][0]
            // ));
        }
        
        // echo json_encode(array(
        // 'error' => $locationTrack
        // ));
        // return;
        
        $db->update('order_status', array(
            'status' => $orderStatus
        ), "`order_id` = $id");
        
        $db->update('order_time', array(
            'finish' => ! empty($date) ? $date : date('Y-m-d H:i:s')
        ), "`order_id` = $id");
        
        if ($driverId != null) {
            $db->update('taxi_status', array(
                'status' => 1,
                'status_update' => $date
            ), "`taxi_id` = $driverId");
        }
        
        if (isset($cost)) {
            return $cost;
        }
        
        return true;
    }

    public function removeOrder($id)
    {
        $db = $this->getDbCentral();
        $db->update('order_list', array(
            'status' => 5,
            'finish_time' => date('Y-m-d H:i:s')
        ), "`id` = $id");
    }

    public function takeOrder($driverId, $password, $sessionId, $orderId, $arriveMinutes = 10)
    {
        try {
            $db = $this->getDbCentral();
            
            $db->update('order_status', array(
                'status' => 7
            ), "`order_id` = $orderId");
            $arrive = date("Y-m-d H:i:s", time() + $arriveMinutes * 60);
            $db->update('order_time', array(
                'take' => date('Y-m-d H:i:s'),
                'arrive' => $arrive
            ), "`order_id` = $orderId");
            
            $db->update('taxi_status', array(
                'status' => 2
            ), "`taxi_id` = $driverId");
            $db->update('order_list', array(
                'driver' => $driverId
            ), "`id` = " . $orderId);
            
            $driverOrderSent = $this->getDriverOrderSentList($orderId);
            $driverModel = new Application_Model_Driver();
            
            $drivers = $driverModel->getPushRegistrationId($driverOrderSent);
            
            $order = $this->getOrderById($orderId);
            
            if ($driverOrderSent > 0 && $drivers != false) {
                if (count($drivers) > 0) {
                    $push = new Lib_Push_GCM();
                    
                    $regIds = array();
                    $driverIds = array();
                    foreach ($drivers as $driver) {
                        if ($driverId != $driver['id']) {
                            $regIds[] = $driver['g_reg_id'];
                            $driverIds[] = $driver['id'];
                        }
                    }
                    
                    $message1003 = array(
                        "messageType" => 1003,
                        "orderId" => $orderId
                    );
                    
                    $pushResult = $push->sendNotification($regIds, $message1003);
                    
                    $db->insert('push', array(
                        'drivers' => json_encode($driverIds),
                        'order_id' => $orderId,
                        'message' => json_encode($message1003),
                        'date' => date('Y-m-d H:i:s'),
                        'result' => $pushResult
                    ));
                }
            }
            return true;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function cancelOrder($driverId, $password, $sessionId, $orderId)
    {
        try {
            $db = $this->getDbCentral();
            $db->update('taxi_status', array(
                'status' => 1
            ), "`taxi_id` = $driverId");
            
            $order = $this->getOrderById($orderId);
            
            $orderStatus = $this->getOrderStatus($orderId);
            if ($orderStatus == 9 && $orderStatus != 6)
                return true;
            
            $push = new Lib_Push_GCM();
            $driverModel = new Application_Model_Driver();
            $callsigns = $driverModel->findDriver($order['points'][0]['latitude'], $order['points'][0]['longitude'], $driverId, false);
            
            $drivers = $driverModel->getDriverByCallsign($callsigns);
            
            $this->addDriverToRefusedList($orderId, $driverId);
            
            if (! empty($drivers)) {
                $driverIds = array();
                foreach ($drivers as $driver) {
                    $driverIds[] = $driver['id'];
                    $driverClsngs[$driver['id']] = $driver['callsign'];
                }
                
                $refusedDrivers = $this->getDriverOrderRefusedList($orderId);
                
                $availableDrivers = $this->formOrderSendDriverList($driverIds, $refusedDrivers);
                
                $flag = false;
                if (count($availableDrivers) > 0) {
                    if ($flag)
                        break;
                    for ($i = 0, $callsignsCount = count($callsigns); $i < $callsignsCount; $i ++) {
                        if ($flag)
                            break;
                        foreach ($driverClsngs as $k => $v) {
                            if ($flag)
                                break;
                            if ($callsigns[$i] == $v) {
                                if (in_array($k, $availableDrivers)) {
                                    $driver = $driverModel->getDriverByCallsign($v);
                                    if (! empty($driver)) {
                                        $driverModel->setDriverStatus($driver[0]['id'], 'BUSY');
                                        $this->setOrderDriver($orderId, $driver[0]['id']);
                                        $message = $this->createOrderPushMessage($orderId, 1001);
                                        $pushResult = $push->sendNotification(array(
                                            $driver[0]['g_reg_id']
                                        ), $message);
                                    }
                                    $flag = true;
                                }
                            }
                        }
                    }
                } else {
                    $drivers = $driverModel->getPushRegistrationId(null, 1, null);
                    
                    if (! empty($drivers)) {
                        foreach ($drivers as $driver) {
                            $regIds[] = $driver['g_reg_id'];
                            $driverIds[] = $driver['id'];
                        }
                        $this->setOrderDriver($orderId, '');
                        if (count($driverIds) > 0) {
                            $message = $this->createOrderPushMessage($orderId, 1002);
                            
                            $regIds = array_unique($regIds);
                            sort($regIds);
                            
                            $pushResult = $push->sendNotification($regIds, $message);
                            
                            $db = $this->getDbCentral();
                            $db->insert('push', array(
                                'drivers' => json_encode($driverIds),
                                'order_id' => $orderId,
                                'message' => json_encode($message),
                                'date' => date('Y-m-d H:i:s'),
                                'result' => $pushResult
                            ));
                            
                            $this->addDriverToSentList($orderId, $driverIds);
                        }
                    }
                }
            } else {
                $drivers = $driverModel->getPushRegistrationId(null, 1, null);
                
                if (! empty($drivers)) {
                    foreach ($drivers as $driver) {
                        $regIds[] = $driver['g_reg_id'];
                        $driverIds[] = $driver['id'];
                    }
                    
                    if (count($driverIds) > 0) {
                        $message = $this->createOrderPushMessage($orderId, 1002);
                        
                        $regIds = array_unique($regIds);
                        sort($regIds);
                        $this->setOrderDriver($orderId, '');
                        $pushResult = $push->sendNotification($regIds, $message);
                        
                        $db = $this->getDbCentral();
                        $db->insert('push', array(
                            'drivers' => json_encode($driverIds),
                            'order_id' => $orderId,
                            'message' => json_encode($message),
                            'date' => date('Y-m-d H:i:s'),
                            'result' => $pushResult
                        ));
                        
                        $this->addDriverToSentList($orderId, $driverIds);
                    }
                }
            }
            return true;
        } catch (Exception $e) {}
    }

    public function closeOrder($orderId, $reasonId, $params)
    {
        $order = $this->getOrderById($orderId);
        if ($order && ! in_array($order['properties'][0]['status'], $this->orderClosedStatus)) {
            $db = $this->getDbCentral();
            $driverModel = new Application_Model_Driver();
            $driver = $driverModel->getDriverByCallsign($params['callsign']);
            
            $datetime = isset($params['datetime']) ? date('Y-m-d H:i:s', $params['datetime']) : date('Y-m-d H:i:s');
            
            switch ($reasonId) {
                case 1:
                    if (empty($params['callsign']))
                        return false;
                        break;
                    if (!empty($driver)) {
                        $db->update('order_list', array(
                            'driver' => $driver[0]['id']
                        ), "`id` = $orderId");
                        
                        $db->update('order_status', array(
                            'status' => 9
                        ), "`order_id` = $orderId");
                    }
                    return true;
                    break;
                case 2:
                    $db->update('order_status', array(
                        'status' => 24
                    ), "`order_id` = $orderId");
                    break;
                case 3:
                    $db->update('order_status', array(
                        'status' => 26
                    ), "`order_id` = $orderId");
            }
            $db->update('order_time', array(
                'finish' => $datetime
            ), "`order_id` = $orderId");
        }
    }

    public function orderExists($orderId, $status = null)
    {
        $db = $this->getDbCentral();
        
        if ($status != null) {
            $order = $db->select('SELECT order_list.id, order_status.status FROM order_list INNER JOIN order_status WHERE order_list.id = :id AND order_status.order_id = :id AND order_status.status = :status', array(
                ':id' => $orderId,
                ':status' => $status
            ));
        } else {
            $order = $db->select('SELECT id FROM order_list WHERE id = :id', array(
                ':id' => $orderId
            ));
        }
        
        if (count($order) > 0)
            return true;
        else
            return false;
    }

    public function setOrderStatus($orderId, $status)
    {
        $db = $this->getDbCentral();
        
        $result = $db->update('order_status', array(
            'status' => $status
        ), "`order_id` = $orderId");
        return $result;
    }

    public function getOrderStatus($orderId)
    {
        $db = $this->getDbCentral();
        
        $result = $db->select('SELECT status FROM order_status WHERE order_id = :orderId', array(
            ':orderId' => $orderId
        ));
        if (count($result) == 1) {
            return $result[0]['status'];
        }
        return false;
    }

    public function setOrderEditMark($orderId, $mark)
    {
        $db = $this->getDbCentral();
        
        $result = $db->update('order_status', array(
            'editing' => $mark
        ), "`order_id` = $orderId");
        return $result;
    }

    public function getOrderEditMark($orderId)
    {
        $db = $this->getDbCentral();
        
        $result = $db->select('SELECT editing, dispatcher FROM order_status WHERE order_id = :orderId', array(
            ':orderId' => $orderId
        ));
        return $result[0];
    }

    public function setOrderEditTime($orderId)
    {
        $db = $this->getDbCentral();
        
        $result = $db->update('order_status', array(
            'open_for_edit_time' => date('Y-m-d H:i:s')
        ), "`order_id` = $orderId");
        return $result;
    }

    public function getOrderEditTime($orderId)
    {
        $db = $this->getDbCentral();
        
        $result = $db->select('SELECT open_for_edit_time AS time FROM order_status WHERE order_id = :orderId', array(
            'orderId' => $orderId
        ));
        return $result[0]['time'];
    }

    public function createOrderPushMessage($orderId, $messageType = null)
    {
        $order = $this->getOrderById($orderId);
        
        $message = array(
            "order" => array(
                "id" => $order['properties'][0]['orderId'],
                "clientName" => isset($order['properties'][0]['customerName']) ? $order['properties'][0]['customerName'] : '',
                "clientPhone" => isset($order['properties'][0]['customerName']) ? $order['properties'][0]['customerPhone'] : '',
                "clientId" => '',
                "price" => $order['properties'][0]['cost'],
                "isReservation" => isset($order['properties'][0]['reservation']) ? true : false,
                "isCashless" => isset($order['properties'][0]['nonCashPayment']) ? true : false,
                "points" => $order['points']
            )
        );
        
        if ($messageType != null)
            $message['messageType'] = $messageType;
        
        if (isset($order['properties'][0]['airCondition']) && $order['properties'][0]['airCondition'] == 1)
            $message["order"]["extras"][]["name"] = 'AIR_CONDITIONING';
        if (isset($order['properties'][0]['salonLoading']) && $order['properties'][0]['salonLoading'] == 1)
            $message["order"]["extras"][]["name"] = 'SALON_LOADING';
        if (isset($order['properties'][0]['animal']) && $order['properties'][0]['animal'] == 1)
            $message["order"]["extras"][]["name"] = 'ANIMAL';
        if (isset($order['properties'][0]['city']) && $order['properties'][0]['city'] == 1)
            $message["order"]["extras"][]["name"] = 'CITY';
        if (isset($order['properties'][0]['courierDelivery']) && $order['properties'][0]['courierDelivery'] == 1)
            $message["order"]["extras"][]["name"] = 'COURIER_DELIVERY';
        if (isset($order['properties'][0]['terminal']) && $order['properties'][0]['terminal'] == 1)
            $message["order"]["extras"][]["name"] = 'TERMINAL';
        if (isset($order['properties'][0]['nameSign']) && $order['properties'][0]['nameSign'] == 1)
            $message["order"]["extras"][]["name"] = 'NAME_SIGN';
        if (isset($order['properties'][0]['hour']) && $order['properties'][0]['hour'] == 1)
            $message["order"]["extras"][]["name"] = 'HOUR';
        if (isset($order['properties'][0]['grach']) && $order['properties'][0]['grach'] == 1)
            $message["order"]["extras"][]["name"] = 'GRACH';
        if (isset($order['properties'][0]['ticket']) && $order['properties'][0]['ticket'] == 1)
            $message["order"]["extras"][]["name"] = 'TICKET';
        
        $message["order"]["tariff"] = 'ТАРИФ'; // $calculate['name'];
        $message["order"]["GPRSmessage"] = 'GPRS message'; // $calculate['name'].' '.$order['gprsNotes'].' '.$order['driverNote'];
        
        return $message;
    }

    public function checkOrderTime($status)
    {
        $db = $this->getDbCentral();
        $date = date('Y-m-d H:i:s');
        
        $select = "SELECT order_list.id AS orderId, order_time.add AS createTime, order_status.status AS status	FROM order_list LEFT OUTER JOIN order_time ON order_time.order_id = order_list.id LEFT OUTER JOIN order_status ON order_status.order_id = order_list.id WHERE (UNIX_TIMESTAMP('$date') - UNIX_TIMESTAMP(order_time.add)) >= 600 AND order_status.status = :status";
        
        $result = $db->select($select, array(
            ':status' => $status
        ));
        return $result;
    }

    private function setOrderDriver($orderId, $driverId)
    {
        $db = $this->getDbCentral();
        $db->update('order_list', array(
            'driver' => $driverId
        ), "`id` = $orderId");
    }

    public function getReport(array $status, $offsetVal = null, $limitVal = null, $sortField = 'id', $sortDir = 'DESC', $filter = null)
    {
        $status = implode(', ', $status);
        
        $db = $this->getDbCentral();
        
        if (isset($this->sortableFields[$sortField]))
            $orderBy = $this->sortableFields[$sortField];
        else
            $orderBy = $this->sortableFields['default'];
        
        if ($sortDir == 'ASC' || $sortDir == 'DESC')
            $orderBy .= " $sortDir";
        else {
            $orderBy .= " DESC";
        }
        
        $filterString = '';
        
        if ($filter != null) {
            if (isset($filter['callsign'])) {
                $filterString .= ' AND taxi_driver_info.callsign = ' . (int) $filter['callsign'];
            }
            
            if (isset($filter['createDatetime']['from']) && isset($filter['createDatetime']['to'])) {
                $filterString .= ' AND order_time.add BETWEEN \'' . date('Y-m-d H:i:s', $filter['createDatetime']['from']) . '\' AND \'' . date('Y-m-d H:i:s', $filter['createDatetime']['to']) . '\'';
            }
            if (isset($filter['arriveDatetime']['from']) && isset($filter['arriveDatetime']['to'])) {
                $filterString .= ' AND order_time.arrive BETWEEN \'' . date('Y-m-d H:i:s', $filter['arriveDatetime']['from']) . '\' AND \'' . date('Y-m-d H:i:s', $filter['arriveDatetime']['to']) . '\'';
            }
            if (isset($filter['finishDatetime']['from']) && isset($filter['finishDatetime']['to'])) {
                $filterString .= ' AND order_time.finish BETWEEN \'' . date('Y-m-d H:i:s', $filter['finishDatetime']['from']) . '\' AND \'' . date('Y-m-d H:i:s', $filter['finishDatetime']['to']) . '\'';
            }
            if (isset($filter['tarif_id'])) {
                if (is_array($filter['tarif_id'])) {
                    $filterTarifString = ' AND order_info.tarif_id IN (';
                    for ($i = 0, $tarifCnt = count($filter['tarif_id']); $i < $tarifCnt; $i ++) {
                        $filterTarifString .= $filter['tarif_id'][$i] . ',';
                    }
                    $filterTarifString = rtrim($filterTarifString, ',');
                    $filterTarifString .= ')';
                    $filterString .= $filterTarifString;
                }
            }
            
            if (isset($filter['firstPoint']) && ! empty($filter['firstPoint'])) {
                $orderIds = $db->select("SELECT order_id AS id FROM order_points WHERE point LIKE '%" . $filter['firstPoint'] . "%' AND point_id = 0");
                if (! empty($orderIds)) {
                    $firstPointIds = array();
                    for ($i = 0, $idsCnt = count($orderIds); $i < $idsCnt; $i ++) {
                        $firstPointIds[] = $orderIds[$i]['id'];
                    }
                } else {
                    $result['orderList'] = array();
                    $result['count'] = 0;
                    return $result;
                }
            }
            
            if (isset($filter['lastPoint']) && ! empty($filter['lastPoint'])) {
                $orderLastPointIds = $db->select("SELECT order_id AS id FROM order_points FIRST WHERE point LIKE '%" . $filter['lastPoint'] . "%' AND point_id = (SELECT COUNT( point_id ) - 1 FROM order_points SECOND WHERE SECOND.order_id = FIRST.order_id )");
                if (! empty($orderLastPointIds)) {
                    $lastPointIds = array();
                    for ($i = 0, $idsCnt = count($orderLastPointIds); $i < $idsCnt; $i ++) {
                        $lastPointIds[] = $orderLastPointIds[$i]['id'];
                    }
                } else {
                    $result['orderList'] = array();
                    $result['count'] = 0;
                    return $result;
                }
            }
            
            if (isset($firstPointIds) && isset($lastPointIds)) {
                $ids = array();
                for ($i = 0, $firstCnt = count($firstPointIds); $i < $firstCnt; $i ++) {
                    for ($j = 0, $lastCnt = count($lastPointIds); $j < $lastCnt; $j ++) {
                        if ($firstPointIds[$i] == $lastPointIds[$j]) {
                            $ids[] = $firstPointIds[$i];
                        }
                    }
                }
                
                $filterString .= ' AND order_list.id IN (' . implode(',', $ids) . ')';
            } else {
                if (isset($firstPointIds)) {
                    $filterString .= ' AND order_list.id IN (' . implode(',', $firstPointIds) . ')';
                }
                if (isset($lastPointIds)) {
                    $filterString .= ' AND order_list.id IN (' . implode(',', $lastPointIds) . ')';
                }
            }
        }
        
        $select = "SELECT
                order_list.id AS orderId,
                order_list.driver AS driverId,
                order_list.dispatcher AS dispatcherId,
                taxi_driver_info.callsign AS callsign,
                order_cl_info.name AS customerName,
                order_cl_info.phone AS customerPhone,
                order_info.cost AS cost,
                order_info.payment,
                order_info.tarif_id,
                order_info.length,
                order_info.dispatcher_note,
                order_info.tarif_id,
                order_properties.airCondition,
                order_properties.salonLoading,
                order_properties.animal,
                order_properties.city,
                order_properties.courierDelivery,
                order_properties.terminal,
                order_properties.namesign,
                order_properties.hour,
                order_properties.grach,
                order_properties.ticket,
                order_status.status,
                order_start_point.address,
                order_start_point.apartment,
                order_start_point.porch,
                order_time.add AS createDatetime,
                order_time.take AS takeDatetime,
                order_time.arrive AS arriveDatetime,
                order_time.finish AS finishDatetime
                FROM order_list
                LEFT OUTER JOIN taxi_driver_info ON order_list.driver = taxi_driver_info.id
                LEFT OUTER JOIN order_cl_info ON order_list.id = order_cl_info.order_id
                LEFT OUTER JOIN order_info ON order_list.id = order_info.order_id
                LEFT OUTER JOIN order_status ON order_list.id = order_status.order_id
                LEFT OUTER JOIN order_start_point ON order_list.id = order_start_point.order_id
                LEFT OUTER JOIN order_properties ON order_list.id = order_properties.order_id
                LEFT OUTER JOIN order_time ON order_list.id = order_time.order_id
                WHERE order_status.status
                IN ($status) $filterString $orderBy";
        
        $orderList = $db->select($select);
        
        for ($i = 0, $orderCnt = count($orderList); $i < $orderCnt; $i ++) {
            $orderList[$i]['points'] = $this->getOrderPoints($orderList[$i]['orderId']);
            
            for ($j = 0, $pointCnt = count($orderList[$i]['points']); $j < $pointCnt; $j ++) {
                $orderList[$i]['points'][$j]['point'] = array(
                    'street' => substr($orderList[$i]['points'][$j]['point'], 0, strpos($orderList[$i]['points'][$j]['point'], ',')),
                    'number' => trim(substr($orderList[$i]['points'][$j]['point'], strpos($orderList[$i]['points'][$j]['point'], ',') + 1))
                );
                
                if (! empty($orderList[$i]['points'][$j]['location']))
                    $orderList[$i]['points'][$j]['location'] = json_decode($orderList[$i]['points'][$j]['location']);
                else {
                    $location = new StdClass();
                    $location->lat = '';
                    $location->lng = '';
                    
                    $orderList[$i]['points'][$j]['location'] = $location;
                }
            }
        }
        
        return $orderList;
    }

    public function getOrderDriverNoteList()
    {
        $db = $this->getDbCentral();
        $notes = $db->select('SELECT order_id, driver_note AS note FROM order_info GROUP BY driver_note');
        
        return $notes;
    }

    public function getOrderDispNoteList()
    {
        $db = $this->getDbCentral();
        $notes = $db->select('SELECT order_id, dispatcher_note AS note FROM order_info GROUP BY dispatcher_note');
        
        return $notes;
    }

    private function makeUnixDateTime($dateTime)
    {
        $date_elems = explode(" ", $dateTime);
        $date = explode("-", $date_elems[0]);
        $time = explode(":", $date_elems[1]);
        $updateTime = mktime($time[0], $time[1], $time[2], $date[1], $date[2], $date[0]);
        return $updateTime;
    }
}