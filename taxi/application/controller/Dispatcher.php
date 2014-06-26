<?php

class Application_Controller_Dispatcher extends Engine_Controller
{

    public function __construct()
    {
        Engine_Auth::handleLogin();
    }

    public function index()
    {
        $view = $this->getView('dispatcher/index');
        // echo Engine_Hash::create('sha256', 'administrator', HASH_GENERAL_KEY);
        echo $view;
    }

    public function getCoord()
    {
        $streets = $this->getStreetGM($_POST['street']);
        echo json_encode($streets);
    }

    private function getStreetGM($input)
    {
        $input = str_replace(' ', '+', trim($input));
        
        $types = 'geocode';
        $location = '48.4500000,34.9833300';
        $radius = '10';
        $sensor = 'false';
        $components = "components=country:ua";
        $lang = 'ru';
        $key = 'AIzaSyC-vCIMjc9uDjAtDogy3A9J9NXPLxxI4-0';
        
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=$types&location=$location&radius=$radius&sensor=$sensor&$components&language=$lang&key=$key");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        $result = json_decode(curl_exec($ch));
        
        $streets = array();
        
        curl_close($ch);
        if (is_object($result)) {
            foreach ($result->predictions as $prediction) {
                $streets[] = substr($prediction->description, 0, strpos($prediction->description, ','));
            }
        }
        
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, 'http://map.meta.ua/dnepropetrovsk/autocomplete.php?query=' . $input);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        $result = curl_exec($ch);
        $result = str_replace('\'', '"', $result);
        $result = str_replace('query', '"query"', $result);
        $result = str_replace('suggestions', '"suggestions"', $result);
        $result = json_decode($result);
        
        $streets = array_merge($streets, $result->suggestions);
        
        $streets = array_unique($streets);
        sort($streets);
        
        return $streets;
    }

    public function sendMessage()
    {}
}
