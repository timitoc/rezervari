package com.andrei.backend.backend;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.Claims;
import javax.xml.bind.DatatypeConverter;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.MalformedJwtException;


public class AuthTokenDecoder {
	private String tokenString=null;
	private Claims claims=null;
	private String privateKey=null;
	
	public void setTokenString(String token){
		tokenString=token;
	}
	public void setPrivateKey(String key){
		privateKey=key;
	}
	public void decode() throws Exception{
		if(privateKey==null){
			throw new Exception("Private key not set!");
		}
		if(tokenString==null){
			throw new Exception("Token not set!");
		}
		try{
			claims= Jwts.parser()
				.setSigningKey(DatatypeConverter.parseBase64Binary(privateKey))
				.parseClaimsJws(tokenString).getBody();
		}catch(ExpiredJwtException expiredEx){
    		System.out.println("Expired token");
    	} catch(SignatureException signEx){
    		System.out.println("Token not authentic");
    	} catch(MalformedJwtException malEx){
    		System.out.println("Invalid token");
    	}
	}
	public Object getValueOfKey(String key) throws Exception{
		if(claims==null){
			throw new Exception("Token not decoded!");
		}
		return claims.get(key);
	}
	
}
