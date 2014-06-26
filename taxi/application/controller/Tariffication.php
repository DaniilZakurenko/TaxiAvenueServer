<?php

class Application_Controller_Tariffication extends Engine_Controller
{

    public function showCommonTariffication()
    {
        $model = new Application_Model_Tariffication();
        $additionalServices = $model->getAdditionalServices();
        $commonTariffication = $model->getCommonTariffication();
        $template = $this->getTemplate('tariffication/commonTariffication', array(
            'additionalServices' => $additionalServices,
            'commonTariffication' => $commonTariffication
        ));
        echo $template;
    }

    public function saveCommonTariffication()
    {
        $model = new Application_Model_Tariffication();
        
        if (isset($_POST['commonTariff'])) {
            $commonTariff = $_POST['commonTariff'];
            $model->saveCommonTariffication($commonTariff);
        } else {
            echo json_encode(array(
                'error' => 'Db error'
            ));
            return false;
        }
        
        if (isset($_POST['additionalService'])) {
            $additionalService = $_POST['additionalService'];
            $model->saveAdditionalServices($additionalService);
        } else {
            echo json_encode(array(
                'error' => 'Db error'
            ));
            return false;
        }
        
        echo json_encode(array(
            'response' => 'OK'
        ));
        return true;
    }
}