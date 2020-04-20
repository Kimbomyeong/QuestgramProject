
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	//commentno,like_count 읽기
	request.setCharacterEncoding("utf-8");
	String commentno=request.getParameter("commentno");
	String like_count=request.getParameter("like_count");
%>
<jsp:useBean id="dto" class="data.dto.CommentDto"/>
<jsp:useBean id="dao" class="data.dao.CommentDao"/>
<jsp:setProperty name="dto" property="*"/>

<%
dao.updatelike_count(like_count, commentno);
//증가 또는 감소된 좋아요 숫자 얻기
int j=dao.getlike_count(commentno);

%>
<%="{\"like_count\":"+j+"}"%>