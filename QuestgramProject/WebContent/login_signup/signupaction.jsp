<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");	

	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String nickname = request.getParameter("nickname");
	String password = request.getParameter("password");
	
	UserDto dto = new UserDto();
	UserDao dao = new UserDao();
	
	boolean dupcheckemail = dao.dupCheckEmail(email);
	boolean dupchecknick = dao.dupCheckNickname(nickname);
	
	if(dupcheckemail == true && dupchecknick == true) {
		dto.setEmail(email);
		dto.setName(name);
		dto.setNickname(nickname);
		dto.setPassword(password);
		
		// insert
		dao.insertUser(dto);
		response.sendRedirect("loginform.jsp");
	} else if(dupcheckemail == false || dupchecknick == false) {%>
		<script type="text/javascript">
			alert("이메일 또는 사용자 이름이 중복되어 사용할 수 없습니다.");
			history.back();
		</script>
	<%}
%>