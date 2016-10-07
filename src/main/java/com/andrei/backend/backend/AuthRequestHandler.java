package com.andrei.backend.backend;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.FormParam;
import javax.ws.rs.core.MediaType;


@Path("auth")

public class AuthRequestHandler {
	
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public AuthResponse postAuth(
			@FormParam("username")String username,
			@FormParam("password")String password){
		
		AuthResponse res=new AuthResponse();
		boolean ok=AuthService.login(username, password);
		if(ok){
			res.setSuccess(true);
			
			AuthTokenEncoder enc=new AuthTokenEncoder();
			enc.setExpiration(3000);
			enc.setPrivateKey(SecretKeys.JwtSecretKey);
			enc.setKeyValue("username", username);
			enc.setKeyValue("password", password);
			
			try{
				res.setToken(enc.getTokenString());
			} catch(Exception ex){
				res.setToken(null);
			}
			
			res.setMessage("Successfully authenticated!");
		} else {
			res.setSuccess(false);
			res.setToken(null);
			res.setMessage("Wrong credentials!");
		}
		
		return res;
	}
}


