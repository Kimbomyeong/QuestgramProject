<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Questgram login</title>
<link href="../css/login.css" rel="stylesheet" type="text/css" />
<script src="../js/login.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
<script> 
	// This is called with the results from from FB.getLoginStatus(). 
	function statusChangeCallback(response) {
		console.log('statusChangeCallback');
		console.log(response);
		// response 객체는 현재 로그인 상태를 나타내는 정보를 보여준다. 
		// 앱에서 현재의 로그인 상태에 따라 동작하면 된다. 
		// FB.getLoginStatus().의 레퍼런스에서 더 자세한 내용이 참조 가능하다. 
		if (response.status === 'connected') { 
			// 페이스북을 통해서 로그인이 되어있다. 
			FB.api('/me', {fields: 'name,email'}, function(response) {
		        var facebookname = response.name;
		        var facebookemail = response.email;
		        window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/QuestProject/login_signup/facebooksignup.jsp?facebookname="+facebookname+"&facebookemail="+facebookemail);
		    });
		} else if (response.status === 'not_authorized') { 
			// 페이스북에는 로그인 했으나, 앱에는 로그인이 되어있지 않다.
			
		} else { 
			// 페이스북에 로그인이 되어있지 않다. 따라서, 앱에 로그인이 되어있는지 여부가 불확실하다. 
			
		}
	}
	
	// 이 함수는 누군가가 로그인 버튼에 대한 처리가 끝났을 때 호출된다. 
	// onlogin 핸들러를 아래와 같이 첨부하면 된다. 
	function checkLoginState() {
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response); 
		}); 
	} 
	
	window.fbAsyncInit = function() { 
		FB.init({ 
			appId : '525405251511937', 
			cookie : true,
			// 쿠키가 세션을 참조할 수 있도록 허용 
			xfbml : true, 
			// 소셜 플러그인이 있으면 처리 
			version : 'v6.0' // 버전 6.0 사용 
		});
		// 자바스크립트 SDK를 초기화 했으니, FB.getLoginStatus()를 호출한다. 
		// 이 함수는 이 페이지의 사용자가 현재 로그인 되어있는 상태 3가지 중 하나를 콜백에 리턴한다. 
		// 그 3가지 상태는 아래와 같다. 
		// 1. 앱과 페이스북에 로그인 되어있다. ('connected') 
		// 2. 페이스북에 로그인되어있으나, 앱에는 로그인이 되어있지 않다. ('not_authorized') 
		// 3. 페이스북에 로그인이 되어있지 않아서 앱에 로그인이 되었는지 불확실하다. 
		// 
		// 위에서 구현한 콜백 함수는 이 3가지를 다루도록 되어있다. 
		FB.getLoginStatus(function(response) { 
			statusChangeCallback(response); 
		}); 
	};
	
	// SDK를 비동기적으로 호출 
	(function(d, s, id) { 
		var js, fjs = d.getElementsByTagName(s)[0]; 
		if (d.getElementById(id)) 
			return; 
		js = d.createElement(s); 
		js.id = id; 
		js.src = "//connect.facebook.net/ko_KR/sdk.js"; 
		fjs.parentNode.insertBefore(js, fjs); 
	}(document, 'script', 'facebook-jssdk')); 
	
	// 로그인이 성공한 다음에는 간단한 그래프API를 호출한다. 
	// 이 호출은 statusChangeCallback()에서 이루어진다. 
	/* function testAPI() { 
		console.log('Welcome! Fetching your information.... '); 
		FB.api('/me', function(response) { 
			console.log('Successful login for: ' + response.name); 
		});
		
		FB.api('/me', {fields: "email"},function(response) { 
			console.log(response.email);
		}); 
	} */
	//SMTP 포트 : 465, 보안 연결(SSL) 필요
</script>
	<div class="outDiv">
		<form name="loginInfo" method="post" action="loginaction.jsp">
			<div class="logoDiv">
				<img class="act" src="../images/logo.png" />
			</div>
			<div class="inputDiv">
				<input class="input1" type="text" id="email" name="email" oninput="buttonColor()"
					placeholder=" 이메일" required="required">
			</div>
			<div class="inputDiv">
				<input class="input2" type="password" id="password" name="password" oninput="buttonColor()"
					placeholder=" 비밀번호" required="required">
			</div>
			<div class="buttonDiv">
				<button class="act" type="submit">로그인</button>
			</div>
			<br>
			<hr style="width: 120px; border: 0.5px solid #BDBDBD; margin-bottom: -5px; margin-left: 1px;">
			<p style="color: #BDBDBD; font-weight: bold; margin-top: -5px;">또는</p>
			<hr style="width: 120px; border: 0.5px solid #BDBDBD; float: right; margin-top: -10px;">
			<br>
			<!-- <p style="float: center;">페이스북로그인</p> -->
			<fb:login-button scope="public_profile,email" onlogin="checkLoginState();"
			data-width="60" data-size="medium" data-button-type="login_with" data-layout="default" 
			data-auto-logout-link="false" data-use-continue-as="false">페이스북으로 회원가입</fb:login-button>
			<div id="fb-root"></div>
			<br>
			<a href="findpassword.jsp" style="text-decoration: none; font-size: 9pt; color: blue">비밀번호를 잊으셨나요?</a>
			<br>
			<br>
			<span style="font-size: 14px;">계정이 없으신가요?
			<a href="signupform.jsp" 
			style="text-decoration: none; font-weight: bold; color: #4FC9DE;">가입하기</a></span>
		</form>
		<% 
            // 아이디, 비밀번호가 틀릴경우 화면에 메시지 표시
            String msg = request.getParameter("msg");
            
            if(msg!=null && msg.equals("0")) {%>
                <script type="text/javascript">
                	alert("비밀번호를 확인해 주세요");
                </script>
            <%} else if(msg!=null && msg.equals("-1")) {%>
            	<script type="text/javascript">
                	alert("아이디를 확인해 주세요");
                </script>
            <%}
        %>
	</div>
</body>
</html>