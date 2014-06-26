<?php

class Application_Model_Status_Sql
{

    public function __construct()
    {}

    public function getStatusQueryString()
    {
        $query = 'SELECT status_id AS id, name, type FROM status_list';
        
        $statusGetQuery = new stdClass();
        $statusGetQuery->query = $query;
        return $statusGetQuery;
    }
}