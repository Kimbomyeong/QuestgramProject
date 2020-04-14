<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");	
	
	String key = request.getParameter("key");
	String authkey = (String)session.getAttribute("AuthenticationKey");
	if(key.equals(authkey)) {
		session.removeAttribute("AuthenticationKey");
		System.out.println("Success");
		response.sendRedirect("changepwd.jsp");
	} else {
		session.removeAttribute("AuthenticationKey");
		%>
		<script type="text/javascript">
			alert("인증번호가 틀렸습니다.");
			history.back();
		</script>
	<%}
%>