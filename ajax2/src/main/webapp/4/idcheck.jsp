<%@page import="test.db.ConnectionPool"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% //idcheck.jsp
	String id=request.getParameter("id"); //http://localhost:8081/ajax01/4/idcheck1.jsp?id=hello
	boolean exist=false;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try{
		con=ConnectionPool.getConn();
		String sql="select * from member where id=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1,id);
		rs=pstmt.executeQuery();
		if(rs.next()){
			exist=true;
		}
	}catch(SQLException s){
		s.printStackTrace();
	}finally{
		try{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		}catch(SQLException s){
			s.printStackTrace();
		}
	}
	response.setContentType("text/xml;charset=utf-8");
	PrintWriter pw=response.getWriter();
	pw.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	pw.print("<result>");
	pw.print("<exist>"+ exist + "</exist>");
	pw.print("</result>");
%>




