<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
     //정보 delete				
    String postId = request.getParameter("id");
    String replyId = request.getParameter("replyId");
	        
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		String sql = "DELETE FROM Reply WHERE replyId = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, replyId);
	    pstmt.executeUpdate();

     } catch (SQLException e) {
        System.err.println("SQLException: " + e.getMessage());
        e.printStackTrace();
     } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
     }
	
     response.sendRedirect("postDB.jsp?id="+postId);
%>