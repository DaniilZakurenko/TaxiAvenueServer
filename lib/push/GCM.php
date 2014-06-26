<?php

class Lib_Push_GCM
{

    private $url = 'https://android.googleapis.com/gcm/send';

    private $headers = array();

    private $JSON_HEX_TAG;

    private $JSON_HEX_APOS;

    private $JSON_HEX_QUOT;

    private $JSON_HEX_AMP;

    public function __construct()
    {
        if (defined('JSON_HEX_TAG'))
            $this->JSON_HEX_TAB = JSON_HEX_TAG;
        else
            $this->JSON_HEX_TAG = 1;
        
        if (defined('JSON_HEX_APOS'))
            $this->JSON_HEX_APOS = JSON_HEX_APOS;
        else
            $this->JSON_HEX_APOS = 4;
        
        if (defined('JSON_HEX_QUOT'))
            $this->JSON_HEX_QUOT = JSON_HEX_QUOT;
        else
            $this->JSON_HEX_QUOT = 8;
        
        if (defined('JSON_HEX_AMP'))
            $this->JSON_HEX_AMP = JSON_HEX_AMP;
        else
            $this->JSON_HEX_AMP = 2;
        
        $this->headers = array(
            'Authorization: key=' . ANDROID_APP_KEY,
            'Content-Type: application/json;charset=UTF-8'
        );
    }
    
    public function setGCMKey($key) {
        $this->headers = array(
            'Authorization: key=' . $key,
            'Content-Type: application/json;charset=UTF-8'
        );
    }
    
    // $regId = 'APA91bEQKg_qM_uhE4_r4EWGRlqWYGRVqhvBWiSrDQ2ZfLcSQRGXGnC4ziLXzo5x5fGm1xgBPBnLMrhjw3DIRV1wfZiV9xZqUE5ZAtZvyketAZQnMWSb327UKog9N0Ovo8boIEQBm9sN9l9NusyfgCmK6XBWfKTESzoWYjRE0ThsONaT6Tybce0';
    public function sendNotification($regIds, $message)
    {
        $fields = array(
            'registration_ids' => $regIds,
            'data' => array(
                'message' => $message
            )
        );
        
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, $this->url);
        
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $this->headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        
        // curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields, $this->JSON_HEX_TAG | $this->JSON_HEX_APOS | $this->JSON_HEX_QUOT | $this->JSON_HEX_AMP));
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
        // echo json_encode($fields);
        $result = curl_exec($ch);
        if ($result === false) {
            die('Curl failed: ' . curl_error($ch));
        }
        
        curl_close($ch);
        return $result;
    }

    public function push1006($regIds, $message)
    {
        $message['messageType'] = '1006';
        
        return $this->sendNotification($regIds, $message);
    }

    public function push1008($regIds, $message)
    {
        $message['messageType'] = '1008';
        
        return $this->sendNotification($regIds, $message);
    }
}