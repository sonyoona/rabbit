function CheckAddPost() {
    var title = document.getElementById("title");
    var description = document.getElementById("description");
    var price = document.getElementById("price");
    
    if (title.value.length < 1) {
        alert("[제목]\n최소 1자 이상 입력하세요");
        title.focus();
        return false;
    }
    
    if (isNaN(price.value)) {
        alert("[가격]\n숫자를 입력하세요");
        price.focus();
        return false;
    }
    
    if (description.value.length < 1) {
        alert("[내용]\n최소 1자 이상 입력하세요");
        description.focus();
        return false;
    }
    
    return true;
}