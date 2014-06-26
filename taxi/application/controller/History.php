<?php

class Application_Controller_History extends Engine_Controller {
	
	public function addOrderToHistory($driverId, $orderId, $sendDatetime = null, $status) {
		if($sendDatetime != null) {		
			$historyModel = new Application_Model_History();
			return $historyModel->addOrderToHistory($driverId, $orderId, $sendDatetime, $status);			
		}
		else
			return false;
	}
	
	public function updateOrderInHistory($driverId, $orderId, $closeDatetime = null, $status) {
		if($closeDatetime != null) {
			$historyModel = new Application_Model_History();
			$result = $historyModel->updateOrderInHistory($driverId, $orderId, $closeDatetime, $status);
			if($result)
				return true;
			else
				return false;
		}
		else {
			return false;
		}
	}
	
	public function getOrderHistory($driverId, $dateStart, $dateEnd, $page, $elementsPerPage) {
		$historyModel = new Application_Model_History();
		$history = $historyModel->getOrderHistory($driverId, $dateStart, $dateEnd, $page, $elementsPerPage);
		if($history)
			echo json_encode($history);
			//print_r($history);
		else
			echo json_encode(array('error' => 'Err'));
	}
	
}