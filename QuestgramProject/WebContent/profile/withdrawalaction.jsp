<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	String id = (String)session.getAttribute("userid");
	String email = (String)session.getAttribute("loginid");
	String password = request.getParameter("password");
	
	UserDao dao = new UserDao();
	
	boolean check = dao.checkPassword(password, email);
	if(check) {
		dao.deleteUser(id);
		session.invalidate();
		%>
		<script type="text/javascript">
			alert("회원탈퇴가 성공적으로 이루어졌습니다.");
			location.href = "../login_signup/loginform.jsp";
		</script>
	<%} else {%>
		<script type="text/javascript">
			alert("비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
	<%}
%>