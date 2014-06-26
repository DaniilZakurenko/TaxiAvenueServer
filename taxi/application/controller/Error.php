<?php

class Application_Controller_Error extends Engine_Controller {
	
	private $_errorMessage = 'Запрашиваемая страница не существует';
	
	public function __construct($errorMessage = '') {
		parent::__construct();
		if(!empty($errorMessage)) {
			$this->_errorMessage = $errorMessage;
		}
		$this->index();		
	}	
	
	public function index() {
		$this->view->header = 'Страница не найдена';
		$this->view->errorMessage = $this->_errorMessage;
		$this->view->render('error/index');
	}
	
}