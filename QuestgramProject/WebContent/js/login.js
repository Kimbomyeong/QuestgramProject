function buttonColor() {
    const id = document.getElementsByClassName("input1")[0].value;
    const password = document.getElementsByClassName("input2")[0].value;
    if(id.length > 0 && password.length > 0){
        return document.getElementsByTagName("button")[0].style.backgroundColor = "#38b3f6";
    } else {
        return document.getElementsByTagName("button")[0].style.backgroundColor = "#c4e1fb";
    }
}