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
    String userid = request.getParameter("userid");
	String phoneNum = request.getParameter("phoneNum");
    String userpw = "";
	        
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		String sql = "SELECT * FROM User WHERE id = ? and phone = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, phoneNum);
		
	    rs = pstmt.executeQuery();
	        if(rs.next()){
	        	userpw = rs.getString("pw");
	        	%>
	<div class="row align-items-md-stretch text-center">
		<div class="row justify-content-center align-items-center">
			<div class="h-100 p-5 col-md-6">
				<h3>[<%=userid %>]님의 비밀번호는 [<%=userpw %>]입니다.  </h3>
			</div>
		</div>
	</div>
	        	<%
	        }else{
	        	%>
    <div class="row align-items-md-stretch text-center">
		<div class="row justify-content-center align-items-center">
			<div class="h-100 p-5 col-md-6">
				<h3>[<%=userid %>]님의 비밀번호를 찾을 수 없습니다.</h3><br>
				<p> 아이디를 확인해주세요.
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
     }
%>
    

	



	<form class="form-signin" action="postsDB.jsp" method="post">
		<button class="btn btn-lg btn-success" type="submit">Home</button>
	</form>
	<%@ include file="rabbit.jsp" %>   
</div>