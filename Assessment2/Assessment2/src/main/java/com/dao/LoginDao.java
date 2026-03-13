package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.model.UserModel;
import com.util.DBUtil;

public class LoginDao 
{
	Connection cn=null;
	public UserModel UserLogin(UserModel lmodel)
	{
		UserModel model=null;
		cn = new DBUtil().getConnectionData();
	    String qry = "select * from users where email=? and password=?";
	    
	    try {
			PreparedStatement st=cn.prepareStatement(qry);
			st.setString(1, lmodel.getEmail());
	        st.setString(2, lmodel.getPassword());
	        
			ResultSet rs=st.executeQuery();
			
			 if(rs.next())
		        {
		            model = new UserModel();
		            model.setUid(rs.getInt(1));
		            model.setName(rs.getString(2));
		            model.setEmail(rs.getString(3));
		            model.setPassword(rs.getString(4));
		        }
			 cn.close();
	        
		} catch (Exception e)
	    {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return model;
	}
}
