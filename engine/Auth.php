<?php

class Engine_Auth {
	
	private $db;
	
	public function __construct(Engine_Database $db) {
		$this->db = $db;
	}
	
	public function auth($login, $password, $type = 'web') {
		if($type == 'web') {
			$result = $this->db->select(
					'SELECT id, login, surname, name, patronymic, role, passport, email, photo FROM taxi_user WHERE login = :login AND password = :password',
					array(
							':login' => $login,
							':password' => Engine_Hash::create('sha256', $password, HASH_GENERAL_KEY)
							)
					);
			
			if(count($result) > 0) {
				Engine_Session::init();
				Engine_Session::set('userRole', $result[0]['role']);
				Engine_Session::set('loggedIn', true);
				Engine_Session::set('userId', $result[0]['id']);
				Engine_Session::set('sessionId', $_COOKIE['PHPSESSID']);
				
				$userInfo = array(
						'login' => $result[0]['login'],
						'surname' => $result[0]['surname'],
						'patronymic' => $result[0]['patronymic'],
						'passport' => $result[0]['passport'],
						'email' => $result[0]['email'],
						'photo' => $result[0]['photo'],
						);
				
				Engine_Session::set('userInfo', $userInfo);
			}	
			return $result;
		}
		if($type == 'mobile') {
			$result = $this->db->select(
					'SELECT 
						taxi_driver_info.id, 
						taxi_driver_info.callsign, 
						taxi_status.status,
						taxi_status.location_update 
					FROM 
						taxi_driver_info 
					INNER JOIN 
						taxi_status 
					WHERE 
						callsign = :callsign 
					AND password = :password 
					AND taxi_status.taxi_id = taxi_driver_info.id',
					array(
							':callsign' => $login,
							':password' => Engine_Hash::create('sha256', $password, HASH_GENERAL_KEY)
							)
					);
			
			if(($result) > 0) {
				switch($result[0]['status']) {					
					case 1:
					case 2:
					case 3:
					case 4:
						$date1 = new DateTime(date('Y-m-d H:i:s'));
						$date2 = new DateTime($result[0]['location_update']);
						$interval = $date2->diff($date1);
							
// 						if($interval->s < 40) {
// 							return array('error' => 'Вы не можете войти в систему. Вероятно, программа была закрыта некорректно или позывной используется в данное время');
// 						}
// 						else {
							Engine_Session::init();
							Engine_Session::set('loggedIn', true);
							Engine_Session::set('driverId', $result[0]['id']);
							Engine_Session::set('callsign', $result[0]['callsign']);
							$sessionId = session_id();
							Engine_Session::set('sessId', $sessionId);
								
							$this->db->update('taxi_driver_info', array('session_id' => $sessionId), "`id` = {$result[0]['id']}");
							
							return array('driverId' => $_SESSION['driverId'], 'sessionId' => $_SESSION['sessId']);
// 						}
						break;
					case 5:
						Engine_Session::init();
						Engine_Session::set('loggedIn', true);
						Engine_Session::set('driverId', $result[0]['id']);
						Engine_Session::set('callsign', $result[0]['callsign']);
						$sessionId = session_id();
						Engine_Session::set('sessId', $sessionId);
							
						$this->db->update('taxi_driver_info', array('session_id' => $sessionId), "`id` = {$result[0]['id']}");
						
						return array('driverId' => $_SESSION['driverId'], 'sessionId' => $_SESSION['sessId']);
						break;
					case 19:
						return array('error' => 'Вы не можете войти в систему (заблокирован).');
						break;
				}				
			}
			return array('error' => 'Неверный позывной, либо пароль');
		}
	}
	
	public static function handleLogin() {;
		if(!isset($_SESSION['loggedIn']) || $_SESSION['loggedIn'] == false) {
			Engine_Session::destroy();
			header('Location: ' . URL);
			exit;
		}
	}	
	
}
