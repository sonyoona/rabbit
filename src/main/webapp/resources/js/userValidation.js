async function CheckAddUser() {
    var name = document.getElementById("name");
    var userId = document.getElementById("userId");
    var password = document.getElementById("password");
    var email1 = document.getElementById("email1");
    var email2 = document.getElementById("email2");
    var email = email1.value + "@" + email2.value;
    var phone = document.getElementById("phone1").value + "-" + document.getElementById("phone2").value + "-" + document.getElementById("phone3").value;

    var year = document.getElementById("year").value;
    var month = document.getElementById("month").value;
    var day = document.getElementById("day").value;
    var age = year + "." + month + "." + day;
    
    
    if (!check(/^[가-힣]*$/, name, "[이름]\n이름은 한글만 입력하세요."))
        return false;
        
    if (!check(/^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9]+$/, userId, "[아이디]\n아이디를 확인해주세요."))
        return false;
    
    if (!check(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/, password, 
        "[비밀번호]\n영문 대문자와 소문자 그리고 숫자와 특수기호를 이용하여 만든 8자 이상의 비밀번호여야 합니다."))
        return false;

    if (!check(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/, { value: email }, "[이메일]\n이메일을 확인해주세요."))
        return false;

    if (!check(/^\d{3}-\d{3,4}-\d{4}$/, { value: phone }, "[전화번호]\n전화번호를 확인해주세요."))
        return false;

    if (!year || !month || !day) {
                alert("[나이]\n나이를 확인해주세요.");
                return false;
    }
    
    function check(regExp, e, msg) {
        if (regExp.test(e.value)) {
            return true;
        }
        alert(msg);
        e.focus();
        return false;
    }

     var exam = validationModule.getExam();
    if (!exam) {
                alert("[아이디]\n중복검사를 실행해주세요.");
                return false;
    }
    
   var pass = validationModule.getPass();
    if (!pass) {
                alert("[아이디]\n중복된 아이디입니다. 아이디를 바꿔주세요.");
                return false;
    }
    
    //return true;
    document.newUser.submit();
}
