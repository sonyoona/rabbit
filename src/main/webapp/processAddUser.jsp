<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "dto.User" %>
<%@ page import = "dao.userRepository" %>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

    String realFolder="C:\\Users\\mark1\\workspace_webServer\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\rabbit\\resources\\images";

    int maxSize = 5*1024*1024;
    String encType = "utf-8";

    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

	
	String name=multi.getParameter("name");
	String userId=multi.getParameter("userId");
	String userPw = multi.getParameter("password");
	String email1=multi.getParameter("email1");
	String email2=multi.getParameter("email2");
	String email = email1 + "@" + email2;
	
	String phone1=multi.getParameter("phone1");
	String phone2=multi.getParameter("phone2");
	String phone3=multi.getParameter("phone3");
	String phone = phone1 + "-" + phone2 + "-" + phone3;
	
	String year = multi.getParameter("year");
	String month = multi.getParameter("month");
	String day = multi.getParameter("day");
	String age = year + "." + month + "." + day;

	
	PreparedStatement pstmt = null;
	
	try{
		
		String sql = "INSERT INTO User(id, pw, name, email, phone, age) VALUES(?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, userPw);
        pstmt.setString(3, name);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        pstmt.setString(6, age);
        pstmt.executeUpdate();        
        
		} catch (SQLException ex) {
		    out.println("SQLException: " + ex.getMessage());
		}  finally{
		if(pstmt!=null)
			pstmt.close();
		if(conn!=null)
		conn.close();
	    }
	
	
	response.sendRedirect("postsDB.jsp?signUp=1");	
%>