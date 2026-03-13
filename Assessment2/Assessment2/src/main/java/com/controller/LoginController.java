package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.LoginDao;
import com.model.UserModel;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action=request.getParameter("action");
		if(action.equalsIgnoreCase("login"))
		{
			UserModel lmodel=new UserModel();
			
			lmodel.setEmail(request.getParameter("email"));
			lmodel.setPassword(request.getParameter("password"));
			
			UserModel model=new LoginDao().UserLogin(lmodel);
			if(model != null)
			{
				HttpSession session=request.getSession(true);
				session.setAttribute("uid", model.getUid());
				session.setAttribute("model", model);
				
				session.setAttribute("firstname", model.getName());
				response.sendRedirect("dashboard.jsp");
			}
			else
			{
				response.sendRedirect("login.jsp");
			}
		}
	}

}
