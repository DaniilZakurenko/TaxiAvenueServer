<?php

class Application_Model_Status extends Engine_Model {
	
	public function __construct() {
		
	}
	
	public function getStatusList() {
		$db = $this->getDbCentral();
		
		return $db->select('SELECT status_id AS id, name FROM status_list');
	}
	
}