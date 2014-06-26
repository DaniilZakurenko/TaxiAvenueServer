<?php

include_once '../config/config.php';

function __autoload($class) {
	$path = explode("_", $class);
	$fileName = array_pop($path);

	$pathCount = count($path);

	for($i = 0; $i < $pathCount; $i++) {
		$path[$i] = strtolower($path[$i]);
	}

	$path = implode("/", $path);
	require_once '../'.$path.'/'.$fileName.'.php';
}