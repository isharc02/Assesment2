package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.dao.EditDao;
import com.model.BlogsModel;

@WebServlet("/EditPostController")
public class EditPostController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");

		if(action != null && action.equalsIgnoreCase("edit"))
		{
			BlogsModel bm = new BlogsModel();

			bm.setId(Integer.parseInt(request.getParameter("id")));
			bm.setTitle(request.getParameter("title"));
			bm.setContext(request.getParameter("context"));
			bm.setTags(request.getParameter("tags"));

			int x = new EditDao().editPost(bm);

			if(x > 0)
			{
				response.sendRedirect("profile.jsp");
			}
			else
			{
				response.sendRedirect("editpost.jsp?id="+bm.getId());
			}
		}
	}
}