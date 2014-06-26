<?php

$mem_start = memory_get_usage();

header("Content-Type: text/html; charset=utf-8");
ini_set("display_errors", 1);
error_reporting(E_ALL);

require_once $_SERVER['DOCUMENT_ROOT'] . '/config/config.php';

function __autoload($class)
{
    $path = explode("_", $class);
    $fileName = array_pop($path);
    
    $pathCount = count($path);
    
    for ($i = 0; $i < $pathCount; $i ++) {
        $path[$i] = strtolower($path[$i]);
    }
    
    $path = implode("/", $path);
    if (file_exists(DR . '/' . $path . '/' . $fileName . '.php'))
        require_once DR . '/' . $path . '/' . $fileName . '.php';
    else {
         if (function_exists('__autoload')) {
            //    Register any existing autoloader function with SPL, so we don't get any clashes
            spl_autoload_register('__autoload');
        }
        //    Register ourselves with SPL
        return spl_autoload_register(array('PHPExcel_Autoloader', 'Load'));
    }
}

Engine_Application::getAppInstance();

$mem_usage = memory_get_usage() - $mem_start;

$fp = fopen('data.txt', 'w');
fwrite($fp, $mem_usage);
fclose($fp);