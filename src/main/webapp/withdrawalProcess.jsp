<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
     //정보 delete				
    String userid = (String) session.getAttribute("userid");
	        
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int rowsAffected = 0;

	try {
		String sql = "DELETE FROM User WHERE id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
	    rowsAffected = pstmt.executeUpdate();

     } catch (SQLException e) {
        System.err.println("SQLException: " + e.getMessage());
        e.printStackTrace();
     } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
     }
	
	if (rowsAffected > 0) { //탈퇴성공시 
        response.sendRedirect("logout.jsp");
    }
%>
				