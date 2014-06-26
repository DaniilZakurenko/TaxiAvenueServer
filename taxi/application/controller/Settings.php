<?php

class Application_Controller_Settings extends Engine_Controller
{

    public function __construct()
    {}

    public function showSettings()
    {
        echo $this->getTemplate('settings/index');
    }

    public function showTariffing()
    {
        echo $this->getTemplate('settings/tariffing');
    }

    public function getTarifGrid()
    {
        $model = new Application_Model_Dispatcher_Settings();
        echo $this->getTemplate('settings/paymentTarif', array(
            'tarif' => $model->getTarifGrid($_REQUEST['type']),
            'type' => $_REQUEST['type']
        ));
    }

    public function saveTarif()
    {
        $model = new Application_Model_Dispatcher_Settings();

        if (isset($_POST['type']) && ($_POST['type'] == 'cash_payment_tarif' || $_POST['type'] == 'non_cash_payment_tarif')) {
            $data = isset($_POST['data']) ? $_POST['data'] : null;
            $type = $_POST['type'];
            $model->saveTarifGrid($type, $data);
            
            echo json_encode(array('response' => 'OK'));
            return true;
        }
        echo json_encode(array('error' => 'Db error'));
        return false;
    }
}