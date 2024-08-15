<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ include file="dbconn.jsp" %>
	<%
		//세션에서 유저 아이디 가져와야됨~~
		String userId = (String) session.getAttribute("userid");
	    if (userId == null) {
	        response.sendRedirect("login.jsp");
	        return;
	    }
	
		request.setCharacterEncoding("UTF-8");
	
		String filename="";
		String realFolder="C:\\Users\\mark1\\workspace_webServer\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\rabbit\\resources\\images";
		
		int maxSize = 5*1024*1024;
		String encType = "utf-8";
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		String title=multi.getParameter("title");
		String price=multi.getParameter("price");
		String condition=multi.getParameter("condition");
		String category=multi.getParameter("category");
		String description=multi.getParameter("description");
		
		Enumeration files=multi.getFileNames();
		String fname = (String) files.nextElement();
		String fileName=multi.getFilesystemName(fname);
		
		Integer price_;
		
		if (price.isEmpty() || price == null)
			price_=0;
		else
			price_=Integer.valueOf(price);
		
		if (price_ == 0){
			category = "free";
		}
		
		PreparedStatement pstmt = null;
		
		try{
			String sql = "INSERT INTO Post(title, price, `condition`, category, description, filename, userId) VALUES('" + title + "','" + price_ + "','" + condition + "','" + category + "','" + description + "','" + fileName + "','" + userId + "')";
			pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			 int affectedRows = pstmt.executeUpdate();
			 if (affectedRows > 0) {
			        try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
			            if (generatedKeys.next()) {
			                long postId = generatedKeys.getLong(1);
			                String postIdStr = Long.toString(postId);
			                
			                String redirectURL = "postDB.jsp?id=" + postIdStr;
			                response.sendRedirect(redirectURL);
			            } else {
			                throw new SQLException("Creating post failed, no ID obtained.");
			            }
			        }
			    } else {
			        throw new SQLException("Creating post failed, no rows affected.");
			    }
			} catch (SQLException ex) {
			    out.println("SQLException: " + ex.getMessage());
			}  finally{
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
			conn.close();
		    }
	%>
