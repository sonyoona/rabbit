<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>

<jsp:useBean id = "userDAO" class = "dao.userRepository" scope="session"/>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>유저 목록</title>
</head>
<body>
<div class="container py-4">
	<%@ include file="top.jsp" %>
	<div class="p-5 mb-1 rounded-3">
		<div class="container-fluid py-3">
			<h1 class="display-5 fw-bold">사용자 정보</h1>
			<p class="col-md-8 fs-4">User Information</p>
		</div>
	</div>
	<%
	String userId = (String) session.getAttribute("userid");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
	String fileName = "rabbitProfile.jpg";
	
	String name = "";
	String email = "";
	String phone = "";
	String age = "";
	
	String userid = (String) session.getAttribute("userid");

	String sql = "SELECT * FROM User WHERE id = ?";
    
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        rs = pstmt.executeQuery();

        if (rs.next()) {
        	name = rs.getString("name");
        	email = rs.getString("email");
        	phone = rs.getString("phone");
        	age = rs.getString("age");
        	
        }
    } catch (SQLException e) {
           System.err.println("SQLException: " + e.getMessage());
            e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
	%>
 	<div class="row">
        <div class="col" style="padding-left:100px;">
        	<img src = "./resources/images/<%= fileName %>" style = "width:300px; height:300px; border-radius:50%;" />
    	</div>
    	<div class="col" style="margin-top: 70px;">
			<h5><b><%=name%>님</b></h5>
			<p>Email: <%=email %>
			<p>Date of Birth: <%= age %>
			<p>Phone: <%=phone %>
		</div>
	</div>
    	
   	<!-- 로그 아웃 / 회원 수정&탈퇴-->
	<div class="row align-items-md-stretch">
       	<div class = "text-center">
       	    <a href="postsDB.jsp" class="btn btn-sm btn-success pull right">Home</a>
	        <a href="logout.jsp" class="btn btn-sm btn-success pull right">logout</a>
	        <a href="updatedUser.jsp" class="btn btn-sm btn-success pull right">회원수정/탈퇴</a>
         </div>
    </div>


	<%@ include file="rabbit.jsp" %>	
</div>
</body>
</html>