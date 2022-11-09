<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<!------------------------------------ top -->
<jsp:include page="/inc/top.jsp"></jsp:include>
<!------------------------------------ top -->

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<!----------------------------------- 로그인 유효성 검사 -->
 <script type="text/javascript">

 	function validateForm() {
		
		var email = $("#Email").val();
		var pwd = $("#Password").val();
 		
		if( (email.length == 0 || email == "" ) || (pwd.length == 0 || pwd == "") ){
			alert("필수항목을 입력해주세요!");
			return false;
			
		}else{	
			loginForm.method="post";
			loginForm.action="${contextPath}/member/login.do";
			loginForm.submit();	
		}	
	}
</script> 
<!----------------------------------- 로그인 유효성 검사 --> 
 
<body id="body">

<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <a class="logo" href="${contextPath}/index.jsp">
            <img src="${contextPath}images/logo.png" alt="">
          </a>
          <h2 class="text-center">Welcome Back</h2>
          
          <form class="text-left clearfix" 
          action="${contextPath}/member/login.do"
          method="post"
          onsubmit="return validateForm(this);">
          
            <div class="form-group">
              <input type="email" class="form-control"  placeholder="Email" name="Email" id="Email">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" placeholder="Password" name="Password" id="Password">
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-main text-center">Login</button>
            </div>
          </form>
          <p class="mt-20">New in this site ?<a href="${contextPath}/member/prevsignin.do"> 계정 만들기 </a></p>
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
    
  </body>
  </html>