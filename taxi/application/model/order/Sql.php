<?php

class Application_Model_Order_Sql
{

    public function __construct()
    {}
    /*
     * public function getSql($sqlQueryMethod) { if (property_exists(get_class($this), $sqlQueryMethod)) return $this->$sqlQueryMethod; else { return false; } }
     */
    public function getOrderQueryString($orderId, $orderBy, $filter)
    {
        $query = 'SELECT
                    order_list.id AS orderId,
                    order_list.dispatcher AS dispatcherId,
                    order_list.driver AS driverId,
                    order_list.customer AS customerId,
                    taxi_driver_info.callsign AS callsign,
                    order_cl_info.name AS name,
                    order_cl_info.phone AS phone,
                    order_info.type,
                    order_info.cost AS cost,
                    order_info.payment,
                    order_info.tarif_id AS tarifId,
                    order_info.length,
                    order_info.dispatcher_note,
                    order_info.tarif_id,
                    order_properties.airCondition,
                    order_properties.salonLoading,
                    order_properties.animal,
                    order_properties.city,
                    order_properties.courierDelivery,
                    order_properties.terminal,
                    order_properties.namesign,
                    order_properties.hour,
                    order_properties.grach,
                    order_properties.ticket,
                    order_status.status,
                    order_time.add AS createDateTime,
                    order_time.take AS takeDateTime,
                    order_time.arrive AS arriveDateTime,
                    order_time.start AS startDateTime,
                    order_time.update AS updateDateTime,
                    order_time.finish AS finishDateTime
                FROM 
                    order_list
                LEFT OUTER JOIN 
                    taxi_driver_info ON order_list.driver = taxi_driver_info.id
                LEFT OUTER JOIN 
                    order_cl_info ON order_list.id = order_cl_info.order_id
                LEFT OUTER JOIN 
                    order_info ON order_list.id = order_info.order_id
                LEFT OUTER JOIN 
                    order_status ON order_list.id = order_status.order_id
                LEFT OUTER JOIN 
                    order_properties ON order_list.id = order_properties.order_id
                LEFT OUTER JOIN 
                    order_time ON order_list.id = order_time.order_id';
        
        $query .= $orderBy;
        
        $orderId = (int) $orderId;
        if ($orderId) {
            $query .= ' WHERE order_list.id = :id';
            $where = array(
                ':id' => $orderId
            );
        } else {
            $where = array();
        }
        
        $orderGetQuery = new stdClass();
        $orderGetQuery->query = $query;
        $orderGetQuery->where = $where;
        return $orderGetQuery;
    }

    public function saveOrderQuery()
    {}

    public function updateOrderQuery()
    {}

    public function getOrderPointsQueryString($orderId)
    {
        $query = 'SELECT point_id, point, location FROM order_points WHERE order_id = :id';
        $where = array(
            ':id' => (int) $orderId
        );
        
        $orderPointsGetQuery = new stdClass();
        $orderPointsGetQuery->query = $query;
        $orderPointsGetQuery->where = $where;
        return $orderPointsGetQuery;
    }

    public function saveOrderPointsQuery()
    {}

    public function updateOrderPointsQuery()
    {}
}