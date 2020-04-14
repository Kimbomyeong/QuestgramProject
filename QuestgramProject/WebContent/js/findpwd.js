function buttonColor() {
	const email = document.getElementsByClassName("input1")[0].value;
	if(email.length > 0){
	    return document.getElementsByTagName("button")[0].style.backgroundColor = "#38b3f6";
	} else {
	    return document.getElementsByTagName("button")[0].style.backgroundColor = "#c4e1fb";
	}
}