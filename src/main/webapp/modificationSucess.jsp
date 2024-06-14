<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>회원수정 및 탈퇴</title>
</head>
<body>
<div class="container py-4">
    <%
    String userid = (String) session.getAttribute("userid");
    %>
	<div class="row align-items-md-stretch text-center">
		<div class="row justify-content-center align-items-center">
			<div class="h-100 p-5 col-md-6">
				<h3>[<%=userid %>]님의 정보가 성공적으로 수정되었습니다.  </h3>
			</div>
		</div>
	</div>
	<form class="form-signin" action="postsDB.jsp" method="post">
		<button class="btn btn-lg btn-success" type="submit">메인으로 가기</button>
	</form>
	<%@ include file="rabbit.jsp" %>   
</div>