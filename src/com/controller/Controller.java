package com.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.Answer;
import com.beans.Question;
import com.beans.User;
import com.model.Account;
import com.utility.EmailUtility;


public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action= request.getParameter("action");
		if(action == null){
			Account a = new Account();
			ArrayList<Answer> list = new ArrayList<Answer>();
			try {
				list = a.fetchAnswer();
				a=null;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("list", list);
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
		else{
			doPost(request,response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action= request.getParameter("action");//login
		HttpSession session=request.getSession();
		if(action.equals("login")){
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		if(action.equals("login_form")){
			String email =request.getParameter("email");
			String password =request.getParameter("password");
			String flag =request.getParameter("flag");//1-2 -3-4
			boolean status = false;
			Account account = new Account();
			try {
				status = account.check(email,password);
				account=null;
			} catch (Exception e) {
				e.printStackTrace();}
		
			if(status == true){
				
				session.setAttribute("email", email);
				if(flag.equals("1")){
					request.getRequestDispatcher("profile.jsp").forward(request, response);
				}
				if(flag.equals("3")){
					request.getRequestDispatcher("post_question.jsp").forward(request, response);
				}
				if(flag.equals("2")){
					String ans_id =request.getParameter("ans_id");
					String qid =request.getParameter("qid");
					String u =request.getParameter("u");
					request.setAttribute("question_id", qid);
					
					request.setAttribute("u", u);
					
					//insert in upvote
					Account a=new Account();
					try {
						boolean isup =a.checkUpvote(email,ans_id);
						if(isup == false){
							a.insertUpvote(email,ans_id);
						}
						else{
							a.deleteUpvote(email,ans_id);
						}
						a=null;
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					request.getRequestDispatcher("answers.jsp").forward(request, response);
				}
				
				if(flag.equals("4")){
					String qid=request.getParameter("qid"); //15
					String u=request.getParameter("u"); //15
					request.setAttribute("qid", qid);
					request.getRequestDispatcher("post_answer.jsp").forward(request, response);
				}
				
			}
			else{
				request.setAttribute("msg", "Invalid username/password");
				if(flag.equals("1")){
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
				if(flag.equals("2")){
					request.getRequestDispatcher("login1.jsp").forward(request, response);
				}
				if(flag.equals("3")){
					request.getRequestDispatcher("login2.jsp").forward(request, response);
				}
				if(flag.equals("4")){
					request.getRequestDispatcher("login3.jsp").forward(request, response);
				}
				
			}
			
		}
		
		if(action.equals("view_questions")){
			String id = request.getParameter("id"); //1
			request.setAttribute("id", id);
			Account a = new Account();
			ArrayList<Answer> list = new ArrayList<Answer>();
			try {
				list = a.fetchAnswer();
				a=null;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("list", list);
			request.getRequestDispatcher("questions.jsp").forward(request, response);
		}
		
		if(action.equals("view_answer")){
			String id = request.getParameter("id");
			String u = request.getParameter("u");
			Account a = new Account();
			try {
				a.updateView(id);
				a=null;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("question_id", id);
			request.setAttribute("u", u);
			request.getRequestDispatcher("answers.jsp").forward(request, response);
		}
		
		if(action.equals("upvote")){
			String ans_id = request.getParameter("ans_id"); 
			String qid = request.getParameter("qid"); 
			String u = request.getParameter("u"); 
			request.setAttribute("u", u);
			int num =0;
			if(session.getAttribute("email") != null){
				request.setAttribute("question_id", qid);
				//update the DB
				String email =(String) session.getAttribute("email");
				Account a=new Account();
				try {
					boolean isup =a.checkUpvote(email,ans_id);
					if(isup == false){
						a.insertUpvote(email,ans_id);
						num=1;
					}
					else{
						a.deleteUpvote(email,ans_id);
						num=2;
					}
					a=null;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.setAttribute("num", num);
				request.getRequestDispatcher("answers.jsp").forward(request, response);
			}
			else{
				request.setAttribute("ans_id", ans_id);
				request.setAttribute("qid", qid);
				request.setAttribute("question_id", qid);
				request.setAttribute("u", u);
				request.setAttribute("flag", 100);
				
				request.getRequestDispatcher("answers.jsp").forward(request, response);
			}
		}
		
		if(action.equals("postque")){
			if(session.getAttribute("email") != null){
				request.getRequestDispatcher("post_question.jsp").forward(request, response);
			}
			else{
				request.getRequestDispatcher("login2.jsp").forward(request, response);
			}
		}
		if(action.equals("post_ans")){
			String qid=request.getParameter("qid"); //15
			String u=request.getParameter("u"); //15
			
			if(session.getAttribute("email") != null){
				request.setAttribute("qid", qid);
				request.setAttribute("u", u);
				
				request.getRequestDispatcher("post_answer.jsp").forward(request, response);
			}
			else{
				request.setAttribute("qid", qid);
				request.setAttribute("u", u);
				request.getRequestDispatcher("login3.jsp").forward(request, response);
			}
		}
		
		
		if(action.equals("post_question")){
			String sub_id = request.getParameter("sub_category"); 
			String question = request.getParameter("question"); 
			String email = (String)session.getAttribute("email");
			String captcha = (String)session.getAttribute("captcha");
			String code = request.getParameter("code");
			
			Account a = new Account();
			int id;
			Question q = new Question();
			boolean status = q.validate(question,code,captcha);
			if(status == true){
			
			if (captcha != null && code != null) {

				if (captcha.equals(code)) {
			try {
				id = a.getID(email);
				a.insertQuestion(question,DateFormat.getDateInstance().format(new Date()),sub_id,id);
				a=null;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
request.setAttribute("id", sub_id);
			
			ArrayList<Answer> list = new ArrayList<Answer>();
			try {
				list = a.fetchAnswer();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("list", list);
			request.getRequestDispatcher("questions.jsp").forward(request, response);
				}
				
			}	
			
		}else{
			request.setAttribute("msg", q.getMsg() );
			request.getRequestDispatcher("post_question.jsp").forward(request, response);
		}
			
		}
		
		if(action.equals("post_ans_form")){
			String qid=request.getParameter("qid");
			String ans=request.getParameter("ans");
			String u=request.getParameter("u");
			String captcha = (String)session.getAttribute("captcha");
			String code = request.getParameter("code");
			
			
			Account a=new Account();
			String email = (String)session.getAttribute("email");
			int id=0;
			
			Question q = new Question();
			boolean status = q.validate(ans,code,captcha);
			if(status == true){
			
			if (captcha != null && code != null) {

				if (captcha.equals(code)) {
			try {
				id= a.getID(email);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String msg="";
			
			try {
				status = a.checkAns(qid,id);
				if(status == true){
					msg="abc";
				}
				else{
					
					a.insertAns(ans,qid,id);
				}
				
				a=null;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("msg", msg);
			request.setAttribute("u", u);
			request.setAttribute("question_id", qid);
			request.getRequestDispatcher("answers.jsp").forward(request, response);
		}
			}
			}
			
			else{
				request.setAttribute("msg", q.getMsg() );
				request.setAttribute("u", u);
				request.setAttribute("qid", qid);
				request.setAttribute("ans", ans);
				request.getRequestDispatcher("post_answer.jsp").forward(request, response);
			}
		}
		
		if(action.equals("profile")){
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		}
		if(action.equals("logout")){
			session.setAttribute("email", null);
			 session.invalidate();
				request.setAttribute("logout_msg", "You have Logged out" );
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		if(action.equals("show_password")){
			request.setAttribute("flag", "102");
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		}
		if(action.equals("my_questions")){
			
			request.getRequestDispatcher("my_questions.jsp").forward(request, response);
		}
		
		if(action.equals("sign_up")){
			request.getRequestDispatcher("register.jsp").forward(request, response);
		}
		
		if(action.equals("forgot_password")){
			request.setAttribute("flag", "100");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		
		if(action.equals("forgot_password_form")){
			String email=request.getParameter("email");
			
			Account a=new Account();
			boolean ispresent = false;
			try {
				ispresent= a.checkMail(email);
				a=null;
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			if(ispresent == true){
				int number =email.hashCode();
				EmailUtility.doMail(email,number);
				request.setAttribute("email", email);
				request.getRequestDispatcher("verify_pass.jsp").forward(request, response); 
			}
			else{
				request.setAttribute("email", email);
				request.setAttribute("flag", "100");
				request.setAttribute("msg1", "Email Not Present on File!!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			
		}
		if(action.equals("forgot_pass_code")){
			
			String email=request.getParameter("email");
			
			String code=request.getParameter("code");
			User user = new User();
			boolean	status = user.verify(email,code);
			user=null;
			if(status == true){
				
				request.setAttribute("email", email );
				request.getRequestDispatcher("set_password.jsp").forward(request, response);
			}
			else{
				request.setAttribute("msg", "Invalid Code, Try Again!!" );
				
				request.setAttribute("email", email);
				
				request.getRequestDispatcher("verify_pass.jsp").forward(request, response);
			}
		}
		
		if(action.equals("set_password_form")){
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			String repassword=request.getParameter("repassword");
			String captcha = (String)session.getAttribute("captcha");
			String code = request.getParameter("code");
			User user = new User();
			boolean status = user.validate(password,repassword,code,captcha);
			if(status == true){
				Account a=new Account();
				try {
					a.updatepassword(email,password);
					a=null;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.setAttribute("msg", "Password Reset Successfull!!" );
				request.setAttribute("email", email);
				user=null;
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			else{
				request.setAttribute("msg", user.getMsg() );
				user=null;
				request.setAttribute("email", email);
				request.getRequestDispatcher("set_password.jsp").forward(request, response);
			}
			
		}
		if(action.equals("register")){
			
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			String repassword=request.getParameter("repassword");
			String captcha = (String)session.getAttribute("captcha");
			String code = request.getParameter("code");
			
			
			Account a=new Account();
			
			User user = new User();
			boolean status = user.validate(password,repassword,code,captcha);
			user=null;
			boolean ispresent = false;
			if(status == true){
			try {
				ispresent= a.checkMail(email);
				a=null;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(ispresent == true){
				request.setAttribute("msg","Email is already on file");
				
				request.setAttribute("name", name);
				request.setAttribute("email", email);
				request.getRequestDispatcher("register.jsp").forward(request, response);
			}
			else{
				int number =email.hashCode();
				EmailUtility.doMail(email,number);
				request.setAttribute("name", name);
				request.setAttribute("email", email);
				request.setAttribute("password", password);
		        request.getRequestDispatcher("verify.jsp").forward(request, response); 
			}
			
		}
			else{
				request.setAttribute("msg", user.getMsg() );
				request.setAttribute("name", name);
				request.setAttribute("email", email);
				
				request.getRequestDispatcher("register.jsp").forward(request, response);
			}
			}
			
		if(action.equals("verify_email_code")){
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			String code=request.getParameter("code");
			User user = new User();
			boolean	status = user.verify(email,code);
			user=null;
			if(status == true){
				Account account = new Account();
				try {
					account.insertUser(name, email, password);
					account=null;
				} catch (Exception e) {
					e.printStackTrace();
					}
				request.setAttribute("msg", "Registration Success!!" );
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			else{
				request.setAttribute("msg", "Invalid Code, Try Again!!" );
				request.setAttribute("name", name);
				request.setAttribute("email", email);
				request.setAttribute("password", password);
				request.getRequestDispatcher("verify.jsp").forward(request, response);
			}
		}
		
		if(action.equals("comment_login")){
			String email =request.getParameter("email");
			String password =request.getParameter("password");
			
			boolean status = false;
			Account account = new Account();
			try {
				status = account.check(email,password);
				account=null;
			} catch (Exception e) {
				e.printStackTrace();}
		
			if(status == true){
				session.setAttribute("email", email);
			String comment = request.getParameter("comment");
			String ans_id = request.getParameter("ans_id");
			String qid=request.getParameter("qid");
			String u=request.getParameter("u");
			
			try {
				
				new Account().insertComment(comment, email, ans_id);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("u", u);
			request.setAttribute("question_id", qid);
			
			request.getRequestDispatcher("answers.jsp").forward(request, response);
			
		}
			else{
				request.setAttribute("msg", "Invalid username/password");
				request.getRequestDispatcher("login3.jsp").forward(request, response);
			}
		}
		
		
		if(action.equals("comments_form")){
			
			String comment = request.getParameter("comment");
			String ans_id = request.getParameter("ans_id");
			String qid=request.getParameter("qid");
			String u=request.getParameter("u");
			String email = (String)session.getAttribute("email");
			try {
				new Account().insertComment(comment, email, ans_id);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("u", u);
			request.setAttribute("question_id", qid);
			
			request.getRequestDispatcher("answers.jsp").forward(request, response);
			
		
		}	
	
	}
	}













