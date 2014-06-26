<?php

class Application_Controller_Report extends Engine_Controller
{

    public function __construct()
    {
        Engine_Auth::handleLogin();
    }

    public function getDriverReport()
    {
        $model = new Application_Model_Report();
        
        $dateFrom = isset($_POST['dateFrom']) ? $_POST['dateFrom'] : null;
        $dateTo = isset($_POST['dateTo']) ? $_POST['dateTo'] : null;
        
        if ($dateFrom != null && $dateTo != null) {
            $order = $model->getDriverReport($dateFrom, $dateTo);
            
            $orderCount = count($order);
            
            $str = '';
            
            $str .= '<table class="driverReportTable">';
            
            $str .= '<tr>';
            $str .= '<th class="first"><input type="checkbox" name="option" value=""></th>';
            $str .= '<th>Позывной</th>';
            $str .= '<th>Фамилия</th>';
            $str .= '<th>кол-во заказов</th>';
            $str .= '<th>Нал</th>';
            $str .= '<th>Нал %</th>';
            $str .= '<th>Безнал</th>';
            $str .= '<th>Долг компании</th>';
            $str .= '<th>Абонплата</th>';
            $str .= '<th>Рация</th>';
            $str .= '<th>Итого</th>';
            $str .= '<th>Сдал терминал</th>';
            $str .= '<th>Итого сдал</th>';
            $str .= '</tr>';
            
            for ($i = 0; $i < $orderCount; $i ++) {
                $str .= '<tr>';
                $str .= '<td class="first"><input type="checkbox" name="option" value=""></td>';
                $str .= '<td>' . $order[$i]['callsign'] . '</td>';
                $str .= '<td>' . $order[$i]['surname'] . '</td>';
                $str .= '<td>' . $order[$i]['orderCount'] . '</td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<tr>';
            }
            
            $str .= '</table>';
            
            echo json_encode($str);
        } else {
            $order = $model->getDriverReport($dateFrom, $dateTo);
            
            $orderCount = count($order);
            
            $str = '';
            
            $str .= '<table class="driverReportTable">';
            
            $str .= '<tr>';
            $str .= '<th class="first"><input type="checkbox" name="option" value=""></th>';
            $str .= '<th>Позывной</th>';
            $str .= '<th>Фамилия</th>';
            $str .= '<th>кол-во заказов</th>';
            $str .= '<th>Нал</th>';
            $str .= '<th>Нал %</th>';
            $str .= '<th>Безнал</th>';
            $str .= '<th>Долг компании</th>';
            $str .= '<th>Абонплата</th>';
            $str .= '<th>Рация</th>';
            $str .= '<th>Итого</th>';
            $str .= '<th>Сдал терминал</th>';
            $str .= '<th>Итого сдал</th>';
            $str .= '</tr>';
            
            for ($i = 0; $i < $orderCount; $i ++) {
                $str .= '<tr>';
                $str .= '<td class="first"><input type="checkbox" name="option" value=""></td>';
                $str .= '<td>' . $order[$i]['callsign'] . '</td>';
                $str .= '<td>' . $order[$i]['surname'] . '</td>';
                $str .= '<td>' . $order[$i]['orderCount'] . '</td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<td></td>';
                $str .= '<tr>';
            }
            
            $str .= '</table>';
            $template = $this->getTemplate('report/index', array(
                'drivers' => $str
            ));
            echo json_encode($template);
        }
    }

    public function getOrderReportXls()
    {
        $sortField = isset($_POST['sortField']) ? $_POST['sortField'] : 'id';
        $sortDir = isset($_POST['sortDir']) ? $_POST['sortDir'] : 'DESC';
        $filter = isset($_POST['filter']) ? $_POST['filter'] : null;
        $status = isset($filter['status']) ? $filter['status'] : array(
            9,
            10,
            12,
            17,
            18,
            22
        );
        
        $orderModel = new Application_Model_Order();
        $orders = $orderModel->getReport($status, null, null, $sortField, $sortDir, $filter);
        $tarifTypes = $orderModel->getTarifTypes();
        
        $type = array();
        
        for ($i = 0, $tarifTypesCnt = count($tarifTypes); $i < $tarifTypesCnt; $i ++) {
            $type[$tarifTypes[$i]['id']] = $tarifTypes[$i]['type'];
        }
        
        $statusModel = new Application_Model_Status();
        $statusList = $statusModel->getStatusList();
        
        $driverModel = new Application_Model_Driver();
        
        $status = array();
        
        for ($i = 0, $statusCnt = count($statusList); $i < $statusCnt; $i ++) {
            $status[$statusList[$i]['id']] = $statusList[$i]['name'];
        }
        
        require_once $_SERVER['DOCUMENT_ROOT'] . '/lib/PHPExcel/Classes/PHPExcel.php';
        
        // Create new PHPExcel object
        $objPHPExcel = new PHPExcel();
        
        // Set document properties
        $objPHPExcel->getProperties()
            ->setCreator("User Administration System")
            ->setTitle("Userdata")
            ->setSubject("Users")
            ->setDescription("All the Userdata")
            ->setKeywords("42")
            ->setCategory("users");
        
        // Set column names
        $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('A1', 'Last name')
            ->setCellValue('B1', 'First name')
            ->setCellValue('C1', 'Email');
        
        // initialize database and execute SQL-query
        // mysql_connect("HOSTNAME", "USERNAME", "PASSWORD");
        // mysql_select_db("DATABASENAME");
        // $query = "SELECT * FROM users";
        // $result = mysql_query($query);
        
        // $i = 2;
        // while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
        // $objPHPExcel->setActiveSheetIndex(0)
        // ->setCellValue('A' . $i, $row['last_name'])
        // ->setCellValue('B' . $i, $row['first_name'])
        // ->setCellValue('C' . $i, $row['email']);
        // $i ++;
        // }
        
        $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('A' . 1, 'Номер заказа')
            ->setCellValue('B' . 1, 'Статус заказа')
            ->setCellValue('C' . 1, 'Позывной')
            ->setCellValue('D' . 1, 'Начальная точка')
            ->setCellValue('E' . 1, 'Квартира')
            ->setCellValue('F' . 1, 'Подъезд')
            ->setCellValue('G' . 1, 'Конечная точка (и промежуточные)')
            ->setCellValue('H' . 1, 'Телефон')
            ->setCellValue('I' . 1, 'Стоимость')
            ->setCellValue('J' . 1, 'Дата и время подачи')
            ->setCellValue('K' . 1, 'Длина км')
            ->setCellValue('L' . 1, 'Фамилия водителя')
            ->setCellValue('M' . 1, 'Дата и время создания')
            ->setCellValue('N' . 1, 'Диспетчер')
            ->setCellValue('O' . 1, 'Тип заказа')
            ->setCellValue('P' . 1, 'Время закрытия')
            ->setCellValue('Q' . 1, 'Заметки для водителя')
            ->setCellValue('R' . 1, 'Заметки для диспетчера')
            ->setCellValue('S' . 1, 'Платёж');
        
        // We append filters to our columns
        
        $objPHPExcel->getActiveSheet()->setAutoFilter('A1:S1');
        // Set bold to column names
        $objPHPExcel->getActiveSheet()
            ->getStyle("A1:S1")
            ->getFont()
            ->setBold(true);
        
        // Make column width autosize depending on the input length
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('A')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('B')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('C')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('D')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('E')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('F')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('G')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('H')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('I')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('J')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('K')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('L')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('M')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('N')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('O')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('P')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('Q')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('R')
            ->setAutoSize(true);
        $objPHPExcel->getActiveSheet()
            ->getColumnDimension('S')
            ->setAutoSize(true);
        
        $c = 2;
        for ($i = 0, $orderCnt = count($orders); $i < $orderCnt; $i ++) {
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A' . $c, $orders[$i]['orderId']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('B' . $c, $status[$orders[$i]['status']]);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('C' . $c, $orders[$i]['callsign']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('D' . $c, $orders[$i]['points'][0]['point']['street'] . ' ' . $orders[$i]['points'][0]['point']['number']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('E' . $c, $orders[$i]['apartment']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('F' . $c, $orders[$i]['porch']);
            
            $points = '';
            for ($j = 1, $pointCnt = count($orders[$i]['points']); $j < $pointCnt; $j ++) {
                $points .= $orders[$j]['points'][0]['point']['street'] . ' ' . $orders[$j]['points'][0]['point']['number'] . ', ';
            }
            
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('G' . $c, rtrim($points, ', '));
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('H' . $c, $orders[$i]['customerPhone']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('I' . $c, $orders[$i]['cost']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('J' . $c, $orders[$i]['arriveDatetime']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('K' . $c, $orders[$i]['length']);
            
            if (! empty($orders[$i]['driverId'])) {
                $driver = '';
                $driver = $driverModel->getDriverById($orders[$i]['driverId']);
                $driverSurname = $driver[0]['driver_surname'];
            } else
                $driverSurname = '';
            
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('L' . $c, $driverSurname);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('M' . $c, $orders[$i]['createDatetime']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('N' . $c, $orders[$i]['dispatcherId']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('O' . $c, $type[$orders[$i]['tarif_id']]);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('P' . $c, $orders[$i]['finishDatetime']);
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('Q' . $c, 'Заметки для водителя');
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('R' . $c, 'Заметки для диспетчера');
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('S' . $c, $orders[$i]['payment'] == 'cash_payment_tarif' ? 'Нал' : 'Безнал');
            $c ++;
        }
        
        // Rename our worksheet
        $objPHPExcel->getActiveSheet()->setTitle('basic info');
        
        // Set header and footer
        date_default_timezone_set('Europe/Brussels');
        $objPHPExcel->getActiveSheet()
            ->getHeaderFooter()
            ->setOddHeader('&Lleft &CUsers &R' . date('Y-m-d H:i:s'));
        $objPHPExcel->getActiveSheet()
            ->getHeaderFooter()
            ->setOddFooter('&Lleft &RPage &P van &N');
        
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        // $filename = 'userdata.xlsx';
        // We save it in the same directory as this php file
        
        $filepath = 'report/';
        $filename = 'Report ' . date('d-m-Y H:i:s');
        $file_ending = 'xls';
        
        $file = $filepath . $filename . '.' . $file_ending;
        $objWriter->save($file);
        
        $response = array(
            'filepath' => 'http://' . $_SERVER['HTTP_HOST'] . '/' . $file
        );
        echo json_encode($response);
    }
    // // echo '<pre>';
    // // print_r($status);
    // // echo '</pre>';
    // // die();
    // $filepath = 'report/';
    // $filename = 'Report ' . date('d-m-Y H:i:s');
    // $filename = 'Report';
    // $file_ending = "xlsx";
    // // header info for browser
    // // ob_start();
    // // header("Content-Type: application/xls; charset=utf-8");
    // // header("Content-Disposition: attachment; filename=$filename.xls");
    // // header("Pragma: no-cache");
    // // header("Expires: 0");
    // /**
    // * *****Start of Formatting for Excel******
    // */
    // // define separator (defines columns in excel & tabs in word)
    // $sep = "\t"; // tabbed character
    
    // // $header = array(
    // // '#',
    // 'Статус заказа',
    // 'Позывной',
    // 'Начальная точка',
    // 'Квартира',
    // 'Подъезд',
    // 'Конечная точка (и промежуточные)',
    // 'Телефон',
    // 'Стоимость',
    // 'Дата и время подачи',
    // 'Длина км',
    // 'Фамилия водителя',
    // 'Дата и время создания',
    // 'Диспетчер',
    // 'Тип заказа',
    // 'Время закрытия',
    // 'Заметки для водителя',
    // 'Заметки для диспетчера',
    // 'Платёж'
    // // );
    
    // $str = '';
    // $str .= '#' . $sep;
    // $str .= 'Статус заказа' . $sep;
    // $str .= 'Позывной' . $sep;
    // $str .= 'Начальная точка' . $sep;
    // $str .= 'Квартира' . $sep;
    // $str .= 'Подъезд' . $sep;
    // $str .= 'Конечная точка (и промежуточные)' . $sep;
    // $str .= 'Телефон' . $sep;
    // $str .= 'Стоимость' . $sep;
    // $str .= 'Дата и время подачи' . $sep;
    // $str .= 'Длина км' . $sep;
    // $str .= 'Фамилия водителя' . $sep;
    // $str .= 'Дата и время создания' . $sep;
    // $str .= 'Диспетчер' . $sep;
    // $str .= 'Тип заказа' . $sep;
    // $str .= 'Время закрытия' . $sep;
    // $str .= 'Заметки для водителя' . $sep;
    // $str .= 'Заметки для диспетчера' . $sep;
    // $str .= 'Платёж' . $sep;
    
    // $file = $filepath . $filename . '.' . $file_ending;
    
    // $str .= "\n";
    // foreach ($orders as $order) {
    // $str .= $order['orderId'] . "\t";
    // $str .= $status[$order['status']] . "\t";
    // $str .= $order['callsign'] . "\t";
    // // $str .= str_replace(',' , '', $order['address']) . "\t";
    // $str .= $order['points'][0]['point']['street'] . ' ' . $order['points'][0]['point']['number'] . "\t";
    // $str .= $order['apartment'] . "\t";
    // $str .= $order['porch'] . "\t";
    // $points = '';
    // for ($i = 1, $pointCnt = count($order['points']); $i < $pointCnt; $i ++) {
    // $points .= $order['points'][0]['point']['street'] . ' ' . $order['points'][0]['point']['number'] . '|';
    // }
    // $str .= rtrim($points, '|') . "\t";
    // $str .= $order['customerPhone'] . "\t";
    // $str .= $order['cost'] . "\t";
    // $str .= $order['arriveDatetime'] . "\t";
    // $str .= $order['length'] . "\t";
    // if (! empty($order['driverId'])) {
    // $driver = '';
    // $driver = $driverModel->getDriverById($order['driverId']);
    // $driverSurname = $driver[0]['driver_surname'];
    // } else
    // $driverSurname = '';
    // $str .= $driverSurname . "\t";
    // $str .= $order['createDatetime'] . "\t";
    // $str .= $order['dispatcherId'] . "\t";
    
    // $str .= $type[$order['tarif_id']] . "\t";
    // $str .= $order['finishDatetime'] . "\t";
    // $str .= 'Заметки для водителя' . "\t";
    // $str .= $order['dispatcher_note'] . "\t";
    // $str .= $order['payment'] == 'cash_payment_tarif' ? 'Нал' : 'Безнал' . "\t";
    // $str .= "\n";
    // }
    // $str .= "\n";
    
    // // echo $str;
    // // $content = ob_get_contents();
    // // ob_end_clean();
    
    // $fp = fopen($file, 'a+');
    // fwrite($fp, $str);
    // fclose($fp);
    
    // }
    
    // private function arrayToXls($input)
    // {
    // // BoF
    // // $ret = pack('ssssss', 0x809, 0x8, 0x0, 0x10, 0x0, 0x0);
    // $ret = pack("CCC", 0xef, 0xbb, 0xbf);
    
    // // array_values is used to ensure that the array is numerically indexed
    // foreach (array_values($input) as $lineNumber => $row) {
    // foreach (array_values($row) as $colNumber => $data) {
    // if (is_numeric($data)) {
    // // number, store as such
    // $ret .= pack('sssssd', 0x203, 14, $lineNumber, $colNumber, 0x0, $data);
    // } else {
    // // everything else store as string
    // $len = strlen($data);
    // $ret .= pack('ssssss', 0x204, 8 + $len, $lineNumber, $colNumber, 0x0, $len) . $data;
    // }
    // }
    // }
    
    // // EoF
    // $ret .= pack('ss', 0x0A, 0x00);
    
    // return $ret;
    // }
}
