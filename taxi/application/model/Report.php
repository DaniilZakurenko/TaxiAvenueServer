<?php

class Application_Model_Report extends Engine_Model {
	
	private $db;
	
	public function __construct() {
		$this->db = $this->getDbCentral();
	}
	
	public function getDriverReport($dateFrom = null, $dateTo = null) {
		if($dateFrom != null && $dateTo != null) {
			$innerJoin = ' INNER JOIN order_time ';
			$where = " WHERE order_time.order_id =  order_time.add BETWEEN $dateFrom AND $dateTo";
		}
		else {
			$innerJoin= '';
			$where = '';
		}
		
		$result = $this->db->select(
				"SELECT 
					taxi_driver_info.id, 
					taxi_driver_info.callsign, 
					taxi_driver_info.surname, 
					(SELECT COUNT(id) FROM order_list WHERE order_list.id IN 
						(SELECT order_time.order_id FROM order_time WHERE order_time.add BETWEEN '$dateFrom' AND '$dateTo') 
						AND order_list.driver = taxi_driver_info.id) AS orderCount 
				FROM 
					taxi_driver_info"
				);
		
		return $result;
	}
	 
	/*
	public function getSingleDriverReport($id, $dateFrom = null, $dateTo = null) {
		if($dateFrom != null && $dateTo != null) {
			//$dateTo = date('d-m-Y', strtotime(substr($order[$i]['add'], 0, 10)));
			$where = " AND order_time.add BETWEEN '$dateFrom' AND '$dateTo'";
		}
		else {
			$where = '';
		}
		
		$result = $this->db->select(
				"SELECT
					order_list.id,
					order_time.add,
					order_time.take,
					order_time.finish,
					order_status.status,
					order_info.cost
				FROM 
					order_list
				INNER JOIN
					order_time,
					order_status,
					order_info
				WHERE 
					order_list.driver = :id
				AND order_time.order_id = order_list.id
				AND order_status.order_id = order_list.id
				AND order_status.status = 3
				AND order_info.order_id = order_list.id
				".$where,
				array(':id' => $id));
		return $result;
	}
	*/
		
}
