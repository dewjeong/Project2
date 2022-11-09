<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<!------------------------------------ top-->
<jsp:include page="/inc/top.jsp"></jsp:include>
<!------------------------------------ top -->

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
//------------------------------------------------------------ 공란체크
function validateForm() {
	
	var sname = $("#name").val();
	var smail = $("#exampleInputEmail1").val();

	//필수란 하나라도 입력하지 않았다면 !!!!
	if( (sname == "" || sname == null) || ( smail == "" || smail == null) ){
		alert(" *필수정보를 입력해주세요!"); 
		return false;	 		
	}
}
//------------------------------------------------------------ 공란체크
</script>
<body id="body">

<section class="forget-password-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <a class="logo" href="${contextPath}/index.jsp">
            <img src="${contextPath}/images/logo.png" alt="">
          </a>
          <h2 class="text-center">Welcome Back</h2>
          
          <form class="text-left clearfix"
          		action="${contextPath}/member/forgetpassword.do"
          		method="post"
          		onsubmit="return validateForm(this)">
          		
            <p style="color: red">가입시 입력한 이름과 이메일을 입력해주세요.</p>
            <div id="join_check1" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
              <input type="text" class="form-control" id="name" name="name" placeholder="이름"/>
             </div>
             
             <div id="join_check2" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
             <div class="form-group">
              <input type="email" class="form-control" id="exampleInputEmail1" name="email" placeholder="이메일"/>
             </div>
           	<div align="center">
			<button type="submit" class="btn btn-main text-center">패스워드 찾기</button>
			</div>
          </form>
          <p class="mt-20"><a href="${contextPath}/member/prevlogin.do">로그인화면으로 돌아가기</a></p>
        </div>
      </div>
    </div>
  </div>
</section>

<!------------------------------------ bottom -->
<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!------------------------------------ bottom -->

    <!-- 
    Essential Scripts
    =====================================-->
    
    <!-- Main jQuery -->
    <script src="${contextPath}/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="${contextPath}/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap Touchpin -->
    <script src="${contextPath}/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
    <!-- Instagram Feed Js -->
    <script src="${contextPath}/plugins/instafeed/instafeed.min.js"></script>
    <!-- Video Lightbox Plugin -->
    <script src="${contextPath}/plugins/ekko-lightbox/dist/ekko-lightbox.min.js"></script>
    <!-- Count Down Js -->
    <script src="${contextPath}/plugins/syo-timer/build/jquery.syotimer.min.js"></script>

    <!-- slick Carousel -->
    <script src="${contextPath}/plugins/slick/slick.min.js"></script>
    <script src="${contextPath}/plugins/slick/slick-animation.min.js"></script>

    <!-- Google Mapl -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
    <script type="text/javascript" src="${contextPath}/plugins/google-map/gmap.js"></script>

    <!-- Main Js File -->
    <script src="${contextPath}/js/script.js"></script>
 
 <script>
	
//-------------------------------------------------------------------- 이름 공란		
		
	$("#name").blur(
			
		function() {

			var name1 = $("#name").val();

					if (name1 == "") {
						
						$("#join_check1").text("*");
				
					}
				}	
		)
//-------------------------------------------------------------------- 이메일 공란			
	$("#exampleInputEmail1").blur(
			
		function() {

			var	email1 = $("#exampleInputEmail1").val();

					if (email1 == "") {
						
						$("#join_check2").text("*");
				
					}
				}	
		)

</script>
 

  </body>
  </html>