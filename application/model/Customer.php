<?php

class Application_Model_Customer extends Engine_Model {
	
	private $db;
	
	public function __construct() {
		$this->db = $this->getDbCentral();
	}
	
	public function getCustomerList() {
		$db = $this->db;
		$select = 'SELECT id, phone, name, (SELECT COUNT(ID) FROM order_list WHERE customer = customer.id) AS orderCount FROM customer';
		$result = $db->select($select);
		return $result;
	}
	
	public function getCustomerById($customerId) {
		
	}
	
	public function getCustomerByPhone($phone) {
		$result = $this->db->select('SELECT customer.id, customer.phone, customer.name FROM customer WHERE customer.phone = :phone', array('phone' => $phone));
		return $result;
	}
	
	public function saveCustomer($phone, $name, $customerId = '') {
		if(empty($customerId)) {
			$customer = $this->getCustomerByPhone($phone);
			if(empty($customer)) {			
				$result = $this->db->insert('customer', array('phone' => $phone, 'name' => $name));
				if($result)
					return $this->db->lastInsertId();
				return false;
			}
			return false;
		}
		else {
			$result = $this->db->update('customer', array('phone' => $phone, 'name' => $name), "`id` = $customerId");
			if($result)
				return true;
			return false;
		}
	}
	
	public function addCustomerToBlackList($customerId) {
		
	}
	
	public function removeCustomerFromBlackList($customerId) {
		
	}
	
}