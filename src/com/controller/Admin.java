package com.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.Account;

/**
 * Servlet implementation class Admin
 */
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action= request.getParameter("action");
		if(action == null){
			
			request.getRequestDispatcher("admin_login.jsp").forward(request, response);
		}
		else{
			doPost(request,response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action= request.getParameter("action");
		if(action.equals("admin_login_form")){
			String email =request.getParameter("email");
			String password =request.getParameter("password");
			if(email.equals("admin@myblog.com") && password.equals("admin")){
				request.getRequestDispatcher("admin_index.jsp").forward(request, response);
			}else{
				request.setAttribute("msg", "Invalid Login");
				request.getRequestDispatcher("admin_login.jsp").forward(request, response);
			}
			
			
		}
		
	
		if(action.equals("manage_user")){
				request.getRequestDispatcher("admin_manage_user.jsp").forward(request, response);
			}
		
		if(action.equals("delete_user")){
			String id = request.getParameter("id"); //16
			String email = request.getParameter("email"); //16
			
			Account a=new Account();
			try {
				a.deleteuser(id,email);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			request.setAttribute("msg", "User Successfully Deleted!!");
			
			
			request.getRequestDispatcher("admin_manage_user.jsp").forward(request, response);
		}
		
		}
		
	}













