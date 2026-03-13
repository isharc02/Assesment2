package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.dao.ViewPostDao;
import com.model.BlogsModel;

@WebServlet("/ViewPostController")
public class ViewPostController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public ViewPostController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null) {
			response.sendRedirect("index.jsp");
			return;
		}

		switch (action) {

		case "view":

			try {

				int id = Integer.parseInt(request.getParameter("id"));

				ViewPostDao dao = new ViewPostDao();

				BlogsModel blog = dao.getPostById(id);

				if (blog != null) {

					request.setAttribute("blog", blog);

					request.getRequestDispatcher("viewpost.jsp").forward(request, response);

				} else {

					response.sendRedirect("index.jsp");
				}

			} catch (Exception e) {

				e.printStackTrace();
				response.sendRedirect("index.jsp");
			}

			break;

		default:
			response.sendRedirect("index.jsp");
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}