package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.beans.Answer;

public class Account {
//STEP 1 -- Create Variables
	
	String username = "root";
	String passwrd="";
	String dbname="blog";
	String url="jdbc:mysql://localhost:3306/";
	String driver = "com.mysql.jdbc.Driver";
	
	ArrayList<Answer> list = new ArrayList<Answer>();
	
	public void insert(String name, String email, String password) throws ClassNotFoundException, SQLException {
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="insert into student(name,email,password) values (?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		pstmt.setString(3, password);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
	}


	public boolean check(String email, String password) throws Exception{
		//STEP 2  -- Load the Driver
				Class.forName(driver);
				//Step 3 -- create connection
				int count = 0;
				Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
				
				//Step 4 -- Query execute
				String sql="select * from user where email = ? AND password = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, email);
				pstmt.setString(2, password);
				
				
				ResultSet rst  =pstmt.executeQuery();
				
				
				while(rst.next()){
					count=1;
				}
				pstmt.close();
				con.close();
				if(count == 1)
					return true;
		return false;
	}


	public ArrayList<Answer> fetchAnswer() throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="select * from answer" ;
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		
		ResultSet rst  =pstmt.executeQuery();
		
		
		while(rst.next()){
			int id =rst.getInt("id");
			String ans = rst.getString("ans");
			int question_id =rst.getInt("question_id");
			
			Answer a=new Answer();
			a.setId(id);
			a.setAns(ans);
			a.setQuestion_id(question_id);
			
			list.add(a);
			a=null;
			
			
		}
		pstmt.close();
		con.close();
		
		return list;
	}


	public void updateView(String id) throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="update question set count = count + 1 where id = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		
		pstmt.executeUpdate();
		pstmt.close();
		con.close();
		
	}


	public void insertUpvote(String email, String ans_id) throws Exception{
		//STEP 2  -- Load the Driver
				Class.forName(driver);
				//Step 3 -- create connection
				
				Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
				
				//Step 4 -- Query execute
				String sql="insert into upvote(email,answer_id) values (?,?)";
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, email);
				pstmt.setString(2, ans_id);
				
				
				
				pstmt.executeUpdate();
				pstmt.close();
				con.close();
		
	}


	public boolean checkUpvote(String email, String ans_id)  throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		int count = 0;
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="select * from upvote where email = ? AND answer_id = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, email);
		pstmt.setString(2, ans_id);
		
		
		ResultSet rst  =pstmt.executeQuery();
		
		
		while(rst.next()){
			count=1;
		}
		pstmt.close();
		con.close();
		if(count == 1)
			return true;
		return false;
	}


	

	public void deleteUpvote(String email, String ans_id) throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="delete from upvote where email=? AND answer_id=?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, email);
		pstmt.setString(2, ans_id);
		
		
		
		pstmt.executeUpdate();
		pstmt.close();
		con.close();
		
	}


	public int getID(String email) throws Exception {
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		int id = 0;
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="select id from user where email = ?" ;
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, email);
		
		
		
		ResultSet rst  =pstmt.executeQuery();
		
		
		while(rst.next()){
			id=rst.getInt("id");
		}
		pstmt.close();
		con.close();
		
		return id;
	}


	public void insertQuestion(String question, String date, String sub_id,	int id) throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="insert into question(title,date,sub_cat_id,user_id,count,featured) values (?,?,?,?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, question);
		pstmt.setString(2, date);
		pstmt.setString(3, sub_id);
		pstmt.setInt(4, id);
		pstmt.setInt(5, 0);
		pstmt.setString(6, "NO");
		
		pstmt.executeUpdate();
		pstmt.close();
		con.close();
		
	}


	public void insertAns(String ans, String qid, int id) throws Exception {
		//STEP 2  -- Load the Driver
				Class.forName(driver);
				//Step 3 -- create connection
				
				Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
				
				//Step 4 -- Query execute
				String sql="insert into answer(ans,question_id,user_id) values (?,?,?)";
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, ans);
				pstmt.setInt(2, Integer.parseInt(qid));
				pstmt.setInt(3, id);
				
				pstmt.executeUpdate();
				pstmt.close();
				con.close();
				
		
	}


	public boolean checkAns(String qid, int id) throws Exception{
		//STEP 2  -- Load the Driver
				Class.forName(driver);
				//Step 3 -- create connection
				int count = 0;
				Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
				
				//Step 4 -- Query execute
				String sql="select * from answer where question_id = ? AND user_id = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, Integer.parseInt(qid));
				pstmt.setInt(2, id);
				
				
				ResultSet rst  =pstmt.executeQuery();
				
				
				while(rst.next()){
					count=1;
				}
				pstmt.close();
				con.close();
				if(count == 1)
					return true;
				return false;
		
	}


	public void deleteuser(String id,String email) throws Exception {
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		int count = 0;
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
				//Step 4 -- Query execute
				String sql1="delete from comment where user_id=?";
				String sql2="delete from upvote where email=?";
				String sql3="delete from answer where user_id=?";
				String sql4="delete from question where user_id=?";
				String sql5="delete from user where id=?";
				PreparedStatement pstmt1 = con.prepareStatement(sql1);
				PreparedStatement pstmt2 = con.prepareStatement(sql2);
				PreparedStatement pstmt3 = con.prepareStatement(sql3);
				PreparedStatement pstmt4 = con.prepareStatement(sql4);
				PreparedStatement pstmt5 = con.prepareStatement(sql5);
				
				pstmt1.setInt(1, Integer.parseInt(id));
				pstmt2.setString(1, email);
				pstmt3.setInt(1, Integer.parseInt(id));
				pstmt4.setInt(1, Integer.parseInt(id));
				pstmt5.setInt(1, Integer.parseInt(id));
				
							
				pstmt1.executeUpdate();
				pstmt2.executeUpdate();
				pstmt3.executeUpdate();
				pstmt4.executeUpdate();
				pstmt5.executeUpdate();
				
				pstmt5.close();
				pstmt4.close();
				pstmt3.close();
				pstmt2.close();
				pstmt1.close();
				
				con.close();
				
		
	}

	public boolean checkMail(String email) throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		int count = 0;
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		String sql="select email from user where email = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, email);
        ResultSet rst = pstmt.executeQuery();
		
		while(rst.next()){
			count =1;
		}
		rst.close();
		pstmt.close();
		con.close();
		if(count == 1){
			return true;
		}
		else{
			return false;
		}
		
	}


	public void insertUser(String name, String email, String password) throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="insert into user(name,email,password) values (?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		pstmt.setString(3, password);
		
		pstmt.executeUpdate();
		pstmt.close();
		con.close();
		
	}

	public void insertComment(String comm, String user_email, String answer_id) throws Exception{
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="insert into comment(comm,date,user_email,answer_id) values (?,?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, comm);
		pstmt.setString(2, DateFormat.getDateInstance().format(new Date()));
		pstmt.setString(3, user_email);
		pstmt.setString(4, answer_id);
		
		pstmt.executeUpdate();
		pstmt.close();
		con.close();
		
	}

	public void updatepassword(String email, String password) throws Exception {
		//STEP 2  -- Load the Driver
				Class.forName(driver);
				//Step 3 -- create connection
				
				Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
				
				//Step 4 -- Query execute
				String sql="update user set password =? where email =?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, password);
				pstmt.setString(2, email);
				
				
				
				pstmt.executeUpdate();
				pstmt.close();
				con.close();
				
		
	}
	
	public String getName(String id) throws Exception {
		//STEP 2  -- Load the Driver
		Class.forName(driver);
		//Step 3 -- create connection
		String name = "";
		Connection con  =DriverManager.getConnection(url+dbname,username,passwrd);
		
		//Step 4 -- Query execute
		String sql="select name from user where id = ?" ;
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		
		
		ResultSet rst  =pstmt.executeQuery();
		
		
		while(rst.next()){
			name =rst.getString("name");
		}
		pstmt.close();
		con.close();
		
		return name;
	}
}













