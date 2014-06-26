<?php

class Engine_Model {
	
	public function __construct() {
		//$this->database = new Engine_Database(DB_TYPE, DB_HOST, DB_NAME, DB_USER, DB_PASS);
	}
	
	public function getDbCentral() {
		return new Engine_Database(DB_TYPE, CENTRAL_DB_HOST, CENTRAL_DB_NAME, CENTRAL_DB_USER, CENTRAL_DB_PASS);
	}
		
}