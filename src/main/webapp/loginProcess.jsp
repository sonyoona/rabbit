<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ include file="dbconn.jsp" %>
<%
    String userid = request.getParameter("userid");
    String userpw = request.getParameter("password");
    String post = request.getParameter("post");
    
    boolean isValidUser = false;

    if (userid != null && password != null) {
        String sql = "SELECT * FROM User WHERE id = ? AND pw = ?";
        
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, userpw);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 로그인 성공
                isValidUser = true;
                session.setAttribute("userid", userid);
                session.setAttribute("isLoggedIn", true);
                response.sendRedirect("./postsDB.jsp");
            } else {
                // 로그인 실패
                response.sendRedirect("login_failed.jsp");
            }
        } catch (SQLException e) {
           System.err.println("SQLException: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        // 로그인 실패
        response.sendRedirect("login_failed.jsp");
    }
%>
