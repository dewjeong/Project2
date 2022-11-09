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

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">메일 보내기</h1>
					<ol class="breadcrumb">
						<li><a href="${contextPath}/index.jsp">Home</a></li>
						<li class="active">contact</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="page-wrapper">
		<div class="container">
			<div class="row" >
			
				<!-- Contact Form -->
				
				<div class="block text-center">
					<form id="contact-form" method="post" 
						action="${contextPath}/member/sendmail.do" 
						role="form" align="center">
					
						<div class="form-group">
							<input type="email" placeholder="보내는 사람" class="form-control" 
									name="from" id="name" value="kahncho0713@naver.com" readonly>
						</div>
						
						<div class="form-group">
							<input type="email" placeholder="받는 사람" class="form-control" name="to" id="email">
						</div>
						
						<div class="form-group">
							<input type="radio" name="format" value="text" checked/>Text
						</div>
						<div class="form-group">
							<input type="text" placeholder="제목" class="form-control" name="subject" size="50" id="name" >	
						</div>
						<div class="form-group">
							<textarea rows="10" cols="60" placeholder="내용" class="form-control" 
									name="content" id="message" style="resize: none;"></textarea>	
						</div>
						
						<div id="cf-submit">
							<input type="submit" id="contact-submit" class="btn btn-main text-center" value="Submit">
						</div>						
					</form>
				</div>
				<!-- ./End Contact Form -->
			
			
			</div> <!-- end row -->
		</div> <!-- end container -->
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