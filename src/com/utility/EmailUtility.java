package com.utility;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtility {
	 public static void doMail(String email,int num) {  
		  
		 String to=email;//change accordingly  
		  
		  
		  //Get the session object  
		  Properties props = new Properties();  
		  props.put("mail.smtp.host", "mail.kitecertification.com");  
		  props.put("mail.smtp.socketFactory.port", "25");  
		  //props.put("mail.smtp.socketFactory.class",  
		           // "javax.net.ssl.SSLSocketFactory");  
		  props.put("mail.smtp.auth", "true");  
		  props.put("mail.smtp.port", "25");  
		   
		  Session session = Session.getInstance(props,  
		   new javax.mail.Authenticator() {  
		   protected PasswordAuthentication getPasswordAuthentication() {  
		   return new PasswordAuthentication("info@kitecertification.com","kitecert123info");//change accordingly  
		   }  
		  });  
		   
		  //compose message  
		  try {  
		   MimeMessage message = new MimeMessage(session);  
		   message.setFrom(new InternetAddress("info@kitecertification.com"));//change accordingly  
		   message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
		   message.setSubject("Verify Your Email - Khateeb Institute");  
		   message.setText("Your Email Verification Number  \n Enter with minus sign if present before the number\n\n" + num);  
		     
		   //send message  
		   Transport.send(message);  
		  
		   
		   
		  } catch (MessagingException e) {throw new RuntimeException(e);}  
		   
		 }  
}
