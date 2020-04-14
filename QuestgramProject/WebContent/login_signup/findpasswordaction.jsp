<%@page import="mail.authKey"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	String host = "smtp.naver.com"; 
	// 네이버일 경우 네이버 계정, gmail경우 gmail 계정 
	String user = "questgram@naver.com"; 
	// 패스워드 
	String password = "questgram!@34%";
	// 보낼 이메일
	String to_email = request.getParameter("email");
	// 인증 키
	String key = new authKey().getAuthKey();
	// SMTP 서버 정보를 설정한다. 
	Properties props = new Properties(); 
	props.put("mail.smtp.host", host);
	props.put("mail.smtp.port", 465); 
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.ssl.enable", "true");
	
	UserDao dao = new UserDao();
	boolean checkemail = dao.checkEmail(to_email); // 보낼 이메일이 db에 존재 여부 확인 변수
	
	if(checkemail) {
		Session mailSession = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(user, password); 
			} 
		}); // 메일 세션 생성
	
		try { 
			MimeMessage message = new MimeMessage(mailSession);
			message.setFrom(new InternetAddress(user, "Questgram"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email)); 
			// 메일 제목 
			message.setSubject("안녕하세요 Questgram 인증 메일입니다"); 
			// 메일 내용 
			message.setText("인증 번호: " + key); 
			// send the message 
			Transport.send(message);
			System.out.println("Success Message Send"); 
		} catch (MessagingException e) {
			e.printStackTrace(); 
		}
		
		HttpSession saveKey = request.getSession();
	    saveKey.setAttribute("AuthenticationKey", key);
		saveKey.setMaxInactiveInterval(60 * 5);
		HttpSession emailSession = request.getSession();
	    emailSession.setAttribute("email", to_email);
	    emailSession.setMaxInactiveInterval(60 * 5);
		
		response.sendRedirect("inputkey.jsp");
	} else {%>
		<script type="text/javascript">
			alert("존재하지 않는 이메일입니다.");
			history.back();
		</script>
	<%}
%>