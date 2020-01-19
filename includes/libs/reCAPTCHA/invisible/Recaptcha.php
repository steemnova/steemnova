<?php

/**
* Name:  Google Invisible reCAPTCHA 
* 
* Author: Geordy James 
*         @geordyjames
*          
* Location: https://github.com/geordyjames/google-Invisible-reCAPTCHA
          
* Created:  13.03.2017

* Created by Geordy James to make a easy version of google Invisible reCAPTCHA PHP Library
* 
* Description:  This is an unofficial version of google Invisible reCAPTCHA PHP Library
* 
*/

class Recaptcha{
	var $config;

	public function __construct($config){
        $this->config = $config;
    }

	public function verifyResponse($recaptcha){
		
		$remoteIp = $this->getIPAddress();

		// Discard empty solution submissions
		if (empty($recaptcha)) {
			return array(
				'success' => false,
				'error-codes' => 'missing-input',
			);
		}

		$getResponse = $this->getHTTP(
			array(
				'secret' => $this->config['secret-key'],
				'remoteip' => $remoteIp,
				'response' => $recaptcha,
			)
		);

		// get reCAPTCHA server response
		$responses = json_decode($getResponse, true);

		if (isset($responses['success']) and $responses['success'] == true) {
			$status = true;
		} else {
			$status = false;
			$error = (isset($responses['error-codes'])) ? $responses['error-codes']
				: 'invalid-input-response';
		}

		return array(
			'success' => $status,
			'error-codes' => (isset($error)) ? $error : null,
		);
	}


	private function getIPAddress(){
		if (!empty($_SERVER['HTTP_CLIENT_IP'])) 
		{
		$ip = $_SERVER['HTTP_CLIENT_IP'];
		} 
		elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) 
		{
		 $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
		} 
		else 
		{
		  $ip = $_SERVER['REMOTE_ADDR'];
		}
		
		return $ip;
	}

	private function getHTTP($data){
		
		$url = 'https://www.google.com/recaptcha/api/siteverify?'.http_build_query($data);
		$response = file_get_contents($url);

		return $response;
	}
}

