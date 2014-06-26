<?php

class Lib_Sms_Sms {
	
	private $from = "Taxi Avenu";
	private $host = 'https://api.life.com.ua:443/ip2sms/';
	private $login = 'Taxi Avenu';
	private $password = 'wC7r0719yelrye';
	
	public function __construct() {
	
	}
	
	public function sendSms($to, $text) {
		//$to="380957536866"; //Номер получателя
		//$to="380663892866"; //Номер получателя
		//$to="380667231468"; //Номер получателя
		//$text="Тестовое смс"; //Текст сообщения в кодировке UTF-8!!!!
		//65077088
		
		if(strlen($to) >= 12) {
			if($to[0] == '+') $to = substr($to, 1);
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $this->host);		
			curl_setopt($ch, CURLOPT_POST, true);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);		
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
			curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Basic ' . base64_encode($this->login.":".$this->password), 'Content-Type:text/xml'));
			$data = '<message><service id="single" source="' . $this->from . '" validity="+2 hour" /><to>' . $to . '</to><body content-type="text/plain">' . $text . '</body></message>';
			curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		
			$result = curl_exec($ch);
			return $result;
		}
		return true;
	}
	
}
