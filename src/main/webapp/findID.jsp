<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>회원수정 및 탈퇴</title>
</head>
<body>
<div class="container py-4">
<%				
    String name = request.getParameter("name");
    String phoneNum = request.getParameter("phoneNum");
    
    String userid = "";
	        
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		String sql = "SELECT * FROM User WHERE name = ? AND phone = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, phoneNum);
		
	    rs = pstmt.executeQuery();
	        if(rs.next()){
	        	userid = rs.getString("id");
	        	%>
	<div class="row align-items-md-stretch text-center">
		<div class="row justify-content-center align-items-center">
			<div class="h-100 p-5 col-md-6">
				<h3>[<%=name %>]님의 아이디는 [<%=userid %>]입니다.  </h3>
			</div>
		</div>
	</div>
	        	<%
	        }else{
	        	%>
	<div class="row align-items-md-stretch text-center">
		<div class="row justify-content-center align-items-center">
			<div class="h-100 p-5 col-md-6">
				<h3>[<%=name %>]님의 아이디를 찾을 수 없습니다. </h3>
			</div>
		</div>
	</div>
	        	<%
	        }

     } catch (SQLException e) {
        System.err.println("SQLException: " + e.getMessage());
        e.printStackTrace();
     } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
     }
%>
    
	<form class="form-signin" action="postsDB.jsp" method="post">
		<button class="btn btn-lg btn-success" type="submit">Home</button>
	</form>
	<%@ include file="rabbit.jsp" %>   
</div>