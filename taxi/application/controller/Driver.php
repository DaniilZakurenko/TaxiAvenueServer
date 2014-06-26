<?php

class Application_Controller_Driver extends Engine_Controller
{

    private $model = null;

    public function __construct()
    {
        $this->model = new Application_Model_Driver();
    }

    public function getDriverList()
    {
        $sortField = isset($_POST['sortField']) ? $_POST['sortField'] : 'id';
        $sortDir = isset($_POST['sortDir']) ? $_POST['sortDir'] : 'ASC';
        
        $limit = isset($_POST['limit']) ? (int) $_POST['limit'] : null;
        $offset = isset($_POST['offset']) ? (int) $_POST['offset'] : null;
        $sortField = isset($_POST['sortField']) ? $_POST['sortField'] : null;
        $sortDir = isset($_POST['sortDir']) ? $_POST['sortDir'] : null;
        
        $filter = isset($_POST['filter']) ? $_POST['filter'] : null;
        
        $driverList = $this->model->getDriverList($offset, $limit, $sortField, $sortDir, $filter);

        // $typeList = $this->model->getCarTypes();
        echo json_encode($driverList);
    }

    public function getDriverById()
    {
        $driverId = isset($_POST['driverId']) ? $_POST['driverId'] : null;
        if ($driverId != null) {
            $types = $this->model->getCarTypes();
            
            $driverId = str_replace('driver', '', $driverId);
            $result = $this->model->getDriverById($driverId);
            
            $str = '';
            $str .= '<ul class="driverDetailInfo_ul driverDetailInfo_li1">';
            // $str .= '<li><label>Фамилия</label><input class="disabledField" type="text" name="driver[surname]" value="'.$result[0]['surname'].'" disabled></li>';
            // $str .= '<li><label>Имя</label><input class="disabledField" type="text" name="driver[name]" value="'.$result[0]['name'].'" disabled></li>';
            // $str .= '<li><label>Отчество</label><input class="disabledField" type="text" name="driver[patronymic]" value="'.$result[0]['patronymic'].'" disabled></li>';
            // $str .= '<li><label>Тел.1:</label><input class="disabledField" type="text" name="driver[mobile_phone]" value="'.$result[0]['mobile_phone'].'" disabled></li>';
            $str .= '<li class="driverDetailInfo_li"><label>Тел.2:</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="driver[phone2]" value="' . $result[0]['phone2'] . '" disabled></li>';
            $str .= '<li><label>Адрес:</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="driver[address1]" value="' . $result[0]['address1'] . '" disabled></li>';
            $str .= '<li><label>Паспорт:</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="driver[passport]" value="' . $result[0]['passport'] . '" disabled></li>';
            $str .= '<li><label>Дата рождения:</label><input class="datepicker disabledField  driverDetailInfo_ul_input" type="text" name="driver[dob]" value="' . $result[0]['dob'] . '" disabled></li>';
            $str .= '<li><label>Дата приёма:</label><input class="datepicker disabledField driverDetailInfo_ul_input" type="text" name="driver[admission_date]" value="' . $result[0]['admission_date'] . '" disabled></li>';
            $str .= '<li><label>Дата увольнения:</label><input class="datepicker disabledField driverDetailInfo_ul_input" type="text" name="driver[dismissal_date]" value="' . $result[0]['dismissal_date'] . '" disabled></li>';
            $str .= '<li><label>Пароль:</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="driver[password]"></li>';
            $str .= '</ul>';
            
            $str .= '<ul class="driverDetailInfo_ul">';
            $str .= '<li><label><input type="checkbox" name="driver[see_non_cash]"';
            if (isset($str[0]['see_non_cash'])) {
                if ($str[0]['see_non_cash'] == true)
                    $str .= ' checked';
            }
            $str .= ' disabled>Видимость заказа по безнал</label></li>';
            
            $str .= '<li><label><input type="checkbox" name="driver[only_non_cash]"';
            if (isset($str[0]['only_non_cash'])) {
                if ($str[0]['only_non_cash'] == true)
                    $str .= ' checked';
            }
            $str .= ' disabled>Видит только безнал. если долг</label></li>';
            
            $str .= '<li><label><input type="checkbox" name="driver[passenger_phone]"';
            if (isset($str[0]['passenger_phone'])) {
                if ($str[0]['passenger_phone'] == true)
                    $str .= ' checked';
            }
            $str .= 'disabled>Видит телефон пассажира</label></li>';
            
            $str .= '<li><label><input type="checkbox" name="car[terminal]"';
            if (isset($str[0]['terminal'])) {
                if ($str[0]['terminal'] == true)
                    $str .= ' checked';
            }
            $str .= 'disabled>Терминал</label></li>';
            
            $str .= '<li><label><input type="checkbox" name="car[condition]"';
            if (isset($str[0]['condition'])) {
                if ($str[0]['condition'] == true)
                    $str .= ' checked';
            }
            $str .= 'disabled>Кондиционер</label></li>';
            
            // $str .= '<li><label>№ лицензии:</label><input type="text" name="driver[dismissal_date]" value="'.$result[0]['dismissal_date'].'"></li>';
            $str .= '<li><label>Год выпуска:</label><input class="disabledField driverDetailInfo_ul_input"  type="text" name="car[year]" value="' . $result[0]['year'] . '" disabled></li>';
            $str .= '<li><label>Комиссия:</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="car[commission]" value="' . $result[0]['commission'] . '" disabled></li>';
            $str .= '<li><label>Комиссия (период, грн):</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="car[commission_period_pay]" value="' . $result[0]['commission_period_pay'] . '" disabled></li>';
            $str .= '<li><label>Абонплата:</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="car[fee]" value="' . $result[0]['fee'] . '" disabled></li>';
            $str .= '<li><label>Абонплата (период, грн):</label><input class="disabledField driverDetailInfo_ul_input" type="text" name="car[fee_period]" value="' . $result[0]['fee_period'] . '" disabled></li>';
            $str .= '<li><label>Индивидуальный тариф:</label><input type="text"  class=" disabledField  driverDetailInfo_ul_input" name="car[tariff_ind]" value="' . $result[0]['tariff_ind'] . '" disabled></li>';
            
            if (! empty($types)) {
                $str .= '<li><label style="float: left">Тариф:</label><select name="car[type]" disabled style="opacity: 0.5;">';
                foreach ($types as $type) {
                    $str .= '<option value="' . $type['id'] . '">' . $type['type'] . '</option>';
                }
                $str .= '</select></li>';
            }
            
            $str .= '</ul>';
            
            $str .= '<div class="driverDetailInfo_ul ">';
            
            $str .= '<div class="driverPhotoAll" > ';
            $str .= '<input id="driverPhotoUploadButton" type="file" name="driverPhoto" style="display: none;">';
            $str .= '<div id="driverPhotoPreview">';
            if (! empty($result[0]['photo']))
                $str .= '<li><img src="/uploads/driverPhoto/' . $result[0]['photo'] . '"></li>';
            else
                $str .= '<img src="../images/background_Preview_picture.png"/>';
            $str .= '</div>';
            $str .= '<button id="openFileDialogButton" onclick="openFileDialog(\'driverPhotoUploadButton\');" type="button" style="display: none">Загрузить</button>';
            
            $str .= '<input id="driverSaveButton" class="saveDriverButton" type="button" onclick="saveEditDriver();" value="Сохранить" style="display: none">';
            $str .= '<input class="editDriverButton"   type="button" onclick="enableFields();" value="Редактировать">';
            $str .= '<input class="cancelEditDriverButton" type="button" onclick="disableFields();" value="Отменить" style="display: none">';
            $str .= '</div>';
            $str .= '</div>';
            echo json_encode($str);
        }
    }

    public function addDriverForm()
    {
        $template = $this->getTemplate('driver/addNewDriver', array(
            'carTypes' => $this->model->getCarTypes()
        ));
        echo $template;
    }

    public function getDriversMap()
    {
        $template = $this->getTemplate('driver/driversMap');
        echo $template;
    }

    public function saveDriver()
    {
        $info = $_POST;
        if (! isset($info['driver'])) {
            echo json_encode(array(
                'result' => array(
                    'status' => 'Error',
                    'nessage' => 'driver info is empty'
                )
            ));
            return;
        }
        if (! isset($info['car'])) {
            echo json_encode(array(
                'result' => array(
                    'status' => 'Error',
                    'nessage' => 'car info is empty'
                )
            ));
            return;
        }
        
        if (isset($_FILES)) {
            if (isset($_FILES['driverPhoto'])) {
                $image = new Lib_File_Image();
                $imageName = $image->saveImage($_FILES['driverPhoto']);
                $info['img'] = $imageName;
            }
        } else {
            $info['img'] = '321312';
        }
        
        $result = $this->model->saveDriver($info);
        if ($result) {
            $driver = $this->model->getDriverById($result);
            echo json_encode(array(
                'result' => array(
                    'status' => 'OK',
                    'driver' => array_shift($driver)
                )
            ));
            return;
        } else {
            echo json_encode(array(
                'result' => array(
                    'status' => 'Error'
                )
            ));
            return;
        }
    }

    public function findDriver()
    {
        $result = $this->model->findDriver($_POST['lat'], $_POST['lng']);
        
        echo json_encode($result);
        return;
    }

    public function getDriverCallsign($id = null)
    {
        return $this->model->getDriverCallsign($id);
    }

    public function getDriverByCallsign()
    {
        $callsign = isset($_POST['callsign']) ? $_POST['callsign'] : null;
        if (! null) {
            $driver = $this->model->getDriverByCallsign($callsign);
            if (count($driver) > 0)
                echo json_encode(array(
                    'error' => 'Водитель с данным позывным уже существует'
                ));
            else
                echo json_encode(array(
                    'response' => 'OK'
                ));
        }
    }

    public function getOnlineDrivers()
    {
        $drivers = $this->model->getOnlineDrivers();
        $statusModel = new Application_Model_Status();
        $statusList = $statusModel->getStatusList();
        
        $status = array();
        for ($i = 0, $statusCnt = count($statusList); $i < $statusCnt; $i ++) {
            $status[$statusList[$i]['id']] = $statusList[$i]['name'];
        }
        
        for ($i = 0, $driverCnt = count($drivers); $i < $driverCnt; $i ++) {
            $drivers[$i]['statusName'] = $status[$drivers[$i]['status']];
        }
        
        echo json_encode($drivers);
    }
}