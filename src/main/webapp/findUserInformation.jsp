<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "dto.User" %>
<%@ page import = "dao.userRepository" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<jsp:useBean id = "userDAO" class = "dao.userRepository" scope="session"/>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>유저 찾기</title>
</head>
<body>
<div class="container py-4">
<%@ include file="top.jsp" %>
	<div class="p-3 mb-1 rounded-1">
		<div class="container-fluid py-1">
			<h1 class="display-5 fw-bold">사용자 정보 찾기</h1>
			<p class="col-md-8 fs-4">Find User Information</p>
		</div>
	</div>
	
	<!-- 아이디를 읽어버렸다면 -> 이름과 생일로 찾기  -->
	<div class="p-3 mb-2 rounded-2">
		<div class="container-fluid py-1">
			<p class="col-md-8 fs-4">If you lose your id</p>
				<form class="form-signin" action="findID.jsp" method="post">
					<div>
						<p>이름
						<input type="text" class="form-control" id='name' name='name' placeholder="Name"> 
						<p>전화번호('010-xxxx-xxxx' 형식으로 작성해주세요)
						<input type="text" class="form-control" id='phoneNum' name='phoneNum' placeholder="010-xxxx-xxxx">
					</div>
					<button class="btn btn-lg btn-success" type="submit">아이디 찾기</button>
				</form>
			</div>
	</div>
		
	<!-- 비밀번호를 잃어버렸다면  -> 아이디 치면 찾을 수 있음 /post로 찾은 정보 뛰우고  -->
	<div class="p-3 mb-2 rounded-2">
		<div class="container-fluid py-1">
			<p class="col-md-8 fs-4">If you lose your password</p>
			<form class="form-signin" action="findPassword.jsp" method="post">
				<div>
					<p>아이디
					<input type="text" class="form-control" id='userid' name='userid' placeholder="ID"> 
					<p>전화번호('010-xxxx-xxxx' 형식으로 작성해주세요)
					<input type="text" class="form-control" id='phoneNum' name='phoneNum' placeholder="010-xxxx-xxxx">
				</div>
				<button class="btn btn-lg btn-success" type="submit">비밀번호 찾기</button>
			</form>			
		</div>
	</div>
	<%@ include file="rabbit.jsp" %>	
</div>
</body>
</html>