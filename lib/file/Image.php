<?php

class Lib_File_Image {
	
	private $savePath;
	
	public function __construct() {
		$this->savePath = $_SERVER['DOCUMENT_ROOT'].'/uploads/driverPhoto/';
	}
	
	public function saveImage($image, $path = '') {
		if(empty($path)) $path = $this->savePath;
		if(move_uploaded_file($image['tmp_name'], $path.$image['name']))
			return $image['name'];
	}
	
}