<?php

class Application_Model_Message extends Engine_Model {

	public function __construct() {
	}
	
	public function sendMessage($type, $message, $driverId = null) {
		$db = $this->getDbCentral();

		switch($type) {
			//Одному водителю или нескольким выбранным водителям
			case 1:
				if($driverId != null) { 
					$saveMessage = $db->insert('message_text', array('text' => $message));
					$messageId = $db->lastInsertId();
										
					if(is_array($driverId)) {
						for($i = 0, $driverCount = count($driverId); $i < $driverCount; $i++) {
							$db->insert('message_list', array('type' => $type, 'message_id' => $messageId, 'driver_id' => $driverId[$i], 'datetime' => time()));
						}
						$ids = $driverId;
					}
					else {
						$db->insert('message_list', array('type' => $type, 'message_id' => $messageId, 'driver_id' => $driverId, 'datetime' => time()));
						
						$ids = array($driverId);
					} 
					
					$driverModel = new Application_Model_Driver();
					$regIds = $driverModel->getPushRegistrationId($ids);			
					
					$message = array(
							"messageType" => 1006,
							"message" => array(
									"id" => 123,
									"subject" => 'subject',
									"from" => 'TaxiAvenue',
									"datetime" => date('Y-m-d H:i:s'),
									"body" => $message
								)
						);
															
					$push = new Lib_Push_GCM();					
					
					$pushResult = $push->sendNotification($regIds, $message);
					
					print_r($pushResult);
					
					/*
					$db->insert('push',
							array(
								'drivers' => json_encode($driver[0]['id']),
								'order_id' => isset($orderId) ? $orderId : $order['orderId'],
								'message' => json_encode($message),
								'date' => date('Y-m-d H:i:s'),
								'result' => $pushResult
							)
					);
					*/
				}
				break;
			//Всем свободным водителям
			case 2:
				break;
			//Всем водителям под заказом
			case 3:
				break;
			//Всем авторизованным водителям
			case 4:
				break;
			//Всем водителям
			case 5:
				break;
		}
		$db = $this->getDbCentral();
	}
	
}