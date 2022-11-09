<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="smtp.NaverSMTP"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%
	//한글처리
	request.setCharacterEncoding("utf-8");

	// 폼값(이메일 내용) 저장
	Map<String, String> emailInfo = new HashMap<String, String>();
	
	emailInfo.put("from", request.getParameter("from"));  // 보내는 사람
	emailInfo.put("to", request.getParameter("to"));      // 받는 사람
	emailInfo.put("subject", request.getParameter("subject"));  // 제목
	
	// 내용은 메일 포맷에 따라 다르게 처리
	String content = request.getParameter("content");  // 내용
	String format = request.getParameter("format");    // 메일 포맷(text 혹은 html)
	
	if (format.equals("text")) {
	    // 텍스트 포맷일 때는 그대로 저장
	    emailInfo.put("content", content);
	    emailInfo.put("format", "text/plain;charset=UTF-8");
	}
	
	try {
	    NaverSMTP smtpServer = new NaverSMTP();  // 메일 전송 클래스 생성
	    smtpServer.emailSending(emailInfo);      // 전송
%>
		<script>
		alert("짝짝짝! 이메일을 성공적으로 보냈습니다!");
		location.href="http://localhost:8081/aviato/index.jsp";
		</script>
<%	
	}
	catch (Exception e) {
%>
		<script>
	    alert("이메일 전송에 실패했습니다!");
	    history.back();
	    </script>
<%	    
	    e.printStackTrace();
	}
%>
