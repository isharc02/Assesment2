package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.CreatePostDao;
import com.model.BlogsModel;

@WebServlet("/CreatePostController")
public class CreatePostController extends HttpServlet {
private static final long serialVersionUID = 1L;

public CreatePostController() {
	super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	response.sendRedirect("createpost.jsp");
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{

	String action = request.getParameter("action");

	if(action != null && action.equalsIgnoreCase("createpost")) {

		HttpSession session = request.getSession(false);

		if(session == null || session.getAttribute("uid") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int uid = (Integer) session.getAttribute("uid");

		String title = request.getParameter("title");
		String context = request.getParameter("context");
		String tags = request.getParameter("tags");

		// DEBUG PRINTS (check Eclipse console)
		System.out.println("UID: " + uid);
		System.out.println("Title: " + title);
		System.out.println("Context: " + context);
		System.out.println("Tags: " + tags);

		BlogsModel model = new BlogsModel();

		model.setUid(uid);
		model.setTitle(title);
		model.setContext(context);
		model.setTags(tags);
		model.setCreatedat(new java.sql.Timestamp(System.currentTimeMillis()));

		CreatePostDao dao = new CreatePostDao();

		int result = dao.CreatePost(model);

		if(result > 0) {
			System.out.println("Post Created Successfully");
			response.sendRedirect("dashboard.jsp");
		}
		else {
			System.out.println("Post Creation Failed");
			response.sendRedirect("createpost.jsp");
		}
	}
}

}
