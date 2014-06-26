<?php

class Application_Controller_Login extends Engine_Controller {
	
	public function __construct() {}
	
	public function login()
    {
		if(!isset($_POST['login']) || $_POST['login'] == '') {
			$response['error'][] = 'Enter Login';
		}
		
		if(!isset($_POST['password']) || $_POST['password'] == '') {
			$response['error'][] = 'Enter Password';
		}
		
		if(isset($response)) {
			echo json_encode($response);
			return false;
		}
		
		else {
			$auth = new Engine_Auth(new Engine_Database(DB_TYPE, CENTRAL_DB_HOST, CENTRAL_DB_NAME, CENTRAL_DB_USER, CENTRAL_DB_PASS));
			$authResult = $auth->auth($_POST['login'], $_POST['password']);
			if(!$authResult) {
				$response['error'][] = 'Wrong login or password';								
			}
			else {
				$response['url'] = URL;
			}
			echo json_encode($response);
			return false;
		}
	}
	
}