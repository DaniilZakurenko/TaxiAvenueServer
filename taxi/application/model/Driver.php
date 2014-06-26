<?php

class Application_Model_Driver extends Engine_Model
{

    private $driverSortableFields = array(
        'default' => ' ORDER BY taxi_driver_info.callsign',
        'status' => ' ORDER BY status',
        'callsign' => ' ORDER BY taxi_driver_info.callsign',
        'firstPoint' => ' ORDER BY order_start_point.address',
        'cost' => ' ORDER BY order_info.cost',
        'length' => ' ORDER BY order_info.length',
        'createDatetime' => ' ORDER BY createDatetime',
        'arriveDatetime' => ' ORDER BY arriveDatetime',
        'takeDatetime' => ' ORDER BY takeDatetime',
        'finishDatetime' => ' ORDER BY finishDatetime',
        'phone' => ' ORDER BY order_cl_info.phone'
    );

    public function __construct()
    {}

    public function getDriverList($offsetVal, $limitVal, $sortField, $sortDir, $filter)
    {
        $db = $this->getDbCentral();
        $result = array();
        
        if (isset($filter['taxi_status'])) {
            //$status = implode(',', $filter['taxi_status']);
            //$result['r'] = $status;
            $status = $filter['taxi_status'];
        } else
            $status = '1,2,3,4,5,11,13,14,15,19,20,21';
        
        if (isset($this->driverSortableFields[$sortField]))
            $orderBy = $this->driverSortableFields[$sortField];
        else
            $orderBy = $this->driverSortableFields['default'];
        
        if ($sortDir == 'ASC' || $sortDir == 'DESC')
            $orderBy .= " $sortDir";
        else {
            $orderBy .= " DESC";
        }
        
        $filterString = '';
        
        if ($filter != null) {
            if (isset($filter['driver_callsign']))
                $filterString .= ' AND taxi_driver_info.callsign = ' . (int) $filter['driver_callsign'];
        }
        
        $limit = '';
        
        if ($offsetVal !== null && !isset($filter['driver_callsign'])) {
            $limit = " LIMIT $offsetVal";
            if ($limitVal !== null) {
                $limit .= ",$limitVal";
            }
            
            $select = 'SELECT
					COUNT(id)
				FROM
					taxi_driver_info
				INNER JOIN 
					taxi_car_info,
					taxi_status
				WHERE
					taxi_status.taxi_id = taxi_car_info.driver_id
				AND
					taxi_driver_info.id = taxi_car_info.driver_id
                AND
                    taxi_status.status IN (' . $status . ')' . $filterString . $orderBy;

            $driverListCount = $db->select($select);
            $result['count'] = $driverListCount[0]['COUNT(id)'];
        }
        
        if(!isset($filter['driver_callsign']))
            $where = ' AND taxi_status.status IN (' . $status . ')'. $orderBy . $limit;
        else
            $where = $filterString;
        
        $selectDriver = 'SELECT
					id AS driver_id,
					taxi_driver_info.callsign AS driver_callsign,
					taxi_driver_info.surname AS driver_surname,
					taxi_driver_info.name AS driver_name,
					taxi_driver_info.patronymic AS driver_patronymic,
					taxi_driver_info.mobile_phone AS driver_mobile_phone,
					taxi_driver_info.phone2 AS driver_phone,
					taxi_driver_info.address1 AS driver_address,
					taxi_driver_info.passport AS driver_passport,
					taxi_driver_info.dob AS driver_dob,
					taxi_driver_info.admission_date AS driver_admission_date,
					taxi_driver_info.dismissal_date AS driver_dismissal_date,
					taxi_driver_info.see_non_cash AS driver_see_non_cash,
					taxi_driver_info.only_non_cash AS driver_only_non_cash,
					taxi_driver_info.passenger_phone AS driver_passenger_phone,
					taxi_driver_info.photo AS driver_photo,
					taxi_car_info.year AS car_year,
					taxi_car_info.type AS car_type,
					taxi_car_info.terminal AS car_terminal,
					taxi_car_info.condition AS car_condition,
					taxi_car_info.commission AS car_commission,
					taxi_car_info.fee AS car_fee,
					taxi_car_info.tariff_ind AS car_tariff_ind,
					taxi_car_info.self_carport AS car_self_carport,
					taxi_car_info.number AS car_number,
					taxi_car_info.model AS car_model,
					taxi_car_info.color AS car_color,
					taxi_car_info.commission_period_pay AS car_commission_period_pay,
					taxi_car_info.fee_period AS car_fee_period,
					taxi_car_info.notes AS car_notes,
					taxi_status.status AS taxi_status,
					taxi_status.lat AS taxi_location_lat,
					taxi_status.lng AS taxi_location_lng,
					taxi_status.status_update AS taxi_status_update
				FROM
					taxi_driver_info
				INNER JOIN
					taxi_car_info,
					taxi_status
				WHERE
					taxi_status.taxi_id = taxi_car_info.driver_id
				AND
					taxi_driver_info.id = taxi_car_info.driver_id' . $where;

        $driverList = $db->select($selectDriver);
        
        $result['driverList'] = $driverList;
        if(!isset($result['count']))
            $result['count'] = count($driverList);
        
        return $result;
    }
    
    // public function getDriverList($sortField = 'id', $page = 1, $sortDir = 'ASC', $rowCount = '')
    // {
    // $db = $this->getDbCentral();
    
    // // $sortField = ' ORDER BY taxi_driver_info.id';
    
    // $order = ' ORDER BY taxi_driver_info.' . $sortField . ' ' . $sortDir;
    
    // if ($rowCount != '') {
    // $start = ($page - 1) * $rowCount;
    // $limit = " LIMIT $start, $rowCount";
    
    // $totalDriverCnt = $db->select('SELECT COUNT(id) FROM taxi_driver_info');
    // $pagination['page'] = $page;
    // $pagination['totalPages'] = ceil($totalDriverCnt[0]['COUNT(id)'] / $rowCount);
    // $pagination['elementsCnt'] = $rowCount;
    
    // $return['pagination'] = $pagination;
    // } else {
    // $limit = '';
    // }
    
    // $driverList = $db->select('SELECT
    // id AS driver_id,
    // taxi_driver_info.callsign AS driver_callsign,
    // taxi_driver_info.surname AS driver_surname,
    // taxi_driver_info.name AS driver_name,
    // taxi_driver_info.patronymic AS driver_patronymic,
    // taxi_driver_info.mobile_phone AS driver_mobile_phone,
    // taxi_driver_info.phone2 AS driver_phone,
    // taxi_driver_info.address1 AS driver_address,
    // taxi_driver_info.passport AS driver_passport,
    // taxi_driver_info.dob AS driver_dob,
    // taxi_driver_info.admission_date AS driver_admission_date,
    // taxi_driver_info.dismissal_date AS driver_dismissal_date,
    // taxi_driver_info.see_non_cash AS driver_see_non_cash,
    // taxi_driver_info.only_non_cash AS driver_only_non_cash,
    // taxi_driver_info.passenger_phone AS driver_passenger_phone,
    // taxi_driver_info.photo AS driver_photo,
    // taxi_car_info.year AS car_year,
    // taxi_car_info.type AS car_type,
    // taxi_car_info.terminal AS car_terminal,
    // taxi_car_info.condition AS car_condition,
    // taxi_car_info.commission AS car_commission,
    // taxi_car_info.fee AS car_fee,
    // taxi_car_info.tariff_ind AS car_tariff_ind,
    // taxi_car_info.self_carport AS car_self_carport,
    // taxi_car_info.number AS car_number,
    // taxi_car_info.model AS car_model,
    // taxi_car_info.color AS car_color,
    // taxi_car_info.commission_period_pay AS car_commission_period_pay,
    // taxi_car_info.fee_period AS car_fee_period,
    // taxi_car_info.notes AS car_notes,
    // taxi_status.status AS taxi_status,
    // taxi_status.lat AS taxi_location_lat,
    // taxi_status.lng AS taxi_location_lng,
    // taxi_status.status_update AS taxi_status_update
    // FROM
    // taxi_driver_info
    // INNER JOIN
    // taxi_car_info,
    // taxi_status
    // WHERE
    // taxi_status.taxi_id = taxi_car_info.driver_id
    // AND
    // taxi_driver_info.id = taxi_car_info.driver_id');
    // /*
    // * $driverList = $db->select('SELECT id, taxi_driver_info.callsign, taxi_driver_info.surname, taxi_driver_info.name, taxi_driver_info.patronymic, taxi_driver_info.mobile_phone, taxi_car_info.number, taxi_car_info.model, taxi_car_info.color, taxi_car_info.type, taxi_car_info.notes FROM taxi_driver_info INNER JOIN taxi_car_info WHERE taxi_driver_info.id = taxi_car_info.driver_id '.$order.$limit);
    // */
    // $return['driverList'] = $driverList;
    
    // return $return;
    // }
    public function getDriverById($driverId)
    {
        $db = $this->getDbCentral();
        
        $result = $db->select('SELECT
					id AS driver_id,
					taxi_driver_info.callsign AS driver_callsign,
					taxi_driver_info.surname AS driver_surname,
					taxi_driver_info.name AS driver_name,
					taxi_driver_info.patronymic AS driver_patronymic,
					taxi_driver_info.mobile_phone AS driver_mobile_phone,
					taxi_driver_info.phone2 AS driver_phone,
					taxi_driver_info.address1 AS driver_address,
					taxi_driver_info.passport AS driver_passport,
					taxi_driver_info.dob AS driver_dob,
					taxi_driver_info.admission_date AS driver_admission_date,
					taxi_driver_info.dismissal_date AS driver_dismissal_date,
					taxi_driver_info.see_non_cash AS driver_see_non_cash,
					taxi_driver_info.only_non_cash AS driver_only_non_cash,
					taxi_driver_info.passenger_phone AS driver_passenger_phone,
					taxi_driver_info.photo AS driver_photo,
					taxi_car_info.year AS car_year,
					taxi_car_info.type AS car_type,
					taxi_car_info.terminal AS car_terminal,
					taxi_car_info.condition AS car_condition,
					taxi_car_info.commission AS car_commission,
					taxi_car_info.fee AS car_fee,
					taxi_car_info.tariff_ind AS car_tariff_ind,
					taxi_car_info.self_carport AS car_self_carport,
					taxi_car_info.number AS car_number,
					taxi_car_info.model AS car_model,
					taxi_car_info.color AS car_color,
					taxi_car_info.commission_period_pay AS car_commission_period_pay,
					taxi_car_info.fee_period AS car_fee_period,
					taxi_car_info.notes AS car_notes,
					taxi_status.status AS taxi_status,
					taxi_status.lat AS taxi_location_lat,
					taxi_status.lng AS taxi_location_lng,
					taxi_status.status_update AS taxi_status_update
				FROM
					taxi_driver_info
				INNER JOIN 
					taxi_car_info,
					taxi_status
				WHERE
					taxi_status.taxi_id = :driverId
				AND
					taxi_car_info.driver_id = :driverId
				AND
					taxi_driver_info.id = :driverId', array(
            ':driverId' => $driverId
        ));
        
        return $result;
    }

    public function getDriverByCallsign($callsign)
    {
        $db = $this->getDbCentral();
        if (is_array($callsign)) {
            $callsigns = implode(',', $callsign);
            $driver = $db->select('SELECT id, callsign, g_reg_id FROM taxi_driver_info WHERE callsign IN (' . $callsigns . ')');
        } else {
            $driver = $db->select('SELECT id, callsign, g_reg_id FROM taxi_driver_info WHERE callsign = :callsign', array(
                ':callsign' => $callsign
            ));
        }
        return $driver;
    }

    public function saveDriver($data)
    {
        $db = $this->getDbCentral();
        
        $info = array(
            'surname' => $data['driver']['surname'],
            'name' => $data['driver']['name'],
            'patronymic' => $data['driver']['patronymic'],
            'address1' => $data['driver']['address'],
            'mobile_phone' => $data['driver']['mobile_phone'],
            'phone2' => $data['driver']['phone'],
            'admission_date' => date("Y-m-d", strtotime($data['driver']['admission_date'])),
            'dismissal_date' => ! empty($data['driver']['dismissal_date']) ? date("Y-m-d", strtotime($data['driver']['dismissal_date'])) : '',
            'passport' => $data['driver']['passport'],
            // 'credit_auto' => $data['driver']['credit_auto'],
            'only_non_cash' => isset($data['driver']['only_non_cash']) ? 1 : 0,
            'see_non_cash' => isset($data['driver']['see_non_cash']) ? 1 : 0,
            'dob' => date("Y-m-d", strtotime($data['driver']['dob'])),
            'passenger_phone' => isset($data['driver']['passenger_phone']) ? 1 : 0,
            'photo' => isset($data['img']) ? '/uploads/driverPhoto/' . $data['img'] : '/images/background_Preview_picture.png'
        );
        
        if (! empty($data['driver']['password']))
            $info['password'] = Engine_Hash::create('sha256', $data['driver']['password'], HASH_GENERAL_KEY);
        
        if (! isset($data['driverId']) || empty($data['driverId'])) {
            $info['callsign'] = $data['driver']['callsign'];
            $action = 'insert';
            $where = array();
        } else {
            $driverId = $data['driverId'];
            $action = 'update';
            $where = '`id` = ' . $driverId;
        }
        
        try {
            $saveDriver = $db->$action('taxi_driver_info', $info, $where);
        } catch (Exception $e) {}
        
        if (! isset($data['driverId']) || empty($data['driverId'])) {
            $lastId = $db->lastInsertId();
            $where = array();
        } else {
            $lastId = $data['driverId'];
            $where = '`driver_id` = ' . $driverId;
        }
        
        try {
            $saveCar = $db->$action('taxi_car_info', array(
                'driver_id' => $lastId,
                'commission' => $data['car']['commission'],
                'commission_period_pay' => $data['car']['commission_period_pay'],
                'fee' => $data['car']['fee'],
                'fee_period' => $data['car']['fee_period'],
                'tariff_ind' => $data['car']['tariff_ind'],
                'self_carport' => isset($data['car']['self_carport']) ? 1 : 0,
                'terminal' => isset($data['car']['terminal']) && ! empty($data['car']['terminal']) ? 1 : 0,
                'number' => $data['car']['number'],
                'model' => $data['car']['model'],
                'color' => $data['car']['color'],
                'year' => $data['car']['year'],
                'type' => $data['car']['type'],
                'condition' => isset($data['car']['condition']) && ! empty($data['car']['condition']) ? 1 : 0,
                'notes' => $data['car']['notes']
            ), $where);
        } catch (Exception $e) {}
        
        try {
            if (! isset($data['driverId']) || empty($data['driverId']))
                $saveStatus = $db->insert('taxi_status', array(
                    'taxi_id' => $lastId,
                    // 'status' => $data['taxi']['status']
                    'status' => 5
                ));
            else
                $saveStatus = $db->update('taxi_status', array(
                    'status' => $data['taxi']['status']
                ), "`taxi_id` = $lastId");
        } catch (Exception $e) {}
        
        if ($saveDriver && $saveCar) {
            return $lastId;
        }
        return false;
    }

    public function getCarTypes()
    {
        $db = $this->getDbCentral();
        
        $types = $db->select('SELECT id, type FROM taxi_car_type');
        return $types;
    }

    public function driverFree($id)
    {
        $db = $this->getDbCentral();
        $db->update('taxi_driver_info', array(
            'status' => 0
        ), "`id` = $id");
        return true;
    }

    public function driverPause($id)
    {
        $db = $this->getDbCentral();
        $db->update('taxi_driver_info', array(
            'status' => 3
        ), "`id` = $id");
        return true;
    }

    public function setLocation($driverId, $loc)
    {
        $db = $this->getDbCentral();
        if ($db->update('taxi_status', array(
            'lat' => $loc['lat'],
            'lng' => $loc['lng'],
            'location_update' => date('Y-m-d H:i:s')
        ), "`taxi_id` = $driverId"))
            return true;
        return false;
    }

    public function setPushRegistrationId($id, $password, $gRegId)
    {
        $db = $this->getDbCentral();
        if ($db->update('taxi_driver_info', array(
            'g_reg_id' => $gRegId
        ), "`id` = $id"))
            return true;
    }

    public function getPushRegistrationId($id = null, $status = 1, $exceptDriver = null)
    {
        $db = $this->getDbCentral();
        
        if (is_array($id)) {
            $id = implode(',', $id);
            $result = $db->select('SELECT id, g_reg_id FROM taxi_driver_info WHERE g_reg_id != \'\' AND taxi_driver_info.id IN (' . $id . ')');
            // $result = $db->select('SELECT GROUP_CONCAT(g_reg_id) FROM
            // taxi_driver_info WHERE g_reg_id != \'\' AND taxi_driver_info.id
            // IN (:ids)', array(':ids' => $id));
            // $result = explode(',', $result[0]['GROUP_CONCAT(g_reg_id)']);
            if (count($result) > 0) {
                return $result;
            }
        }
        
        if ($id == null) {
            $result = $db->select('SELECT
                    taxi_driver_info.id, 
                    g_reg_id, 
                    taxi_status.status 
                FROM 
                    taxi_driver_info 
                INNER JOIN 
                    taxi_status 
                WHERE 
                    g_reg_id != \'\' 
                AND taxi_status.taxi_id = taxi_driver_info.id 
                AND taxi_status.status = :status', array(
                ':status' => $status
            ));
            // $result = $db->select('SELECT GROUP_CONCAT(g_reg_id) FROM
            // taxi_driver_info INNER JOIN taxi_status WHERE g_reg_id != \'\'
            // AND
            // taxi_status.taxi_id = id AND taxi_status.status = :status',
            // array(':status' => $status));
            // $result = explode(',', $result[0]['GROUP_CONCAT(g_reg_id)']);
        } else {
            $result = $db->select('SELECT g_reg_id FROM taxi_driver_info WHERE id = :id', array(
                ':id' => $id
            ));
        }
        
        if (count($result) > 0) {
            return $result;
        }
        return false;
    }
    
    /*
     * public function getDriverStatus($callsign) { $db = $this->getDbCentral(); $result = $db->select('SELECT taxi_driver_info.id, taxi_status.status FROM taxi_driver_info INNER JOIN taxi_status WHERE callsign = :callsign AND taxi_status.taxi_id = taxi_driver_info.id', array(':callsign' => $callsign)); return $result[0]['status']; }
     */
    public function getDriverStatus($id)
    {
        $db = $this->getDbCentral();
        $result = $db->select('SELECT taxi_driver_info.id, taxi_status.status FROM taxi_driver_info INNER JOIN taxi_status WHERE taxi_driver_info.id = :id AND taxi_status.taxi_id = taxi_driver_info.id', array(
            ':id' => $id
        ));
        return $result[0]['status'];
    }

    public function findDriver($lat, $lng, $exceptDriverId = null, $message = true)
    {
        $db = $this->getDbCentral();
        
        if ($exceptDriverId == null) {
            $AND = '';
            $bindArray = array();
        } else {
            $AND = ' AND taxi_driver_info.id != :exceptDriverId';
            $bindArray = array(
                ':exceptDriverId' => $exceptDriverId
            );
        }
        
        $drivers = $db->select('SELECT 
                    taxi_driver_info.id, 
                    taxi_driver_info.callsign, 
                    taxi_status.status, 
                    taxi_status.lat, 
                    taxi_status.lng, 
                    taxi_status.status_update 
                FROM 
                    taxi_driver_info
                LEFT OUTER JOIN taxi_status ON taxi_status.taxi_id = taxi_driver_info.id
                WHERE 
                    taxi_status.status = 1' . $AND . ' ORDER BY taxi_status.status_update', $bindArray);
        
        $driverList = array();
        
        $i = 0;
        foreach ($drivers as $driver) {
            $driverList[$i]['id'] = $driver['id'];
            $driverList[$i]['callsign'] = $driver['callsign'];
            $str_date = $driver['status_update'];
            $date_elems = explode(" ", $str_date);
            $date = explode("-", $date_elems[0]);
            $time = explode(":", $date_elems[1]);
            $updateTime = mktime($time[0], $time[1], $time[2], $date[1], $date[2], $date[0]);
            $driverList[$i]['updated'] = $updateTime;
            $driverList[$i]['distance'] = $this->getDistanceBetweenPointsNew($lat, $lng, $driver['lat'], $driver['lng']);
            $i ++;
        }
        
        // print_r($driverList);
        
        $distance = array();
        
        for ($i = 0; $i < count($driverList); $i ++) {
            if ($driverList[$i]['distance'] < 300) {
                $distance['300'][] = $driverList[$i];
            }
            
            if ($driverList[$i]['distance'] > 300 && $driverList[$i]['distance'] < 5000) {
                $distance['5000'][] = $driverList[$i];
            }
        }
        
        ksort($distance);
        
        foreach ($distance as $key => $value) {
            if ($key == '300') {
                if (count($distance[$key]) > 1) {
                    for ($i = 0; $i < count($distance[$key]); $i ++) {
                        for ($j = 0; $j < count($distance[$key]); $j ++) {
                            if ($distance[$key][$i]['updated'] < $distance[$key][$j]['updated']) {
                                $tmp = $distance[$key][$j];
                                $distance[$key][$j] = $distance[$key][$i];
                                $distance[$key][$i] = $tmp;
                            }
                        }
                    }
                }
            } else {
                if (count($distance[$key]) > 1) {
                    for ($i = 0; $i < count($distance[$key]); $i ++) {
                        for ($j = 0; $j < count($distance[$key]); $j ++) {
                            if ($distance[$key][$i]['distance'] < $distance[$key][$j]['distance']) {
                                $tmp = $distance[$key][$j];
                                $distance[$key][$j] = $distance[$key][$i];
                                $distance[$key][$i] = $tmp;
                            }
                        }
                    }
                }
            }
        }
        
        // print_r($distance);
        
        $callsigns = array(); // print_r($distance);
        
        if (isset($distance['300']) && count($distance['300']) > 0) {
            foreach ($distance['300'] as $dFirst) {
                $callsigns[] = $dFirst['callsign'];
            }
        }
        
        if (isset($distance['5000']) && count($distance['5000']) > 0) {
            foreach ($distance['5000'] as $dSecond) {
                $callsigns[] = $dSecond['callsign'];
            }
        }
        
        if (empty($distance)) {
            if ($message)
                return array(
                    'message' => 'Заказ будет отправлен в свободный эфир'
                );
            return null;
        }
        return $callsigns;
    }

    public function findDriver2($lat, $lng, $exceptDriverId = null, $message = true)
    {
        $db = $this->getDbCentral();
        
        if ($exceptDriverId == null) {
            $AND = '';
            $bindArray = array();
        } else {
            $AND = ' AND taxi_driver_info.id != :exceptDriverId';
            $bindArray = array(
                ':exceptDriverId' => $exceptDriverId
            );
        }
        
        $drivers = $db->select('SELECT 
                    taxi_driver_info.id, 
                    taxi_driver_info.callsign, 
                    taxi_status.status, 
                    taxi_status.lat, 
                    taxi_status.lng, 
                    taxi_status.status_update 
                FROM 
                    taxi_driver_info
                LEFT OUTER JOIN taxi_status ON taxi_status.taxi_id = taxi_driver_info.id
                WHERE 
                    taxi_status.status = 1' . $AND . ' ORDER BY taxi_status.status_update', $bindArray);
        
        $driverList = array();
        
        $i = 0;
        foreach ($drivers as $driver) {
            $driverList[$i]['id'] = $driver['id'];
            $driverList[$i]['callsign'] = $driver['callsign'];
            $str_date = $driver['status_update'];
            $date_elems = explode(" ", $str_date);
            $date = explode("-", $date_elems[0]);
            $time = explode(":", $date_elems[1]);
            $updateTime = mktime($time[0], $time[1], $time[2], $date[1], $date[2], $date[0]);
            $driverList[$i]['updated'] = $updateTime;
            $driverList[$i]['distance'] = $this->getDistanceBetweenPointsNew($lat, $lng, $driver['lat'], $driver['lng']);
            $i ++;
        }
        
        // print_r($driverList);
        
        $distance = array();
        
        for ($i = 0; $i < count($driverList); $i ++) {
            if ($driverList[$i]['distance'] < 300) {
                $distance['300'][] = $driverList[$i];
            }
            
            if ($driverList[$i]['distance'] > 300 && $driverList[$i]['distance'] < 5000) {
                $distance['5000'][] = $driverList[$i];
            }
        }
        
        ksort($distance);
        
        foreach ($distance as $key => $value) {
            if ($key == '300') {
                if (count($distance[$key]) > 1) {
                    for ($i = 0; $i < count($distance[$key]); $i ++) {
                        for ($j = 0; $j < count($distance[$key]); $j ++) {
                            if ($distance[$key][$i]['updated'] < $distance[$key][$j]['updated']) {
                                $tmp = $distance[$key][$j];
                                $distance[$key][$j] = $distance[$key][$i];
                                $distance[$key][$i] = $tmp;
                            }
                        }
                    }
                }
            } else {
                if (count($distance[$key]) > 1) {
                    for ($i = 0; $i < count($distance[$key]); $i ++) {
                        for ($j = 0; $j < count($distance[$key]); $j ++) {
                            if ($distance[$key][$i]['distance'] < $distance[$key][$j]['distance']) {
                                $tmp = $distance[$key][$j];
                                $distance[$key][$j] = $distance[$key][$i];
                                $distance[$key][$i] = $tmp;
                            }
                        }
                    }
                }
            }
        }
        
        print_r($distance);
        
        $callsigns = array(); // print_r($distance);
        
        if (isset($distance['300']) && count($distance['300']) > 0) {
            foreach ($distance['300'] as $dFirst) {
                $callsigns[] = $dFirst['callsign'];
            }
        }
        
        if (isset($distance['5000']) && count($distance['5000']) > 0) {
            foreach ($distance['5000'] as $dSecond) {
                $callsigns[] = $dSecond['callsign'];
            }
        }
        
        if (empty($distance)) {
            if ($message)
                return array(
                    'message' => 'Заказ будет отправлен в свободный эфир'
                );
            return null;
        }
        return $callsigns;
    }

    function getDistanceBetweenPointsNew($latitude1, $longitude1, $latitude2, $longitude2)
    {
        $theta = $longitude1 - $longitude2;
        $miles = (sin(deg2rad($latitude1)) * sin(deg2rad($latitude2))) + (cos(deg2rad($latitude1)) * cos(deg2rad($latitude2)) * cos(deg2rad($theta)));
        $miles = acos($miles);
        $miles = rad2deg($miles);
        $miles = $miles * 60 * 1.1515;
        $feet = $miles * 5280;
        $yards = $feet / 3;
        $kilometers = $miles * 1.609344;
        $meters = $kilometers * 1000;
        // return compact('miles','feet','yards','kilometers','meters');
        return $meters;
    }

    public static function checkDriver($driver, $password, $sessionId)
    {
        if (isset($_SESSION['driverId']) && $_SESSION['driverId'] == $driver) {
            if (isset($_SESSION['sessId']) && $_SESSION['sessId'] == $sessionId) {
                return true;
            }
        }
        return false;
    }

    public function setDriverStatus($id, $newStatus)
    {
        switch ($newStatus) {
            case 'FREE':
                $status = 1;
                break;
            case 'BUSY':
                $status = 4;
                break;
            case 'OFFLINE':
                $status = 5;
                break;
        }
        
        $db = $this->getDbCentral();
        if ($db->update('taxi_status', array(
            'status' => $status,
            'status_update' => date('Y-m-d H:i:s')
        ), "`taxi_id` = $id"))
            return true;
        return false;
    }

    public function getSession($id)
    {
        $db = $this->getDbCentral();
        return $db->select('SELECT session_id FROM taxi_driver_info WHERE id = :id', array(
            ':id' => $id
        ));
    }

    public function getDriverCallsign($id = null)
    {
        $db = $this->getDbCentral();
        
        $where = $id != null ? " WHERE id = $id" : '';
        
        return $db->select('SELECT id, callsign FROM taxi_driver_info' . $where);
    }

    public function getOnlineDrivers()
    {
        $db = $this->getDbCentral();
        
        $drivers = $db->select('SELECT 
				taxi_driver_info.id,
				taxi_driver_info.callsign, 
				taxi_status.status,
				taxi_status.lat,
				taxi_status.lng
			FROM 
				taxi_driver_info 
			INNER JOIN 
				taxi_status 
			WHERE
				taxi_status.status != 5
			AND taxi_status.status != 0
			AND taxi_status.taxi_id = taxi_driver_info.id');
        return $drivers;
    }
}
