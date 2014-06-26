<?php 


$fp = fopen('headers.txt', 'w');
fwrite($fp, json_encode($_SERVER));
fclose($fp);