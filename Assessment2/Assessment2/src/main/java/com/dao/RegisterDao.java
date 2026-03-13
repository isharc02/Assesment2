package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.model.UserModel;
import com.util.DBUtil;

public class RegisterDao 
{
	Connection cn=null;
	public int UserRegistration(UserModel amodel)
	{
		int x=0;
		cn=new DBUtil().getConnectionData();
		String qry="insert into users(name,email,password) values(?,?,?)";
		
		try {
			PreparedStatement st=cn.prepareStatement(qry);
			st.setString(1, amodel.getName());
			st.setString(2, amodel.getEmail());
			st.setString(3, amodel.getPassword());
			
			x=st.executeUpdate();
			cn.close();
		
		} catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return x;
	}
}
