<?php

class Application_Model_Status_Model extends Engine_Model
{

    public function __construct()
    {
        $this->db = $this->getDbCentral();
        $this->sql = new Application_Model_Status_Sql();
    }

    public function getStatusList()
    {
        $statusList = $this->db->select($this->sql->getStatusQueryString()->query, array());
        return $statusList;
    }
}