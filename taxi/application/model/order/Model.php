<?php

class Application_Model_Order_Model extends Engine_Model
{

    public function __construct()
    {
        $this->db = $this->getDbCentral();
        $this->sql = new Application_Model_Order_Sql();
    }

    public function createOrder($orderData)
    {
        $orderFactory = new Application_Model_Order_EntityFactory($this->db, $this->sql);
        
        $payment = isset($orderData['nonCashPayment']) ? 'non_cash_payment_tarif' : 'cash_payment_tarif';
        $tariffGrid = $this->db->select('SELECT * FROM ' . $payment . ' WHERE type = ' . $orderData['tarif']);
        
        $order = $orderFactory->create($orderData, $tariffGrid);
        return $order;
    }

    public function getOrder($orderId = 0, $orderField = '', $filter = '')
    {
        $orderFactory = new Application_Model_Order_EntityFactory($this->db, $this->sql);
        $order = $orderFactory->get($orderId, $orderField, $filter);
        
        if (! empty($order)) {
            $orderList = array();
            foreach ($order as $orderEntity)
                $orderList[] = get_object_vars($orderEntity);
            
            return $orderList;
        }
        return false;
    }

    public function getOrderList()
    {}

    public function setSort(Application_Model_Order_Sort $sort)
    {}
}