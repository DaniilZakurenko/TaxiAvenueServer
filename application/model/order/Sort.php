<?php

class Application_Model_Order_Sort
{

    protected $sqlSortString = ' ORDER BY ';

    protected $sortableFields = '';

    public function __construct($sortableFields)
    {
        $this->sortableFields = $sortableFields; // $sortableFields
    }
    
    /*
     * $fields = array('field' => 'direction);
     */
    public function getSqlSortString($sortField, $dir = 'DESC')
    {
        if (! empty($sortField)) {
            if (array_key_exists($sortField, $this->sortableFields)) {
                $this->sqlSortString .= $this->sortableFields[$sortField]['table'] . '.' . $this->sortableFields[$sortField]['field'] . ' ' . $dir;
                return $this->sqlSortString;
            }
        }
        return '';
    }
}