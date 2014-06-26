<?php

class Engine_Application {
	
	private static $instance;
	
	private function __construct() {
		$this->_startBootstrap();
	}
	
	private function __clone() {}
	private function __wakeup() {}	
	
	public static function getAppInstance() {
		if(!isset(self::$instance)) {
			$class = __CLASS__;
			self::$instance = new $class();
		}
	}
	
	private function _startBootstrap() {
		Engine_Bootstrap::getBootstrapInstance();
	}
	
}