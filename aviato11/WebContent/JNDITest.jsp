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
		  
			Tomcat������ context.xml���Ͽ� ������ ����
			�����ͼҽ�(Ŀ�ؼ�Ǯ)�� WAS������ ����� ������ 
			Ŀ�ؼ�Ǯ�� ����� ���� WAS���� ������ Ŀ�ؼ�Ǯ�� 
			���丮 ����� ������ �ϱ� ���� ��� 	
		*/
	try{
		
		//1.WAS������ ����� CarProject��������Ʈ�� ��� ������ ������ �ִ�
		//  InitialContext��ü ����
		Context init = new InitialContext();
		
		//2.����� WAS�������� DataSource(Ŀ�ؼ�Ǯ) �˻��ؼ� ��������
		DataSource ds = 
		(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		//3.DataSource(Ŀ�ؼ�Ǯ)���� DB�� �̸� ������ ���� ������ �������ִ�
		// Connection��ü ���
		conn = ds.getConnection();
		
		if(conn != null)  out.println("DB���� ����");
	
	}catch(Exception e){
		
		e.printStackTrace();
	}
	
	%>



</body>
</html>