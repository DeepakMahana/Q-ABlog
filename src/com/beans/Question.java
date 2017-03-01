package com.beans;

public class Question {

	private String question;
	private String code;
	private String msg="";
	
	public boolean validate(String question,String code,String captcha){
		if(question.equals("")){
			msg = msg +"Enter the Question<BR>";
		}
		
		if(code.equals("")){
			msg = msg + "You have to enter the code from the Image";
		}
		
		
		if(!code.equals(captcha)){
			msg = msg + "Hmm, the code did not match, Try Again!!";
		}
		
		if(msg.equals("")){
			return true;
		}
		return false;
	}

	public String getMsg() {
		return msg;
	}
	
	
}
