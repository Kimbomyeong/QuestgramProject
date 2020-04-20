$(function(){
	$("#searchForm").keyup(function(){
		var keyword = $(this).val();
		if(keyword===""){
			keyword = " ";
		}
		
		
		$.ajax({
			type: "post",
			url: "profile/usersearchaction.jsp",
			data: {"keyword":keyword},
			datatype:"xml",
			success: function(data){
				$("#search ul li").remove();
				$("#search ul br").remove();
				$(data).find("data").each(function(i) {
					var dt = $(this);
					var nickname = dt.find("usernickname").text();
					var userid = dt.find("userid").text();
					var profile_img = dt.find("userprofileimg").text();
					var context = dt.find("context").text();   // /프로젝트명
					var hosturl = location.host;
					console.log("profile : "+profile_img);   // 
					console.log("hosturl : "+hosturl);   //    localhost:9000
					console.log("context : "+context);  //     /QuestProject
					$("#search ul").append("<a href='profile/usermain.jsp?id='"+userid+"'><li>"
							+"<div><img src='http://"+hosturl+context+"/profile/images/"+profile_img+"' /></div>"	
							+"&nbsp;&nbsp&nbsp"+nickname+"</li></a>").append("<br>");
					
					
					
				})
				
			}
			
			
		});
	});
});