<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="./resources/js/replyValidation.js"></script>
<title>게시글</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<fmt:setLocale value = '<%=request.getParameter("language") %>' />
<fmt:bundle basename = "bundle.message">
	<div class="container py-4">
		<!-- 세션확인 -->
		<%
			//세션에서 유저 아이디와 로그인 정보 가져옴
			String userid = (String) session.getAttribute("userid");
			Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
		%>
		<%@ include file = "top.jsp" %>

		<!-- 타이틀 -->
		<%
			String id=request.getParameter("id");
			
			ResultSet rs = null;
			Statement stmt = null;
			
			try{
				String sql = "SELECT * FROM POST WHERE PostId = " + "'" + id + "'";
				stmt = conn.createStatement();
				rs=stmt.executeQuery(sql);
				
				if(rs.next()){
					String title = rs.getString("title");
					String price = rs.getString("price");
					String condition = rs.getString("condition");
					String description = rs.getString("description");
					String category  = rs.getString("category");
					String filename = rs.getString("filename");
					String userId = rs.getString("userId");
					String dateTime = rs.getString("createdAt");
					if(rs.getString("updateAt") != null)
						dateTime = rs.getString("updateAt");
					%>
					<h1 class="display-5 fw-bold" style="margin-bottom: 100px;">[<fmt:message key="<%=category%>" />]</h1>
					<div class="row align-items-md-stretch">
						<p> <b>작성자</b> : <%=userId %>
						<p> <b>작성일</b> : <%=dateTime %>
					</div>
					<hr>
					
					<!-- 글 내용 -->
						<div class="col-md-6" style="margin-bottom: 50px;">  
						<!-- <div style="margin-bottom: 20px;"> -->
							<h3><b><%=title %></b></h3>
							<% 	if (!condition.equals("null") && !condition.isEmpty()) { %>
								<p> <b>상태</b> : <%=condition %>
							<% } %>
							<p style="margin-bottom: 50px;"> <b>가격</b> : <%=price %>원<br>
							<% 	if (!filename.equals("null") && !filename.isEmpty()) { %>
				                <img src="./resources/images/<%= filename %>" style="width: 70%">
				            <% } %>
							<p style="font-size: 20px"> <%=description %>
						</div>
				<%}
			} catch (SQLException ex){
				out.println("SQLException: " + ex.getMessage());
			}
		%>
		
		<!-- 댓글 -->
		<p style="font-size: 30px"> <b>수정할 댓글</b>
		<hr>
		<%
			String replyId=request.getParameter("replyId");
			ResultSet replyRs = null;
			Statement replyStmt = null;
			
			try{
				String sql="SELECT * FROM REPLY WHERE REPLYID = " + "'" + replyId + "'";
				replyStmt=conn.createStatement();
				replyRs=stmt.executeQuery(sql);
				
				if (replyRs.next()){
					String content = replyRs.getString("content");
					String userId = replyRs.getString("userId");
					String dateTime = replyRs.getString("create_at");
					if(replyRs.getString("update_at") != null)
						dateTime = replyRs.getString("update_at");
		%>
					<div class="col-md-7">
						<p><%=userId %>
						<p style="font-size: 20px"><%=content %>
						<p><%=dateTime %>
						<hr>
					</div>
		<%
				}
			}catch (SQLException ex){
				out.println("SQLException: " + ex.getMessage());
			} finally {
				if (replyRs!=null)
					replyRs.close();
				if(replyStmt!=null)
					replyStmt.close();
				if(conn!=null)
					conn.close();
			}
		%>
			
		<!-- 댓글작성 -->
		<% if (userid !=null && isLoggedIn) {%>
		<div style="margin-top: 50px;">
			<form name="newReply" action="./processUpdateReplyDB.jsp" class="form-horizontal" method="post" onsubmit="return CheckAddReply();">
				<p style="font-size: 20px;"> 댓글수정
				<input type="hidden" id="postId" name="postId" value="<%=id%>">
				<input type="hidden" id="replyId" name="replyId" value="<%=replyId%>">
				<textarea name="content" id="content" cols="50" rows="6"
						class="form-control" placeholder="수정할 댓글을 적어보세요..."></textarea>
				<input type="submit" class="btn btn-primary" value="등록">
			</form>
		</div>
		<%} %>
		<a href="./postsDB.jsp" class="btn btn-secondary"> 게시판 &raquo;</a>
		<%@ include file = "rabbit.jsp" %>
	</div>
</fmt:bundle>
</body>
</html>