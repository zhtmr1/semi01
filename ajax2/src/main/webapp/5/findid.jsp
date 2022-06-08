<%@page import="test.db.ConnectionPool"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email=request.getParameter("email");
	String pwd=request.getParameter("pwd");
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String id=null;
	try{
		con=ConnectionPool.getConn();
		String sql="select id from member where email=? and pwd=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, pwd);
		rs=pstmt.executeQuery();
		if(rs.next()){
			id=rs.getString(1);
		}
	}catch(SQLException s){
		s.printStackTrace();
	}finally{
		try{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(con!=null)con.close();
		}catch(SQLException s){
			s.printStackTrace();
		}
	}
	// xml로 응답하기
	response.setContentType("text/xml;charset=utf-8");
	PrintWriter pw=response.getWriter();
	pw.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	pw.print("<result>");
	if(id!=null){
		pw.print("<find>true</find>");
		pw.print("<id>" + id + "</id>");
	}else{
		pw.print("<find>false</find>");
	}
	pw.print("</result>");
%>