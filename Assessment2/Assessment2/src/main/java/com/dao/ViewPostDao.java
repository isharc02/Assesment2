package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.model.BlogsModel;
import com.util.DBUtil;

public class ViewPostDao {

	public BlogsModel getPostById(int id) {

		BlogsModel blog = null;

		try {

			Connection cn = new DBUtil().getConnectionData();

			String qry = "SELECT b.*, u.name FROM blogs b JOIN users u ON b.uid = u.uid WHERE b.id=?";

			PreparedStatement ps = cn.prepareStatement(qry);

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				blog = new BlogsModel();

				blog.setId(rs.getInt("id"));
				blog.setUid(rs.getInt("uid"));
				blog.setTitle(rs.getString("title"));
				blog.setContext(rs.getString("context"));
				blog.setTags(rs.getString("tags"));
				blog.setCreatedat(rs.getTimestamp("createdat"));

				// store author name
				blog.setName(rs.getString("name"));
			}

			cn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return blog;
	}
}