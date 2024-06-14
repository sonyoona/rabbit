<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="./resources/js/postValidation.js"></script>
<title>게시글 등록</title>
</head>
<body>
<fmt:setLocale value = '<%=request.getParameter("language") %>' />
<fmt:bundle basename = "bundle.message">
	<div class="container-lg py-4">
		<%@ include file = "top.jsp" %>
		<h1 class="display-5 fw-bold" style="margin-bottom: 50px;">[글쓰기]</h1>
		<form name="newPost" action="./processAddPostDB.jsp" class="form-horizontal" method="post" enctype="multipart/form-data" onsubmit="return CheckAddPost();">
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="title" /></label>
					<div class="col-sm-3">
						<input type="text" id="title" name="title" class="form-control" placeholder="제목">
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="price" /></label>
					<div class="col-sm-3">
						<input type="text" id="price" name="price" class="form-control" placeholder="가격을 입력하세요">
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
						class="form-control" placeholder="내용을 작성하세요..."></textarea>
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="postImage" /></label>
					<div class="col-sm-5">
						<input type="file" name="PostImage" class="form-control">
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-primary" value="<fmt:message key="button" />">
					</div> 
				</div>
			</form>
		</div>
</fmt:bundle>
</body>
</html>