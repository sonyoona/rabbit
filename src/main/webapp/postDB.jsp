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
	<script>
		function confirmDeletePost(postId) {
	        var confirmation = confirm("정말 삭제하시겠습니까?");
	        if (confirmation) {
	            window.location.href = "processDeletePostDB.jsp?postId=" + postId;
	        }
	    }
		
	    function confirmDeleteReply(postId, replyId) {
	        var confirmation = confirm("정말 삭제하시겠습니까?");
	        if (confirmation) {
	            window.location.href = "processDeleteReplyDB.jsp?id=" + postId + "&replyId=" + replyId;
	        }
	    }
	</script>
	<div class="container py-4">
		<%@ include file = "top.jsp" %>
		<div class="row">
		<%
			String updateReply=request.getParameter("updateReply");
			if(updateReply!=null && updateReply.equals("1")){
				%>
				<script>
	            	alert("댓글이 수정되었습니다.");
		    	</script>
			    <%
			}
		%>
		
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
					        <a href="userInformation.jsp" class="btn btn-sm btn-success pull right" style="margin-top: 30px;">회원 정보</a>
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
		<div class="col-md-8">
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
						
						//쿠키확인 후 생성
						Cookie[] cookies = request.getCookies();
						if(cookies == null){
							cookies = new Cookie[]{
						            new Cookie("clothes", "0"),
						            new Cookie("accessory", "0"),
						            new Cookie("furniture", "0"),
						            new Cookie("hobby", "0"),
						            new Cookie("etc", "0")
						        };
						}					
						
						//쿠키 value 증가
						int count=0;
						boolean exist = false;
						if(category.equals("clothes")){
							for(Cookie cookie : cookies){
								if("clothes".equals(cookie.getName())){
									exist = true;
									count = Integer.parseInt(cookie.getValue())+1;
									cookie.setValue(Integer.toString(count));
									cookie.setMaxAge(60 * 60 * 24);
									response.addCookie(cookie);
								}
							}
							if(exist == false){
								Cookie newCookie = new Cookie("clothes", "1");
								newCookie.setMaxAge(60 * 60 * 24);
								response.addCookie(newCookie);
							}
						} else if(category.equals("accessory")){
							for(Cookie cookie : cookies){
								if("accessory".equals(cookie.getName())){
									exist = true;
									count = Integer.parseInt(cookie.getValue())+1;
									cookie.setValue(Integer.toString(count));
									cookie.setMaxAge(60 * 60 * 24);
									response.addCookie(cookie);
								}
							}
							if(exist == false){
								Cookie newCookie = new Cookie("accessory", "1");
								newCookie.setMaxAge(60 * 60 * 24);
								response.addCookie(newCookie);
							}
						} else if(category.equals("furniture")){
							for(Cookie cookie : cookies){
								if("furniture".equals(cookie.getName())){
									exist = true;
									count = Integer.parseInt(cookie.getValue())+1;
									cookie.setValue(Integer.toString(count));
									cookie.setMaxAge(60 * 60 * 24);
									response.addCookie(cookie);
								}
							}
							if(exist == false){
								Cookie newCookie = new Cookie("furniture", "1");
								newCookie.setMaxAge(60 * 60 * 24);
								response.addCookie(newCookie);
							}
						} else if(category.equals("hobby")){
							for(Cookie cookie : cookies){
								if("hobby".equals(cookie.getName())){
									exist = true;
									count = Integer.parseInt(cookie.getValue())+1;
									cookie.setValue(Integer.toString(count));
									cookie.setMaxAge(60 * 60 * 24);
									response.addCookie(cookie);
								}
							}
							if(exist == false){
								Cookie newCookie = new Cookie("hobby", "1");
								newCookie.setMaxAge(60 * 60 * 24);
								response.addCookie(newCookie);
							}
						} else {
							for(Cookie cookie : cookies){
								if("etc".equals(cookie.getName())){
									exist = true;
									count = Integer.parseInt(cookie.getValue())+1;
									cookie.setValue(Integer.toString(count));
									cookie.setMaxAge(60 * 60 * 24);
									response.addCookie(cookie);
								}
							}
							if(exist == false){
								Cookie newCookie = new Cookie("etc", "1");
								newCookie.setMaxAge(60 * 60 * 24);
								response.addCookie(newCookie);
							}
						}
						%>
						<h1 class="display-5 fw-bold" style="margin-top:50px; margin-bottom: 100px;">[<fmt:message key="<%=category%>" />]</h1>
						<div class="row align-items-md-stretch">
							<p> <b>작성자</b> : <%=userId %>
							<p> <b>작성일</b> : <%=dateTime %>
						</div>
						<hr>
						
						<!-- 글 내용 -->
						<div class="col" style="margin-bottom: 50px;">  
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
						<!-- 수정/삭제 -->
						<%if(userid!=null && userid.equals(userId)&&isLoggedIn){ %>
						<div style="margin-bottom: 100px;">
							<a href="updatePostDB.jsp?postId=<%=id%>">글수정</a>/<a href="#" onclick="confirmDeletePost(<%=id%>)">글삭제</a>
						</div>
						
						<%}%>
						<script src="https://ads-partners.coupang.com/g.js"></script>
						<script>
							var category = '<%=category%>';
							if(category == "clothes")
								new PartnersCoupang.G({"id":783445,"template":"carousel","trackingCode":"AF6175455","width":"900","height":"140","tsource":""});
							else if(category == "accessory")
								new PartnersCoupang.G({"id":783431,"template":"carousel","trackingCode":"AF6175455","width":"900","height":"140","tsource":""});
							else if(category == "furniture")
								new PartnersCoupang.G({"id":783438,"template":"carousel","trackingCode":"AF6175455","width":"900","height":"140","tsource":""});
							else if(category == "hobby")
								new PartnersCoupang.G({"id":783439,"template":"carousel","trackingCode":"AF6175455","width":"900","height":"140","tsource":""});
							else
								new PartnersCoupang.G({"id":783449,"template":"carousel","trackingCode":"AF6175455","width":"900","height":"140","tsource":""});
						</script>
					<%}
				} catch (SQLException ex){
					out.println("SQLException: " + ex.getMessage());
				}
			%>
			
			
			<!-- 댓글 -->
			<p style="font-size: 30px; margin-top: 50px;"> <b>댓글</b>
			<hr>
			<%
				ResultSet replyRs = null;
				Statement replyStmt = null;
				
				try{
					String sql="SELECT * FROM REPLY WHERE POSTID = " + "'" + id + "'";
					replyStmt=conn.createStatement();
					replyRs=replyStmt.executeQuery(sql);
					
					if(!replyRs.isBeforeFirst()){ 
			%>
						<p style="margin-bottom: 100px;"> 댓글을 적어보세요... </p>
			<%
					}
					
					while (replyRs.next()){
						String content = replyRs.getString("content");
						String userId = replyRs.getString("userId");
						String dateTime = replyRs.getString("create_at");
						String replyId = replyRs.getString("replyId");
						if(replyRs.getString("update_at") != null)
							dateTime = replyRs.getString("update_at");
						
			%>
						<div class="col-md-7">
							<p><%=userId %>	<%if(userId.equals(userid)){ %><a href="postUpdateReplyDB.jsp?id=<%=id %>&replyId=<%=replyId %>">수정</a>/
																			<a href="#" onclick="confirmDeleteReply(<%=id%>, <%=replyId%>)">삭제</a><%} %>
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
			<div style="margin-top: 100px;">
				<form name="newReply" action="./processAddReplyDB.jsp" class="form-horizontal" method="post" onsubmit="return CheckAddReply();">
					<p style="font-size: 20px;"> 댓글작성
					<input type="hidden" id="postId" name="postId" value="<%=id%>">
					<input type="hidden" id="userId" name="userId" value="<%=userid%>">
					<textarea name="content" id="content" cols="50" rows="6"
							class="form-control" placeholder="댓글을 적어보세요..."></textarea>
					<input type="submit" class="btn btn-primary" value="등록">
				</form>
			</div>
			<%} %>
			<a href="./postsDB.jsp" class="btn btn-secondary"> 게시판 &raquo;</a>
			<%@ include file = "rabbit.jsp" %>
			</div>
		</div>
		</div>
</fmt:bundle>
</body>
</html>