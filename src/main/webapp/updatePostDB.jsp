<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="./resources/js/postValidation.js"></script>
<title>게시글 수정</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<fmt:setLocale value = '<%=request.getParameter("language") %>' />
<fmt:bundle basename = "bundle.message">
	<div class="container-lg py-4">
	<%@ include file = "top.jsp" %>
	<h1 class="display-5 fw-bold" style="margin-bottom: 50px;">[글수정]</h1>
	<%
		String postId=request.getParameter("postId");
		ResultSet rs = null;
		Statement stmt = null;
		
		try{
			String sql = "SELECT * FROM POST WHERE PostId = " + "'" + postId + "'";
			stmt = conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			if(rs.next()){
				String title = rs.getString("title");
				String price = rs.getString("price");
				String condition = rs.getString("condition");
				String description = rs.getString("description");
				String category  = rs.getString("category");
		%>
			<form name="updatePost" action="./processUpdatePostDB.jsp?postId=<%=postId %>" class="form-horizontal" method="post" onsubmit="return CheckAddPost();">
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="title" /></label>
				<div class="col-sm-3">
					<input type="text" id="title" name="title" class="form-control" value='<%=rs.getString("title") %>'>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="price" /></label>
				<div class="col-sm-3">
					<input type="text" id="price" name="price" class="form-control" value='<%=rs.getString("price") %>'>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="condition" /></label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="<fmt:message key="condition_New" />"> <fmt:message key="condition_New" />
					<input type="radio" name="condition" value="<fmt:message key="condition_Old" />"> <fmt:message key="condition_Old" />
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="category" /></label>
				<div class="col-sm-5">
					<select id="category" name="category">
						<option value="clothes"><fmt:message key="clothes" /></option>
						<option value="accessory"><fmt:message key="accessory" /></option>
						<option value="furniture"><fmt:message key="furniture" /></option>
						<option value="hobby"><fmt:message key="hobby" /></option>
						<option value="etc"><fmt:message key="etc" /></option>
					</select>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="description" /></label>
				<div class="col-sm-5">
					<textarea name="description" id="description" cols="50" rows="2"
					class="form-control" placeholder="수정할 내용을 작성하세요..."></textarea>
				</div>
			</div>
			<div class="mb-3 row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-primary" value="<fmt:message key="button" />">
				</div> 
			</div>
		</form>	
				
		<%
			}
		}catch (SQLException ex){
			out.println("SQLException: " + ex.getMessage());
		} finally{
			if (rs!=null)
				rs.close();
			if(stmt!=null)
				rs.close();
			if(conn!=null)
				conn.close();
		}
	%>
	</div>
</fmt:bundle>
</body>
</html>