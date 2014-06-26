<?php

class Application_Controller_Logout extends Engine_Controller {
	
	public function __construct() {}
	
	public function logout()
    {
		Engine_Session::destroy();
	}
	
}