package com.andrei.backend.backend;


import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class AuthTokenEncoder {
	private Map<String,Object> map;
	private String privateKey=null;
	private Date expirationDate=null;
	public AuthTokenEncoder(){
		map=new HashMap<String,Object>();
	}
	public void setPrivateKey(String privateKey){
		this.privateKey=privateKey;
	}
	public void setKeyValue(String key,Object value){
		map.put(key, value);
	}
	public void setExpiration(long miliseconds){
		expirationDate = new Date(System.currentTimeMillis() + miliseconds);
	}
	public String getTokenString() throws Exception{
		if(privateKey==null){
			throw new Exception("Private key not set!");
		}
		if(expirationDate==null){
			throw new Exception("Expiration date not set!");
		}
		String tokenString=Jwts.builder()
	    		.signWith(SignatureAlgorithm.HS256,privateKey)
	    		.setClaims(map)
	    		.setExpiration(expirationDate)
	    		.compact();
		return tokenString;
	}
}
