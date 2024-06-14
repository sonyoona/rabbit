<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
     //정보 업뎃
     String name = request.getParameter("name");
     String email = request.getParameter("email");
     String phone = request.getParameter("phone");

					
    String userid = (String) session.getAttribute("userid");

	String sql = "SELECT * FROM User WHERE id = ?";
			        
	PreparedStatement pstmt = null;
	ResultSet rs = null;

			        try {
			            pstmt = conn.prepareStatement(sql);
			            pstmt.setString(1, userid);
			            rs = pstmt.executeQuery();

			            if (rs.next()) {			            	
                     	    sql = "UPDATE User SET name = ?, email = ?, phone = ? WHERE id = ?";
			            	pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, name);
							pstmt.setString(2, email);
							pstmt.setString(3, phone);
							pstmt.setString(4, userid);
							pstmt.executeUpdate();
			            } 
			        } catch (SQLException e) {
			           System.err.println("SQLException: " + e.getMessage());
			            e.printStackTrace();
			        } finally {
			            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			        }
			        
			        
			        response.sendRedirect("modificationSucess.jsp");	//페이지 만들기 
					
%>
				