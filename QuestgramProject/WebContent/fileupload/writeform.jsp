<%@page import="data.dao.ImageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
// 미리보기
function readURL(input){
	if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#blah')
                .attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
	
}

$(function(){
	$("input.form-control").click(function(){
		var val = $(this).val();
		console.log(val);
	});
	
	
	
	
	
});

</script>
</head>
<body>
<!-- 기본이미지 -->
<img id="blah" src="http://placehold.it/180" style="max-width: 300px;" />
<form action="multifileupload.jsp" method="post" enctype="multipart/form-data">
	<!-- hidden 임의로 1을넣었음  -->
	<%
	String nickname = (String)session.getAttribute("nickname");
	String user_id = (String)session.getAttribute("userid");
	ImageDao dao = new ImageDao();
	String board_id = dao.getBoard_id(user_id);
	System.out.println("보드 아이디 : "+board_id);
	%>
	<input type="hidden" name="board_id" value="<%= board_id %>" />
	
	
	
	
	
	
	
	
	
	
	
	
	<table style="width: 400px;" class="table table-bordered">
		<caption><b style="font-size: 15pt;">사진 업로드</b></caption>
		<tr style="height: 40px;">
			<th style="width: 100px" bgcolor="orange">내 용</th>
			<td>
				<input type="text" name="content" style="width: 250px;"
				required="required" class="form-control" />
			</td>
		</tr>
		<tr style="height: 40px;">
			<th style="width: 100px" bgcolor="orange">사 진</th>
			<td>
				<input type="file" name="image" style="width: 250px;"
				required="required" autofocus="autofocus" class="form-control" 
				onchange="readURL(this);" multiple="multiple"/>
			</td>
		</tr>
		<tr style="height: 40px;">
			<td colspan="2" align="center">
				<button type="submit" class="btn btn-default btn-sm" 
				style="width: 100px;">DB 저장하기</button>
				<button type="reset" class="btn btn-default btn-sm" 
				style="width: 100px;">Reset</button>
			</td>
		</tr>
	</table>
</form>


</body>
</html>