<?php

class Application_Model_Order_EntityFactory
{

    protected $db = '';

    protected $sql = '';

    public function __construct(Engine_Database $db, Application_Model_Order_Sql $sql)
    {
        $this->db = $db;
        $this->sql = $sql;
    }

    public function get($orderId = 0, $sortField, $filter)
    {
        $sortFields = new Application_Model_Order_Fields();
        $sortFieldsList = $sortFields->getSortableFields();
        
        $sort = new Application_Model_Order_Sort($sortFieldsList);
        $orderSelect = $this->sql->getOrderQueryString($orderId, $sort->getSqlSortString($sortField['field'], $sortField['dir']), $filter);
        
        $order = $this->db->select($orderSelect->query, $orderSelect->where);
        
        if (! empty($order)) {
            $orderList = array();
            for ($i = 0, $orderCnt = count($order); $i < $orderCnt; $i ++)
                $orderList[] = $this->createOrderEntity($order[$i]);
            
            return $orderList;
        }
        
        return false;
    }

    public function create($orderData)
    {
        return $this->createOrderEntity($orderData);
    }

    protected function createOrderEntity($order)
    {
        if (isset($order['orderId']) && $order['orderId'] != 0) {
            $pointsSelect = $this->sql->getOrderPointsQueryString($order['orderId']);
            $points = $this->db->select($pointsSelect->query, $pointsSelect->where);
            
            for ($i = 0, $pointsCnt = count($points); $i < $pointsCnt; $i ++) {
                $points[$i]['location'] = json_decode($points[$i]['location']);
            }
            
            $order['points'] = $points;
            $order['additionalServices'] = $this->setOrderAddServices($order);
            
            $orderEntity = new Application_Model_Order_Entity($order);
        } else {
            $order['additionalServices'] = $this->setOrderAddServices($order);
            $orderEntity = new Application_Model_Order_Entity($order, $this->db);
        }
        return $orderEntity;
    }

    protected function setOrderAddServices($order)
    {
        $addServices['airCondition'] = isset($order['airCondition']) ? $order['airCondition'] : false;
        $addServices['salonLoading'] = isset($order['salonLoading']) ? $order['salonLoading'] : false;
        $addServices['animal'] = isset($order['animal']) ? $order['animal'] : false;
        $addServices['city'] = isset($order['city']) ? $order['city'] : false;
        $addServices['courierDelivery'] = isset($order['courierDelivery']) ? $order['courierDelivery'] : false;
        $addServices['terminal'] = isset($order['terminal']) ? $order['terminal'] : false;
        
        return $addServices;
    }

    protected function prepareInputData()
    {}
}