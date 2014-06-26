<?php

class Application_Controller_Customer extends Engine_Controller {
	
	public function __construct()
    {
		Engine_Auth::handleLogin();
	}
	
	public function getCustomerList()
    {
		$customerModel = new Application_Model_Customer();
		$customerList = $customerModel->getCustomerList();
		echo json_encode($customerList);
	}
	
}