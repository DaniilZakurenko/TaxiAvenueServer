<?php

class Application_Model_History extends Engine_Model {

	private $db;
	
	public function __construct() {
		$this->db = $this->getDbCentral();
	}

	public function addOrderToHistory($driverId, $orderId, $sendDatetime, $status) {
		$orderModel = new Application_Model_Order();
		$order = $orderModel->getOrderById($orderId);
		if(empty($order)) {
			return json_encode(array('error' => array('message' => "Order id $orderId does not exist")));
		}
		
		$driverModel = new Application_Model_Driver();
		$driver = $driverModel->getDriverById($driverId);
		if(empty($driver)) {
			return json_encode(array('error' => array('message' => "Driver id $driverId does not exist")));
		}
		
		/*$check = $this->db->select('SELECT id FROM driver_order_history WHERE driver_id = :driverId AND order_id = :orderId', array(':driverId' => $driverId, ':orderId' => $orderId));

		if(count($check) > 0) {
			$this->db->update('driver_order_history', array('status' => $status, '`id` = '.$check[0]['id']));
			return true;
		}*/

		$entry = $this->getHistoryEntry(null, $driverId, $orderId);
		if($entry == false) {		
			$result = $this->db->insert(
				'driver_order_history',
				array(
					'driver_id' => $driverId,
					'order_id' => $orderId,
					'status' => $status,
					'order_close_datetime' => $sendDatetime
				)
			);
			
			if($result)
				return true;
			return false;
		}
		return false;
	}
	
	public function updateOrderInHistory($driverId, $orderId, $closeDatetime, $status) {
		$orderModel = new Application_Model_Order();
		$order = $orderModel->getOrderById($orderId);
		if(empty($order)) {
			return json_encode(array('error' => array('message' => "Order id $orderId does not exist")));
		}
		
		$driverModel = new Application_Model_Driver();
		$driver = $driverModel->getDriverById($driverId);
		if(empty($driver)) {
			return json_encode(array('error' => array('message' => "Driver id $driverId does not exist")));
		}
		
		$entry = $this->getHistoryEntry(null, $driverId, $orderId);
		if($entry == true) {
			$result = $this->db->update(
				'driver_order_history',
				array(
					'order_close_datetime' => $closeDatetime,
					'status' => $status
				),
				"`driver_id` = $driverId AND `order_id` = $orderId"
			);
			
			if($result)
				return true;
			return false;
		}
		return false;
	}
	
	public function getOrderHistory($driverId, $dateStart = null, $dateEnd = null, $page = null, $elementsPerPage = null) {
		if($elementsPerPage == null)
			$elementsPerPage = 20;
		//print_r($page); die();
		$driverModel = new Application_Model_Driver();
		$driver = $driverModel->getDriverById($driverId);
		if(empty($driver)) {
			return json_encode(array('error' => array('message' => "Driver id $driverId does not exist")));
		}

		if($dateStart != null && $dateEnd != null) {
			$whereDate = " AND driver_order_history.order_close_datetime BETWEEN '$dateStart 00:00:00' AND '$dateEnd 23:59:59'";
		}
		elseif($dateStart != null || $dateEnd != null) {
			if($dateStart != null) {
				$whereDate = " AND driver_order_history.order_close_datetime >= '$dateStart 00:00:00'";
			}
			if($dateEnd != null) {
				$whereDate = " AND driver_order_history.order_close_datetime <= '$dateEnd 23:59:59'";
			}
		}
		else {
			$whereDate = '';
		}
		//return array('error' => $whereDate);
		$entriesCount = $this->db->select("SELECT order_id, status FROM driver_order_history WHERE driver_id = :driverId $whereDate",
			array(':driverId' => $driverId)
			);
		
		$orderPay = array();
		for($i = 0, $entriesCnt = count($entriesCount); $i < $entriesCnt; $i++) {
			if($entriesCount[$i]['status'] == 9) {
				$orderPay[] = $entriesCount[$i]['order_id'];  
			}
		}
		
		if(!empty($orderPay)) {
			//return array('error' => $orderPay);
		
			$sum = $this->db->select('SELECT cost FROM order_info WHERE order_id IN('.implode(',',$orderPay).')');
			$orderListSum = 0;
			
			for($i = 0, $sumCnt = count($sum); $i < $sumCnt; $i++) {
				$orderListSum += $sum[$i]['cost'];
			}
		}
		
		$entriesCount = count($entriesCount);

		$totalPages = ceil($entriesCount/$elementsPerPage);		
		
		if($page == null)
			$page = 1;
		
		if($page > 0)
			$offset = ($page-1)*$elementsPerPage;
		else
			$offset = 0;
		
		$sql = "SELECT driver_order_history.order_close_datetime AS datetime, (SELECT GROUP_CONCAT(DISTINCT order_points.point ORDER BY order_points.point_id ASC SEPARATOR '|') FROM order_points WHERE order_points.order_id = driver_order_history.order_id) as points, order_info.cost AS price, driver_order_history.status FROM driver_order_history INNER JOIN order_info WHERE driver_order_history.driver_id = :driverId AND order_info.order_id = driver_order_history.order_id";		
		
		if($whereDate != '')
			$sql .= $whereDate;

		$sql .= " ORDER BY driver_order_history.order_close_datetime DESC LIMIT $offset, $elementsPerPage";
		
		$orderHistory = $this->db->select($sql,
				array(':driverId' => $driverId)
				);		

		if(!empty($orderHistory)) {
			$statusModel = new Application_Model_Status();
			$statusList = $statusModel->getStatusList();
			
			$status = array();
			for($j = 0, $statusCnt = count($statusList); $j < $statusCnt; $j++) {
				$status[$statusList[$j]['id']] = $statusList[$j]['name'];
			}
			
			for($i = 0, $c = count($orderHistory); $i < $c; $i++) {
				$points = explode('|', $orderHistory[$i]['points']);
				$orderHistory[$i]['points'] = array();
				for($j = 0, $pointsCount = count($points); $j < $pointsCount; $j++) {
					$orderHistory[$i]['points'][] = array('id' => $j, 'address' => $points[$j], 'longitude' => '0.0', 'latitude' => '0.0');
					//$orderHistory[$i]['points'][] = array('id' => $j, 'address' => $orderHistory[$i]['status'], 'longitude' => '0.0', 'latitude' => '0.0');
				}			

				$orderHistory[$i]['statusText'] = $status[$orderHistory[$i]['status']];
				$orderHistory[$i]['statusId'] = $orderHistory[$i]['status'];				
			}

			$return = array('summ' => isset($orderListSum) ? $orderListSum : 0, 'qty' => $entriesCount, 'totalPages' => $totalPages, 'currentPage' => $page, 'history' => $orderHistory);
			return $return;
		}

		return array('error' => 'За выбранный период у Вас нет заказов');
	}
	
	private function getHistoryEntry($entryId = null, $driverId = null, $orderId = null) {
		if($entryId != null) {
			$entry = $this->db->select('SELECT id, driver_id, order_id, status, order_send_datetime, order_close_datetime FROM driver_order_history WHERE id = :id', array(':id' => $entryId));
			if(!empty($entry))
				return $entry;
			return false;
		}
		
		if($driverId != null && $orderId != null) {
			$entry = $this->db->select('SELECT id, driver_id, order_id, status, order_send_datetime, order_close_datetime FROM driver_order_history WHERE driver_id = :driverId AND order_id = :orderId', 
					array(':driverId' => $driverId, ':orderId' => $orderId));
			if(!empty($entry))
				return $entry;
			return false;
		}
	}
	
}
