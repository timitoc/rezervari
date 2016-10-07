package com.andrei.backend.backend;

public class DbConfig {
	public static String SERVER="localhost";
	public static String USER="root";
	public static String PASS="";
	public static String DATABASE="rezervari_development";
		
	public static String getConnectionString(){
		return "jdbc:mysql://"+SERVER+"/"+DATABASE+"?user="+USER+"&password="+PASS;
	}
}
