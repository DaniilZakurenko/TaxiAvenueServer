<?php

class Engine_Hash {
	
	/**
	 * @param string $algo - The algoritm(md5, sha1, whirpool, etc)
	 * @param string $data - The data to encode
	 * @param string $salt - The salt (This should be the same throuhout the system probably)
	 * @return string - The hashed/salted data
	 **/
	
	public static function create($algo, $data, $salt) {
		$context = hash_init($algo, HASH_HMAC, $salt);
		hash_update($context, $data);
		
		return hash_final($context);
		}
	
}