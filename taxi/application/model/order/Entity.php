<?php

class Application_Model_Order_Entity
{

    public $orderId = '';

    public $dispatcherId = '';

    public $customerId = '';

    public $driverId = '';

    public $type = '';

    public $payment = '';

    public $tarifId = '';

    public $dir = '';

    public $length = '';

    public $cost = '';

    public $driverNote = '';

    public $dispatcherNote = '';

    public $points = '';

    public $status = '';

    public $createDateTime = '';

    public $takeDateTime = '';

    public $arriveDateTime = '';

    public $startDateTime = '';

    public $updateDateTime = '';

    public $finishDateTime = '';

    public $additionalServices = '';
    
    private $db;

    public function __construct($data, $db)
    {
        $this->arrayExchange($data);
        $this->db = $db;
    }

    private function arrayExchange($data)
    {
        $this->orderId = isset($data['orderId']) ? $data['orderId'] : null;
        $this->dispatcherId = isset($data['dispatcherId']) ? $data['dispatcherId'] : null;
        $this->driverId = isset($data['driverId']) ? $data['driverId'] : null;
        $this->customerId = isset($data['customerId']) ? $data['customerId'] : null;
        $this->type = isset($data['type']) ? $data['type'] : null;
        $this->payment = isset($data['payment']) ? $data['payment'] : null;
        $this->tarifId = isset($data['tarifId']) ? $data['tarifId'] : null;
        $this->dir = isset($data['dir']) ? $data['dir'] : null;
        $this->length = isset($data['length']) ? $data['length'] : null;
        $this->cost = isset($data['cost']) ? $data['cost'] : null;
        $this->driverNote = isset($data['driverNote']) ? $data['driverNote'] : null;
        $this->dispatcherNote = isset($data['dispatcherNote']) ? $data['dispatcherNote'] : null;
        $this->points = isset($data['point']) ? $data['point'] : null;
        $this->status = isset($data['status']) ? $data['status'] : null;
        $this->createDateTime = isset($data['createDateTime']) ? $data['createDateTime'] : null;
        $this->takeDateTime = isset($data['takeDateTime']) ? $data['takeDateTime'] : null;
        $this->arriveDateTime = isset($data['arriveDateTime']) ? $data['arriveDateTime'] : null;
        $this->startDateTime = isset($data['startDateTime']) ? $data['startDateTime'] : null;
        $this->updateDateTime = isset($data['updateDateTime']) ? $data['updateDateTime'] : null;
        $this->finishDateTime = isset($data['finishDateTime']) ? $data['finishDateTime'] : null;
        $this->additionalServices = isset($data['additionalServices']) ? $data['additionalServices'] : null;
    }

    public function calculateOrder()
    {
        $pointsCnt = count($this->points) >= 1 ? count($this->points) : null;
        
        if ($pointsCnt == null || empty($this->points[0]['S']))
            throw new Exception('Not enough points');
        
        if ($pointsCnt == 1 && ! empty($this->additionalServices['city'])) {
            throw new Exception('Not enough points');
        }
        
        if ($this->payment != null)
            $tarif = $this->db->select('SELECT * FROM ' . $this->payment . ' WHERE type = ' . $this->tarifId);
        else
            throw new Exception('Payment is null');
        
        if ($this->length <= $tarif[0]['kmMin']) {
            $this->cost += $tarif[0]['fluidTarifMin'];
        } else {
            $dif = $length - $tarif[0]['kmMin'];
            $this->cost += $tarif[0]['fluidTarifMin'] + ($dif / 1000) * $tarif[0]['fluidTarification'];
        }
        
        $this->getPath();
    }

    private function calcBaseCost()
    {
        $path = '';
        $pointsCnt = count($this->points);
        
        if ($pointsCnt > 1) {
            for ($i = 1; $i < $pointsCnt; $i ++) {
                $path .= str_replace(' ', '+', $this->points[$i]['S']) . '+' . $this->points[$i]['N'] . '+Днепропетровск|';
            }
            
            $from = str_replace(' ', '+', $this->points[0]['S']) . '+' . $this->points[0]['N'] . '+Днепропетровск|';
            
            $path = rtrim($path, '|');
            $path = str_replace(',', '+', $path);
            $path = str_replace('.', '+', $path);
            
            $ch = curl_init();
            
            curl_setopt($ch, CURLOPT_URL, "http://maps.googleapis.com/maps/api/directions/json?origin=$from&waypoints=$path&units=metric&mode=driving&sensor=false");
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            
            $result = json_decode(curl_exec($ch), true);
            curl_close($ch);
            
            $length = 0;
            
            for ($i = 0; $i < $pointsCnt - 1; $i ++) {
                $this->length += $result['routes'][0]['legs'][$i]['distance']['value'];
                $this->points[$i]['coordinates'] = $result['routes'][0]['legs'][$i]['start_location'];
            }
            
            $this->points[$pointsCnt - 1]['coordinates'] = $result['routes'][0]['legs'][count($result['routes'][0]['legs']) - 1]['end_location'];
        } else {
            $address = 'Днепропетровск,' . str_replace(' ', '+', $this->points[0]['S']) . '+' . $this->points[0]['N'];
            $ch = curl_init();
            
            curl_setopt($ch, CURLOPT_URL, "http://maps.googleapis.com/maps/api/geocode/json?address=$address&sensor=false");
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            
            $result = json_decode(curl_exec($ch), true);
            curl_close($ch);
            
            $this->points[0]['coordinates'] = $result['results'][0]['geometry']['location'];
        }
    }
    
    private function calcAdditionalOrderCost() {
        
    }
}