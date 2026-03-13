package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.model.BlogsModel;
import com.util.DBUtil;

public class CreatePostDao {

	public int CreatePost(BlogsModel bm)
	{
		int x = 0;

		try
		{
			Connection cn = new DBUtil().getConnectionData();

			String qry = "insert into blogs(uid,title,context,tags,createdat) values(?,?,?,?,?)";

			PreparedStatement st = cn.prepareStatement(qry);

			st.setInt(1, bm.getUid());
			st.setString(2, bm.getTitle());
			st.setString(3, bm.getContext());
			st.setString(4, bm.getTags());
			st.setTimestamp(5, bm.getCreatedat());

			x = st.executeUpdate();

			st.close();
			cn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return x;
	}
}