<?php
/*
 * 
 */
?>
﻿<!DOCTYPE html>
<html>
    <head>
        <title>Карта местонахождения водителей</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <style>
            html {
                width: 100%;
                height: 100%;
            }
            body {
                width: 100%;
                height: 100%;
            }
            #map_canvas {
                width: 100%;
                height: 100%;
            }
            #driverInfo {
                padding: 5px 5px 8px;
            }
            #driverInfo p {
                margin: 0;
                padding: 5px 5px 2px 5px;
            }
            #driverInfo p:first-child {
                padding: 10px 5px 5px;
            }
            #driverInfo ul {
                margin: 0;
                padding: 0 5px;
                font-size: 0.9em;
            }
        </style>
    </head>
    <body>
        <div id="map_canvas"></div>
        
        <script src="<?php echo URL; ?>scripts/libs/jquery/jquery-2.0.3.min.js"></script>
        <script src="<?php echo URL; ?>scripts/libs/underscore/underscore.js"></script>
        <script src="<?php echo URL; ?>scripts/libs/backbone/backbone.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
        <script src="<?php echo URL; ?>scripts/driverMap/settings.js"></script>
        <script src="<?php echo URL; ?>scripts/driverMap/MDriver.js"></script>
        <script src="<?php echo URL; ?>scripts/driverMap/MDriverList.js"></script>
        <script src="<?php echo URL; ?>scripts/driverMap/VDriverMap.js"></script>
        <script src="<?php echo URL; ?>scripts/driverMap/main.js"></script>
    </body>
</html>
