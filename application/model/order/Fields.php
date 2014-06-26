<?php

class Application_Model_Order_Fields
{

    private $fields = array(
        'orderId' => array(
            'table' => 'order_list',
            'field' => 'id'
        ),
        'status' => array(
            'table' => 'order_status',
            'field' => 'status'
        ),
        'callsign' => array(
            'table' => 'driver_info',
            'field' => 'callsign'
        ),
        'firstPoint' => array(
            'table' => 'order_points',
            'field' => 'point',
            'addField' => array(
                'point_id' => 0
            )
        ),
        'lastPoint' => array(
            'table' => 'order_points',
            'field' => 'point',
            'addField' => array(
                'point_id' => ''
            )
        ),
        'clientPhone' => array(
            'table' => 'customer',
            'field' => 'phone'
        ),
        'cost' => array(
            'table' => 'order_info',
            'field' => 'cost'
        ),
        'arriveDatetime' => array(
            'table' => 'order_time',
            'field' => 'arrive'
        ),
        'length' => array(
            'table' => 'order_info',
            'field' => 'length'
        ),
        'createDatetime' => array(
            'table' => 'order_time',
            'field' => 'arrive'
        ),
        'dispatcherId' => array(
            'table' => 'order_list',
            'field' => 'dispatcher'
        ),
        'tarifId' => array(
            'table' => 'order_info',
            'field' => 'tarif_id'
        )
    );

    function __construct()
    {}

    public function getSortableFields()
    {
        if (! empty($this->fields))
            return $this->fields;
        else
            return array();
    }
}