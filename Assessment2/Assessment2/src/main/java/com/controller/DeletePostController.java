package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.dao.DeletePostDao;

@WebServlet("/DeletePostController")
public class DeletePostController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if(action != null && action.equalsIgnoreCase("deletepost"))
		{
			int id = Integer.parseInt(request.getParameter("id"));

			DeletePostDao dao = new DeletePostDao();
			dao.deleteEvent(id);

			response.sendRedirect("profile.jsp");
		}
	}
}