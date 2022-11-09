<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//BoardController.java서블릿으로 부터 전달 받은 3개의 값
	String idx = request.getAttribute("idx").toString();
	String nowPage = request.getAttribute("nowPage").toString();
	String pass = request.getAttribute("pass").toString();
%>
<script>
	//현재 delete페이지가 실행될때 이름이 없는 함수(무명함수) 호출함
	window.onload = function() {
		//"예","아니오" 두개의 버튼 중 하나를 선택하게 되는데
		//"예" -> true반환
		//"아니오" -> false반환
		var result = confirm("정말 삭제하시겠습니까?");
		
		if(result == true){//예를 눌렀을때 삭제하겠다는뜻
			document.frmDelete.submit();//밑의 form태그 실행하여 BlogController로 요청
		}else{//아니오를 눌렀을때 삭제하지 않겠다는뜻
			history.back();
		}
	}
</script>

<%-- 실제 글 삭제 처리 BoardController에 요청 요청시 3개 값 전달 --%>
<form name="frmDelete" method="post" action="deleteConfirm.bg">
	<input type="hideen" name="idx" value="<%=idx%>">
	<input type="hideen" name="nowPage" value="<%=nowPage%>">
	<input type="hideen" name="pass" value="<%=pass%>">
</form>