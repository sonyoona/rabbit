<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "dto.Reply" %>
<%@ page import = "dao.ReplyRepository" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String content = request.getParameter("content");
	String replyId = request.getParameter("replyId");
	String postId = request.getParameter("postId");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM Reply WHERE replyId =" + "'" + replyId + "'";
	
	try{
		pstmt = conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			sql="UPDATE Reply Set content=? WHERE replyId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setString(2, replyId);
			pstmt.executeUpdate();
		}
	} catch	(SQLException e) {
        System.err.println("SQLException: " + e.getMessage());
        e.printStackTrace();
    } finally{
		if(pstmt!=null)
			pstmt.close();
		if(conn!=null)
			conn.close();
    }
    
	String redirectURL = "postDB.jsp?id=" + postId + "?updateReply=1";
	response.sendRedirect(redirectURL);	
%>