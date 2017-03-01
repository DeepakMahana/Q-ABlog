package com.beans;

public class User {
	private String name;
	private String email;
	private String password;
	private String repassword;
	private String code;
	private String captcha;
	private String msg="";
	
	public boolean validate(String password,String repassword,String code,String captcha){
		if(!password.equals(repassword)){
			msg = msg +"Passwords do not Match" + "<BR>";
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
	
	public boolean verify(String email,String code) {
		
		Integer hash = email.hashCode() ;
		String h= hash.toString();
		
		if(code.equals(h) ){
			return true;
		}
		return false;
	}
	
}
