<?php

class Application_Controller_Index extends Engine_Controller {
	
	public function index()
    {
		/*$view = $this->getView('index/index', array(
				'session' => $_SESSION['userInfo']
				));*/
		if(isset($_SESSION['loggedIn']) && $_SESSION['loggedIn'] === true) {
			$model = new Application_Model_Order();
			$orders = $model->getOrderListJSON(array(6,7,8,11), null);
				//echo '<pre>'; print_r($orders); echo '</pre>'; die();
				//echo json_encode($orders); die();
			$statusModel = new Application_Model_Status();
			$statusList = $statusModel->getStatusList();
				
			//$template = $this->getTemplate('order/orderList', array('orders' => $orders, 'statusList' => $statusList));
			
			$view = $this->getView('index/index', array('orderList' => $orders['orderList']));
		}
		else {			
			$view = $this->getView('index/login');
		}
		
		if(isset($view)) echo $view;
	}
	
}