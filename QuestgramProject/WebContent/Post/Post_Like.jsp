<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   BoardDao db = new BoardDao();

   String id = request.getParameter("id");
   String joayo = request.getParameter("joayo");
   //System.out.println(joayo); 1 받아옴
   //좋아요 증감
   db.updateLikecount(joayo, id);
   
   System.out.println("postlike"+id);
   
   //좋아요 숫자 얻기
   int j = db.getLikecount(id);
%>
<%="{\"joayo\":"+j+"}"%>