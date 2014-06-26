<?php

class Engine_Bootstrap {
	
	private static $instance;
	
	//private $_url = '';
	private $_route = null;
	private $_controller = null;
	private $_action = null;
	
	private function __construct() {
		Engine_Session::init();
		$this->_exploreRoute($this->_getRoute());
	}
	
	private function __clone() {}
	private function __wakeup() {}
	
	public static function getBootstrapInstance() {
		if(!isset(self::$instance)) {
			$class = __CLASS__;
			self::$instance = new $class();
		}
		return self::$instance;
	}

	private function _getRoute() {
		$url = isset($_GET['url']) ? $_GET['url'] : null;
		$url = filter_var(rtrim($url, '/'), FILTER_SANITIZE_URL);
		return explode('/', $url);
	}
	
	private function _exploreRoute($route) {
		$routeCount = count($route);				
		
		if($routeCount > 1) {
			$this->_action = $route[1];
		}
		else {
			$this->_action = 'index';
		}
				
		if(!empty($route[0])) {
			$controllerRoute = 'application/controller/'.ucfirst($route[0]);
			$controllerClass = str_replace(' ', '_', ucwords(str_replace('/', ' ', $controllerRoute)));
			
			if(is_file($controllerRoute.'.php')) {
				$this->_controller = $this->_getController($controllerClass);
				$this->_controller->{$this->_action}($this->_getParams($route));
			}
			else {
				echo 'Error';
			}
		}
		else {
			$this->_controller = new Application_Controller_Index();
			$this->_controller->index();
		}
	}
	
	private function _getController($controllerClass) {
		return new $controllerClass();
	}
	
	private function _getParams($route, $i = 2) {
		$params = array();
		if(count($route) >= 3) {
			for($i; $i < count($route); $i++) {
				$params[] = $route[$i];
			}
		}
		return $params;
	}
	
}