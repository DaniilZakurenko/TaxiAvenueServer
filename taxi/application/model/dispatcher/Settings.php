<?php

class Application_Model_Dispatcher_Settings extends Engine_Model
{

    public function getCashPaymentTarif()
    {
        $db = $this->getDbCentral();
        return $db->select('SELECT cash_payment_tarif.type AS typeId, taxi_car_type.type, fluidTarification, extraCost, fluidTarifMin, kmMin, downtime, hourTarif, minHourTarif, ootOneWayTarif, ootTnbTarif FROM cash_payment_tarif INNER JOIN taxi_car_type WHERE cash_payment_tarif.type = taxi_car_type.id');
    }

    public function getTarifGrid($type)
    {
        $db = $this->getDbCentral();
        return $db->select("SELECT $type.type AS typeId, taxi_car_type.type, fluidTarification, extraCost, fluidTarifMin, kmMin, downtime, hourTarif, minHourTarif, ootOneWayTarif, ootTnbTarif FROM $type INNER JOIN taxi_car_type WHERE $type.type = taxi_car_type.id");
    }

    public function saveTarifGrid($type, $data)
    {
        $tarriff = array();
        
        for ($i = 0, $fieldsCnt = count($data); $i < $fieldsCnt; $i ++) {
            preg_match('/[0-9]/', $data[$i]['name'], $key);
            preg_match('/[a-zA-Z]+/', $data[$i]['name'], $tariffName);
            $tarriff[$key[0]][$tariffName[0]] = $data[$i]['value'];
        }
        
        $db = $this->getDbCentral();
        
        foreach ($tarriff as $tarriffId => $fields) {
            $updateFields = array();
            foreach ($fields as $fieldName => $fieldValue) {
                $updateFields[$fieldName] = $fieldValue;
            }
            $updateFields['update_time'] = date('Y-m-d H:i:s');
            $db->update($type, $updateFields, "`type` = $tarriffId");
        }
    }
}