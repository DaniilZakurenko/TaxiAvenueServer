<?php

class Engine_Template {
	
	private $prop = array();
	
	public function __construct($name, $data) {
		if($data) {
			foreach($data as $key => $value) {
				$this->prop[$key] = $value;				
			}
		}
		require_once 'application/template/'.$name.'.php';
	}

	public function __get($prop) {
		return $this->prop;
	}
	
	public function __set($prop, $value) {
		$this->prop = $value;
	}
	
}