<?php

class Application_Model_Tariffication extends Engine_Model {

	public function getCommonTariffication() {
		$db = $this->getDbCentral();
		$select = 'SELECT value FROM common_tariffication WHERE id = 1';
		$commonTariffication = $db->select($select);
		return json_decode($commonTariffication[0]['value']);		
	}
	
	public function saveCommonTariffication($newTariff) {
		$db = $this->getDbCentral();
		$tariff = $this->getCommonTariffication();
		
		foreach($newTariff as $key => $value) {
			foreach($value as $fieldName => $fieldValue) {
				$tariff->$key->$fieldName = $fieldValue;
			}		
		}
		
		$db->update('common_tariffication', array('value' => json_encode($tariff)), '`id` = 1');
	}
	
	public function getAdditionalServices() {
		$db = $this->getDbCentral();
		$select = 'SELECT id, name, title, type, value, active FROM additional_services';
		$additionalServices = $db->select($select);
		return $additionalServices;
	}
	
	public function saveAdditionalServices($services) {
		$db = $this->getDbCentral();
		foreach($services as $service) {
			$data = array('value' => $service[key($service)]['value'], 'type' => $service[key($service)]['type']);
			$db->update('additional_services', $data, "`name` = '".key($service)."'");
		}
	}
	
}