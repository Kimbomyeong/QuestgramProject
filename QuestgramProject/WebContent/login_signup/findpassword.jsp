<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="outDiv">
		<form name="findPassword" method="post" action="findpasswordaction.jsp">
			<div class="inputDiv">
				<input class="input1" type="text" id="email" name="email" oninput="buttonColor()"
					placeholder=" 이메일" required="required">
			</div>
			<div class="buttonDiv">
				<button class="act" type="submit">이메일 인증번호 발송</button>
			</div>
			<br>
			<hr style="width: 120px; border: 0.5px solid #BDBDBD;">
			<p style="color: #BDBDBD; font-weight: bold; margin-top: -5px;">또는</p>
			<hr style="width: 120px; border: 0.5px solid #BDBDBD; float: right; margin-top: -10px;">
			<br>
			<a href="signupform.html" 
			style="text-decoration: none; font-weight: bold; color: black;">새계정 만들기</a>
			<br>
			<br>
			<br>
			<a href="loginform.jsp" 
			style="text-decoration: none; font-weight: bold; color: #4FC9DE;">로그인으로 돌아가기</a>
		</form>
	</div>
	<script src="../js/login.js"></script>
</body>
</html>