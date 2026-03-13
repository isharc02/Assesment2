package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.dao.RegisterDao;
import com.model.UserModel;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action=request.getParameter("action");
		if(action.equalsIgnoreCase("register"))
		{
			UserModel amodel=new UserModel();
			amodel.setName(request.getParameter("name"));
			amodel.setEmail(request.getParameter("email"));
			amodel.setPassword(request.getParameter("password"));
			
			int x=new RegisterDao().UserRegistration(amodel);
			if(x>0)
			{
				response.sendRedirect("login.jsp");
			}
			else
			{
				response.sendRedirect("register.jsp");
			}
		}
		
			
	}

}
