<%@ page import="java.sql.*" %>
<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/rabbitDB";
	String user = "";
	String password = "";
	
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(url, user, password);
%>