<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ include file="dbconn.jsp" %>
	<%
		//postId 가져옴 수정!
		String postId=request.getParameter("postId");
	
		request.setCharacterEncoding("UTF-8");
	
		String title=request.getParameter("title");
		String price=request.getParameter("price");
		String condition=request.getParameter("condition");
		String category=request.getParameter("category");
		String description=request.getParameter("description");
		
		Integer price_;
		
		if (price.isEmpty())
			price_=0;
		else
			price_=Integer.valueOf(price);
		
		ResourceBundle bundle = ResourceBundle.getBundle("bundle.message", request.getLocale());
	    String message = bundle.getString("free");
		
		if (price_ == 0){
			category = message;
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="SELECT * FROM Post WHERE PostId =" + "'" + postId + "'";
		pstmt = conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			sql="UPDATE Post Set title=?, price=?, `condition`=?, description=?, category=? WHERE postId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setInt(2, price_);
			pstmt.setString(3, condition);
			pstmt.setString(4, description);
			pstmt.setString(5, category);
			pstmt.setString(6, postId);
			pstmt.executeUpdate();
		}else{
			sql="UPDATE Post Set title=?, price=?, `condition`=?, description=?, category=? WHERE postId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setInt(2, price_);
			pstmt.setString(3, condition);
			pstmt.setString(4, description);
			pstmt.setString(5, category);
			pstmt.setString(6, postId);
			pstmt.executeUpdate();
		}
		if(pstmt!=null)
			pstmt.close();
		if(conn!=null)
			conn.close();
		
		response.sendRedirect("postDB.jsp?id="+postId);
	%>
