$(function(){
	$("#searchForm").keyup(function(){
		var keyword = $(this).val();
		
		$.ajax({
			type: "post",
			url: "profile/usersearchaction.jsp",
			data: {"keyword":keyword},
			datatype:"xml",
			success: function(data){
				
				$(data).find("data").each(function(i) {
					var dt = $(this);
					var nickname = dt.find("usernickname").text();
					var userid = dt.find("userid").text();
					console.log(nickname.length);
					$("#search ul").html("<li>"+nickname[i]+"</li>").append("<br>");
					$("#search ul li").html(nickname);
					
					
				})
				
			}
			
			
		});
	});
});