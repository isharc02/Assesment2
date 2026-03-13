package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.util.DBUtil;

public class DeletePostDao 
{
	public void deleteEvent(int id)
	{
	    try
	    {
	        Connection cn = new DBUtil().getConnectionData();

	        String qry = "delete from blogs where id=?";

	        PreparedStatement ps = cn.prepareStatement(qry);

	        ps.setInt(1, id);

	        ps.executeUpdate();

	        cn.close();
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	    }
	}
}