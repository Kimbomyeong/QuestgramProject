<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");	
	
	String email = (String)session.getAttribute("loginid");
	String prev_pwd = request.getParameter("prev_pwd");
	String new_pwd1 = request.getParameter("new_pwd1");
	String new_pwd2 = request.getParameter("new_pwd2");
	
	UserDao dao = new UserDao();
	
	boolean checkprevpassword = dao.checkPassword(prev_pwd, email);
	if(checkprevpassword) {
		if(new_pwd1 == null || new_pwd1 == "" || new_pwd2 == null || new_pwd2 == "" || new_pwd1.equals(new_pwd2) == false) {%>
			<script type="text/javascript">
				alert("새 비밀번호를 입력하지 않았거나 비밀번호 확인이 일치하지 않습니다.");
				history.back();
			</script>
		<%}
		if(new_pwd1.equals(new_pwd2) && (new_pwd1 != null && new_pwd2 != null) && (new_pwd1 != "" && new_pwd2 != "")) {
			dao.changePassword(email, new_pwd1);
			%>
			<script type="text/javascript">
				alert("비밀번호가 성공적으로 변경되었습니다.");
				history.back();
			</script>
		<%}
	} else {%>
		<script type="text/javascript">
			alert("이전 비밀번호를 입력하지 않았거나 일치하지 않습니다.");
			history.back();
		</script>
	<%}
%>