<?php

class Engine_Controller {
	
	public function __construct() {}
	
	public function getModel($modelClass) {
		if($this->_checkModel($modelClass) !== false) {
			return new $modelClass();
		}
	}
	
	private function _checkModel($modelClass) {
		$modelPath = str_replace('_', '/', strtolower($modelClass));
		$modelPath = explode('/', $modelPath);
		$modelPath[count($modelPath)-1] = ucfirst($modelPath[count($modelPath)-1]);
		$modelPath = implode('/', $modelPath);
		
		if(is_file($modelPath.'.php')) {
			return true;
		}
		else { 
			return false; 
		}
	}

	public function getView($name, $data = array()) {
		ob_start();
		$viewInstance = new Engine_View($data);		
		$viewInstance->render($name);
		$view = ob_get_contents();
		ob_end_clean();
		return $view;
	}
	
	public function getTemplate($name, $data = array()) {
		ob_start();
		$templateInstance = new Engine_Template($name, $data);
		$template = ob_get_contents();
		ob_end_clean();
		return $template;
	}
	
}