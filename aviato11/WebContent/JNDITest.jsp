<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection conn = null;
	
		/*JNDI(Java Naming and Directory Interface)
		  
			Tomcat서버의 context.xml파일에 설정을 통해
			데이터소스(커넥션풀)을 WAS서버에 만들어 놓으면 
			커넥션풀을 사용을 위해 WAS버서 내부의 커넥션풀에 
			디렉토리 기반의 접근을 하기 위한 기술 	
		*/
	try{
		
		//1.WAS서버와 연결된 CarProject웹프로젝트의 모든 정보를 가지고 있는
		//  InitialContext객체 생성
		Context init = new InitialContext();
		
		//2.연결된 WAS서버에서 DataSource(커넥션풀) 검색해서 가져오기
		DataSource ds = 
		(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		//3.DataSource(커넥션풀)에서 DB와 미리 연결을 맺은 정보를 가지고있는
		// Connection객체 얻기
		conn = ds.getConnection();
		
		if(conn != null)  out.println("DB연결 성공");
	
	}catch(Exception e){
		
		e.printStackTrace();
	}
	
	%>



</body>
</html>