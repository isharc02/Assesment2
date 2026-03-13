package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.dao.SearchDao;

@WebServlet("/SearchController")
public class SearchController extends HttpServlet {

protected void doGet(HttpServletRequest request,HttpServletResponse response)
throws ServletException,IOException{

String query = request.getParameter("query");
String filter = request.getParameter("filterByType");

response.setContentType("text/html");

PrintWriter out = response.getWriter();

try{

SearchDao dao = new SearchDao();

ResultSet rs = dao.searchPosts(query, filter);

while(rs.next())
{

out.println("<div class='col-lg-4 col-md-6'>");
out.println("<div class='blog-card'>");
out.println("<div class='blog-card-body'>");

out.println("<a class='tag-badge'>"+rs.getString("tags")+"</a>");

out.println("<a href='viewPost.jsp?id="+rs.getInt("id")+"' class='blog-card-title d-block'>"+
rs.getString("title")+"</a>");

out.println("<p class='blog-card-text'>"+
rs.getString("context")+"</p>");

out.println("</div>");
out.println("</div>");
out.println("</div>");

}

}
catch(Exception e)
{
e.printStackTrace();
}

}

}