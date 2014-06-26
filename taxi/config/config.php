<?php
date_default_timezone_set('Europe/Zaporozhye');

if(isset($_SERVER['SERVER_NAME']) && !empty($_SERVER['SERVER_NAME']))
	define('URL', 'http://'.$_SERVER['SERVER_NAME'].'/');

if(isset($_SERVER['DOCUMENT_ROOT']) && !empty($_SERVER['DOCUMENT_ROOT']))
	define('DR', $_SERVER['DOCUMENT_ROOT']);

define('HASH_GENERAL_KEY', 'GENERAL_HASH_KEY');
define('HASH_PASSWORD_KEY', 'elizabeth');

define('DB_TYPE', 'mysql');

define('CENTRAL_DB_HOST', 'mysql18.hosting.ua');
define('CENTRAL_DB_NAME', 'Zevulon_taxiavenue');
define('CENTRAL_DB_USER', 'Zevulon_admin');
define('CENTRAL_DB_PASS', 'pstrop41thgF');

define('ANDROID_APP_KEY', 'AIzaSyAglIL5L6KdrCLLPjC96uY_s_-dThJR0C0');

error_reporting(E_ALL);
ini_set("display_errors", 1);