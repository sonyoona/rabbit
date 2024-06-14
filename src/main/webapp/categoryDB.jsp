<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Collections" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="./resources/js/validation.js"></script>
<title>게시판</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<fmt:setLocale value = '<%=request.getParameter("language") %>' />
<fmt:bundle basename = "bundle.message">
	<div class="container-lg py-4">
	<%@ include file = "top.jsp" %>
	<div class="row">
		<!-- 왼쪽 사이드 -->
		<div class="col-md-3" style="margin-top: 50px;">
			
			<%
				//세션에서 유저 아이디와 로그인 정보 가져옴
				String userid = (String) session.getAttribute("userid");
				Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
			%>
			
			<!-- 로그인 -->
			<div class="card mb-4">
				<div class="card-body">
				<%
					String error=request.getParameter("error");
					if (error!=null){
						%>
						<div class="alert alert-danger" role="alert">
							아이디와 비밀번호를 확인해 주세요
						</div>
				    <%
					}
					%>
					<% if (userid ==null || !isLoggedIn) {%>
					<form class="form-signin" action="loginProcess.jsp" method="post">
						<div>
							<input type="text" class="form-control" id = 'userid' name='userid' placeholder="아이디">
							<input type="password" class="form-control" id = 'password' name='password' placeholder="비밀번호">
						</div>
						<button class="btn btn-lg btn-success" type="submit">로그인</button>
					</form>
					<div>
					<a href="./findUserInformation.jsp">아이디/비밀번호 찾기</a>
					<a href="./SignUp.jsp">회원가입</a>
					</div>
					<%} %>
					<!-- 로그인 시 -->
					<%if (userid != null && isLoggedIn != null){ %>
					<div class="row align-items-md-stretch">
						<div class = "col-md-auto mx-auto" style="margin-bottom:20px;">
							<p> 아이디: <%=userid %>님 <br>
							<input type="button" class="btn btn-primary" value="글쓰기" onclick="location.href='./addPost.jsp'" style="margin-top: 30px;">
					        <a href="logout.jsp" class="btn btn-sm btn-success pull right" style="margin-top: 30px;">logout</a>
					        <a href="myPageDB.jsp" class="btn btn-sm btn-success pull right" style="margin-top: 30px;">마이페이지</a>
				         </div>
				    </div>
				    <%} %>
				</div>
			</div>
		
			<!-- 카테고리 -->
			<nav class="nav flex-column nav-pills mb-4" style="margin-top: 50px;">
				<p> <b>카테고리</b>
				<hr>
				<a href="./postsDB.jsp" style="color: black; text-decoration: none;">전체 게시판</a>
				<br>
				<a href="./categoryDB.jsp?id=clothes" style="color: black; text-decoration: none;"><fmt:message key="clothes" /></a>
				<br>
				<a href="./categoryDB.jsp?id=accessory" style="color: black; text-decoration: none;"><fmt:message key="accessory" /></a>
				<br>
				<a href="./categoryDB.jsp?id=hobby" style="color: black; text-decoration: none;"><fmt:message key="hobby" /></a>
				<br>
				<a href="./categoryDB.jsp?id=etc" style="color: black; text-decoration: none;"><fmt:message key="etc" /></a>
				<br>
				<a href="./categoryDB.jsp?id=free" style="color: black; text-decoration: none;"><fmt:message key="free" /></a>
				<hr>
			</nav>
		</div>
			<!-- 중앙 페이지 -->
			<%
				String id=request.getParameter("id");
			%>
			<div class="col-md-7">
				<div class="p-5 mb-4 rounded-3">
					<div class="container-fluid py-3">
						<h1 class="display-5 fw-bold"><fmt:message key="<%=id %>"/> 게시판</h1>
					</div>
				</div>
			
		
			<!-- 글목록 -->
			<div>
				<div class="row mb-2"> 
					<div class="col-md-2">
	            		번호
	           		</div>
	            	<div class="col-md-2">
	                	글제목
	                </div>
	                <div class="col-md-2" style="margin-left:55px;">
		            	작성자
		            </div>
		            <div class="col-md-2" style="margin-left:20px;">
		            	작성시간
					</div>
				</div>
				<hr>	
				<%
				ResultSet rs = null;
				Statement stmt = null;
				ArrayList<String[]> posts = new ArrayList<>();
				
				try {
					String sql="SELECT * FROM POST WHERE CATEGORY = " + "'" + id + "'";
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					while (rs.next()) {
						String postId = rs.getString("postId");
						String title = rs.getString("title");
						String userId = rs.getString("userId");
						String dateTime = rs.getString("createdAt");
						if (rs.getString("updateAt") != null) {
							dateTime = rs.getString("updateAt");
						}
						
						String[] post = { postId, title, userId, dateTime };
						posts.add(post);
					}
					
					// 역순으로 정렬
					Collections.reverse(posts);
					
					for (String[] post : posts) {
						String postId = post[0];
						String title = post[1];
						String userId = post[2];
						String dateTime = post[3];
					%>
							<div class="row mb-2"> 
						        <div class="col-md-1">
						            <%= postId %>
						        </div>
						        <div class="col-md-4">
						            <a href="./postDB.jsp?id=<%= postId %>">
						                <%= title %>
						            </a>
						        </div>
						        <div class="col-md-2"> <!-- userId를 담을 열 -->
						            <%= userId %>
						        </div>
						        <div class="col-md-5"> <!-- dateTime을 담을 열 -->
						            <%= dateTime %>
						        </div>
						    </div>
						<hr>
					<%
						}
					} catch (SQLException ex){
						out.println("SQLException: " + ex.getMessage());
					} finally {
						if (rs!=null)
							rs.close();
						if(stmt!=null)
							stmt.close();
						if(conn!=null)
							conn.close();
					}
				%>
			</div>
		</div>
		
		<!-- 방문횟수가 가장 높은 카테고리 가져옴-->
		<%	String cookieName=null;
			int key=0;
			Cookie[] cookies = request.getCookies();
			if(cookies!=null){
				for(Cookie cookie : cookies){
					try{
						int count = Integer.parseInt(cookie.getValue());
						if(key < count){
							cookieName = cookie.getName();
							key = count;
						}
					} catch (NumberFormatException e) {
		                continue;
		            }
				}
			} else{
				cookieName = "etc";
			}
		 %> 
		 
		 <!-- 오른쪽 사이드 -->
		 <div class="col-md-2" style="margin-top: 50px;">
			 <!-- 맞춤형 광고삽입 -->
			<script src="https://ads-partners.coupang.com/g.js"></script>
			<script>
				var cookieName = '<%=cookieName%>';
				if(cookieName == "clothes")
					new PartnersCoupang.G({"id":783430,"template":"carousel","trackingCode":"AF6175455","width":"140","height":"700","tsource":""});
				else if(cookieName == "accessory")
					new PartnersCoupang.G({"id":783431,"template":"carousel","trackingCode":"AF6175455","width":"140","height":"700","tsource":""});
				else if(cookieName == "furniture")
					new PartnersCoupang.G({"id":783438,"template":"carousel","trackingCode":"AF6175455","width":"140","height":"700","tsource":""});
				else if(cookieName == "hobby")
					new PartnersCoupang.G({"id":783439,"template":"carousel","trackingCode":"AF6175455","width":"140","height":"700","tsource":""});
				else
					new PartnersCoupang.G({"id":783440,"template":"carousel","trackingCode":"AF6175455","width":"140","height":"700","tsource":""});
			</script>
		</div>
		
		<%@ include file="rabbit.jsp" %>
		</div>	
	</div>
</fmt:bundle>
</body>
</html>