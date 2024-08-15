<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String content = request.getParameter("content");
	String userId = request.getParameter("userId");
	String postId = request.getParameter("postId");
	
	Statement stmt = null;
	
	try{
		String sql = "INSERT INTO REPLY(postId, userId, content) VALUES('" + postId + "'," + "'" + userId + "'," + "'" + content + "')";
		stmt=conn.createStatement();
		stmt.executeUpdate(sql);
	} catch (SQLException ex){
		out.println("SQLException: :" + ex.getMessage());
	} finally {
		if(stmt!=null)
			stmt.close();
		if(conn!=null)
			conn.close();
	}

	String redirectURL = "postDB.jsp?id=" + postId;
	response.sendRedirect(redirectURL);	
%>