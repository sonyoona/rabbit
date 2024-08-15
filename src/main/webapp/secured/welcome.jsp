<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session == null || session.getAttribute("isLoggedIn") == null || !(Boolean)session.getAttribute("isLoggedIn")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>환영합니다</title>
</head>
<body>
    <h1>환영합니다, <%= session.getAttribute("userid") %>!</h1>
    <a href="../logout.jsp">로그아웃</a>
</body>
</html>
