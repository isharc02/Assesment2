package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.model.BlogsModel;
import com.util.DBUtil;

public class EditDao
{
	public int editPost(BlogsModel bm)
	{
		int x=0;

		try
		{
			Connection cn = new DBUtil().getConnectionData();

			String qry="update blogs set title=?, context=?, tags=? where id=?";

			PreparedStatement st=cn.prepareStatement(qry);

			st.setString(1,bm.getTitle());
			st.setString(2,bm.getContext());
			st.setString(3,bm.getTags());
			st.setInt(4,bm.getId());

			x=st.executeUpdate();

			cn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return x;
	}
}