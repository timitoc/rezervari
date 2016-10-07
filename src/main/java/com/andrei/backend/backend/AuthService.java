package com.andrei.backend.backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class AuthService {
	public static boolean login(String username,String password){
		
		try{
		
			Class.forName("com.mysql.jdbc.Driver");
			
			Connection con=DriverManager.getConnection(DbConfig.getConnectionString());
			
			String sqlQuery = "SELECT id_user FROM users WHERE username =? AND password =?";
			PreparedStatement st=con.prepareStatement(sqlQuery);
			
			st.setString(1, username);
			st.setString(2, password);
			
			ResultSet rs = st.executeQuery();
			
			boolean isUserOk=rs.next();
			
			rs.close();
			st.close();
			con.close();
            
			return isUserOk;
		} catch (Exception ex){
			ex.printStackTrace();
		}
		
		return false;
	}
}
