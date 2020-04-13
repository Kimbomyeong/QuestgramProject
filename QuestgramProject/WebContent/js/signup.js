function checkPwd() {
	if($("#password").val().length == ""){
		alert("비밀번호를 정확히 입력해 주세요");
		return false;
	}
	if(!/^[a-zA-Z0-9!,@,#,$,%,^,&,*,?,_,~]{8,16}$/.test($("#password").val())){
		alert("비밀번호는 8~16 자리를 사용해야 합니다");
		return false;
	}
	if($("#password_Check").val().length == ""){
		alert("비밀번호를 확인을 입력해 주세요");
		return false;
	}
	if($("#password_Check").val() != $("#password").val()){
		alert("비밀번호 확인이 일치하지 않습니다");
		return false;
	}
	return true;
}

function buttonColor() {
    const id = document.getElementsByClassName("input1")[0].value;
    const name = document.getElementsByClassName("input1")[1].value;
    const nickname = document.getElementsByClassName("input1")[2].value;
    const password = document.getElementsByClassName("input2")[0].value;
    if(id.length > 0 && name.length > 0 && nickname.length > 0 && password.length > 0){
        return document.getElementsByTagName("button")[0].style.backgroundColor = "#38b3f6";
    } else {
        return document.getElementsByTagName("button")[0].style.backgroundColor = "#c4e1fb";
    }
}