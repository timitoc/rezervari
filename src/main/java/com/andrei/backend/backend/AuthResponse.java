package com.andrei.backend.backend;

public class AuthResponse {
	private boolean success;
	private String token,message;
	
	public void setSuccess(boolean success){
		this.success=success;
	}
	public boolean getSuccess(){
		return success;
	}
	
	public void setToken(String token){
		this.token=token;
	}
	public String getToken(){
		return token;
	}
	
	public void setMessage(String message){
		this.message=message;
	}
	public String getMessage(){
		return message;
	}
}
