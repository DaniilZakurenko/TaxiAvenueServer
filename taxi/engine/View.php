<?php

class Engine_View {
	
	private $prop = array();
	
	public function __construct($data) {
		if($data) {
			foreach($data as $key => $value) {
				$this->prop[$key] = $value;
			}
		}
	}
	
	public function __get($prop) {
		return $this->prop;
	}
	
	public function __set($prop, $value) {
		$this->prop = $value;
	}
	
	public function render($name) {
		require_once 'application/view/header.php';
		require_once 'application/view/'.$name.'.php';
		require_once 'application/view/footer.php';
	}
	
}