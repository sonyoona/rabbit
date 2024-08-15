<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "dto.User" %>
<%@ page import = "dao.userRepository" %>
<jsp:useBean id = "userDAO" class = "dao.userRepository" scope="session"/>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>유저 목록</title>
</head>
<body>
<div class="container py-4">
	<div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
			<h1 class="display-5 fw-bold">유저 기록</h1>
			<p class="col-md-8 fs-4">UserList</p>
		</div>
	</div>
	<%
		userRepository dao = userRepository.getInstance();
		ArrayList<User> listOfUsers = dao.getAllUser();
	%>

	<div class="row align-items-md-stretch text-center">
		<%
			for (int i=0; i < listOfUsers.size(); i++){
				User user = listOfUsers.get(i);
		%>
		<div class="col-md-4">
			<div class="h-100 p-2">
			    
				<h5><b><%=user.getName() %></b></h5>
				<br><%=user.getId() %> | <%=user.getPw() %>
				<p> <%=user.getEmail() %>
				<p> <%=user.getAge() %>
				<p> <%=user.getPhone() %>
			</div>
		</div>
		<%
			}
		%>
	</div>	
	<%@ include file="rabbit.jsp" %>	
</div>
</body>
</html>