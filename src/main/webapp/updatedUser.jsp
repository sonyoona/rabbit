<%@ page contentType="text/html; charset=utf-8"%>
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
	<%@ include file="top.jsp" %>
	<div class="p-5 mb-3 rounded-3">
		<div class="container-fluid py-3">
			<h1 class="display-5 fw-bold">회원수정 및 탈퇴</h1>
			<p class="col-md-8 fs-4">Modification and withdrawal of information</p>
		</div>
	</div>
	
	<div class="row align-items-md-stretch text-center">
		<div class="row justify-content-center align-items-center">
			<div class="h-100 p-5 col-md-6">
				<h3>Modification of your information</h3>
				<!-- 회원 수정하기에 들어가면 기존 정보가 뜨도록 함 -->
				<%
					String error=request.getParameter("error");
					if (error!=null){
						out.println("<div class='alert alert-danger>");
						out.println("모든 필드를 채워주세요!");
						out.println("</div>");
					}
					
					
					String name = "";
					String email = "";
					String phone = "";
					
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
			            }
			        } catch (SQLException e) {
				           System.err.println("SQLException: " + e.getMessage());
				            e.printStackTrace();
				    } finally {
				        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
				        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
				    }
			            	
			       %>
			       <form class="form-signin" action="modificationProcess.jsp" method="post">
					<div class="form-floating mb-3 row">
						<input type="text" class="form-control" id = 'name' name='name' required autofocus value='<%=name %>'>
						<label for="floatingInput">Name</label>
					</div>
					<div class="form-floating mb-3 row">
						<input type="text" class="form-control" id = 'email' name='email' value='<%=email %>'>
						<label for="floatingInput">Email</label>
					</div>
					<div class="form-floating mb-3 row">
						<input type="text" class="form-control" id = 'phone' name='phone' value='<%=phone %>'>
						<label for="floatingInput">PhoneNumber</label>
					</div>
					<button class="btn btn-lg btn-success" type="submit">수정</button>
				</form>		           	
			            	

				<form class="form-signin" action="withdrawalProcess.jsp" method="post" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
					<button class="btn btn-lg btn-success" type="submit">탈퇴</button>
				</form>
				
				
			</div>			
		</div>
	</div>
	<%@ include file="rabbit.jsp" %>
</div>
</body>
</html>