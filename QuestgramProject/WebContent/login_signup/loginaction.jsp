<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
        // 인코딩 처리
        request.setCharacterEncoding("utf-8"); 
        
        // 로그인 화면에 입력된 아이디와 비밀번호를 가져온다
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // DB에서 아이디, 비밀번호 확인
        UserDao dao = new UserDao();
        int check = dao.loginCheck(email, password);
        String nickname = dao.getNickname(email);
        // URL 및 로그인관련 전달 메시지
        String msg = "";
        
        if(check == 1)    // 로그인 성공
        { 
            // 세션에 현재 아이디, 상태, 닉네임 세팅
            session.setAttribute("loginid", email);
            session.setAttribute("loginok", "ok");
            session.setAttribute("nickname", nickname);
            session.setMaxInactiveInterval(60 * 60 * 4);
            msg = "mainform.jsp";
        }
        else if(check == 0) // 비밀번호가 틀릴경우
        {
            msg = "loginform.jsp?msg=0";
        }
        else    // 아이디가 틀릴경우
        {
            msg = "loginform.jsp?msg=-1";
        }
         
        // sendRedirect(String URL) : 해당 URL로 이동
        response.sendRedirect(msg);
        System.out.println(session.getAttribute("loginid"));
        System.out.println(session.getAttribute("loginok"));
        System.out.println(session.getAttribute("nickname"));
%>