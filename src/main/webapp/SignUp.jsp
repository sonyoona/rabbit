<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<html>
<head>
    <link rel="shortcut icon" href="#">
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="./resources/js/userValidation.js"></script>
    <title>회원가입</title>
</head>
<body>
<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="bundle.message">
<script type="text/javascript">
   var exam = false;
</script>
<div class="container py-4">
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">회원가입</h1>
            <p class="col-md-8 fs-4">Sign Up</p>
        </div>
    </div>
    
    <div class="row align-items-md-stretch">
        <div class="text-end">
            <a href="?language=ko">Korean</a> | <a href="?language=en">English</a>
        </div>
        
        <form name="newUser" action="./processAddUser.jsp" class="form-horizontal" method="post" enctype="multipart/form-data"> 
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="name" /></label>
                <div class="col-sm-3">
                    <input type="text" id="name" name="name" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="userId" /></label>
                <div class="col-sm-3">
                    <input type="text" id="userId" name="userId" class="form-control">
                </div>
                <div class="col-sm-3">
                    <button type="button" class="btn btn-primary" onclick="validationModule.checkDuplicate()">중복검사</button>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="password" /></label>
                <div class="col-sm-3">
                    <input type="password" id="password" name="password" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="email" /></label>
                <div class="col-sm-3">
                    <input type="text" id="email1" name="email1" class="form-control">
                    <span>@</span>
                    <input type="text" id="email2" name="email2" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="phone" /></label>
                <div class="col-sm-3">
                    <select id="phone1" name="phone1" class="form-control">
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                    </select> - 
                    <input type="text" maxLength="4" size="4" id="phone2" name="phone2" class="form-control"> - 
                    <input type="text" maxLength="4" size="4" id="phone3" name="phone3" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="age" /></label>
                <div class="col-sm-3">
                    <div class = "info" id = "info_birth">
                    <select class = "box" id = "year" name = "year">
                        <option disabled selected>출생년도</option>
<script>
    const startYear = 1950;
    const endYear = 2023;
    const yearSelect = document.getElementById('year');

    for (let year = startYear; year <= endYear; year++) {
        const option = document.createElement('option');
        option.value = year;
        option.textContent = year;
        yearSelect.appendChild(option);
    }
</script>
                    </select>
                    <select class = "box" id = "month" name = "month">
                        <option disabled selected>월</option>
                    </select>
<script>
    const startMonth = 1;
    const endMonth = 12;
    const monthSelect = document.getElementById('month');

    for (let month = startMonth; month <= endMonth; month++) {
        const option = document.createElement('option');
        option.value = month;
        option.textContent = month;
        monthSelect.appendChild(option);
    }
</script>
                    <select class = "box" id = "day" name = "day">
                        <option disabled selected>일</option>
                    </select>
<script>
    const startDay = 1;
    const endDay = 31;
    const daySelect = document.getElementById('day');

    for (let day = startDay ; day <= endDay; day++) {
        const option = document.createElement('option');
        option.value = day;
        option.textContent = day;
        daySelect.appendChild(option);
    }
</script>
                    </div>
                </div>
            </div>
            
            <div class="mb-3 row">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="button" class="btn btn-primary" value=<fmt:message key="signUp" />onclick="CheckAddUser()" >
                </div> 
            </div>
        </form>
    </div>    
    <%@ include file="rabbit.jsp" %>    
</div>
</fmt:bundle>
<script>
var validationModule = (function() {
    var pass = false;

    function checkDuplicate() {
        var userId = document.getElementById('userId').value;
        exam = true;
        if (userId === '') {
            alert('아이디를 입력해주세요.');
            return;
        }

        $.ajax({
            url: 'duplicateInspection.jsp',
            type: 'POST',
            data: { userId: userId },
            success: function(response) {
                if (response.trim() === 'duplicate') {
                    alert('중복된 아이디입니다.');
                    pass = false;
                } else {
                    alert('사용 가능한 아이디입니다.');
                    pass = true;
                }
            }
        });
    }

    function getPass() {
        return pass;
    }
    
    function getExam() {
        return exam;
    }
   

    return {
        checkDuplicate: checkDuplicate,
        getPass: getPass,
        getExam: getExam
    };
})();

</script>
</body>
</html>
