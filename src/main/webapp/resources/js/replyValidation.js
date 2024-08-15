function CheckAddReply() {
    var reply = document.getElementById("reply");
    
    if (reply.value.length < 1) {
        alert("[댓글]\n최소 1자 이상 입력하세요");
        reply.focus();
        return false;
    }
    
     return true;
}
