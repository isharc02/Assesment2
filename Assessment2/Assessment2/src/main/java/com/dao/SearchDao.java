package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBUtil;

public class SearchDao {

    public ResultSet searchPosts(String query, String filter) {

        ResultSet rs = null;

        try {

        	Connection cn = new DBUtil().getConnectionData();

            String sql = "";

            if ("title".equals(filter)) {
                sql = "SELECT * FROM blogs WHERE title LIKE ?";
            } 
            else if ("tag".equals(filter)) {
                sql = "SELECT * FROM blogs WHERE tags LIKE ?";
            }

            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");

            rs = ps.executeQuery();

        } 
        catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
}