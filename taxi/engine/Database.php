<?php

class Engine_Database extends PDO {
	
	private $options = array(
			PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'
			);
	
	public function __construct($DB_TYPE, $DB_HOST, $DB_NAME, $DB_USER, $DB_PASS) {
		parent::__construct($DB_TYPE . ':host=' . $DB_HOST . ';dbname=' . $DB_NAME, $DB_USER, $DB_PASS, $this->options);
		
		parent::setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	}
	
	public function select($sql, $array = array(), $fetchMode = PDO::FETCH_ASSOC) {
		$sth = $this->prepare($sql);
		foreach($array as $key => $value) {
			$sth->bindValue("$key", $value);
		}
		
		$sth->execute();
		return $sth->fetchAll($fetchMode);
	}
	
	public function insert($table, $data) {
		ksort($data);
		
		$fieldNames = implode('`, `', array_keys($data));
		$fieldValues = ':' . implode(', :', array_keys($data));
		
		$sth = $this->prepare("INSERT INTO $table (`$fieldNames`) VALUES ($fieldValues)");
		
		foreach ($data as $key => $value) {
			$sth->bindValue(":$key", $value);
		}
		
		if($sth->execute()) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public function update($table, $data, $where) {
		ksort($data);
		
		$fieldDetails = null;
		foreach($data as $key => $value) {
			$fieldDetails .= "`$key`=:$key,";
		}
		
		$fieldDetails = rtrim($fieldDetails, ',');
		
		$fieldNames = implode('`, `', array_keys($data));
		$fieldValues = ':'.implode(', :', array_keys($data));
		
		$sth = $this->prepare("UPDATE $table SET $fieldDetails WHERE $where");
		
		foreach($data as $key => $value) {
			$sth->bindValue(":$key", $value);
		}
		
		if($sth->execute()) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public function delete($table, $where) {
		return $this->exec("DELETE FROM $table WHERE $where");
	}
	
	
}