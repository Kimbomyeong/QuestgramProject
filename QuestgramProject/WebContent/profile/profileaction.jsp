<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	String id = (String)session.getAttribute("userid");
	String nickname = request.getParameter("nickname");
	String address = request.getParameter("address");
	String introduce = request.getParameter("introduce");
	String phone = request.getParameter("phone");
	String gender = request.getParameter("gender");
	String profileimage = request.getParameter("update_profile_image");
	
	UserDto dto = new UserDto();
	UserDao dao = new UserDao();
	
	dto.setNickname(nickname);
	dto.setAddress(address);
	dto.setIntroduce(introduce);
	dto.setPhone(phone);
	dto.setGender(gender);
	dto.setProfile_img(profileimage);
	dao.updateUser(dto, id);
	
	response.sendRedirect("profile.jsp");
%>