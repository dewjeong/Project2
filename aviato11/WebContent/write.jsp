<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WRITE</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style.css" />

<script type="text/javascript">
	//제이쿼리를 이용해 아래쪽의 <input type="file">태그에서 이미지 파일 첨부시 미리보기 기능을 구현하는 함수 
	 function readURL(input) { // <- <input type="file">태그를 매개변수로 전달 받는다.
		
		 //크롬 웹브라우저의 F12 눌러 개발자모드창을 열어서 console탭에 띄운 로그메세지를 확인 한다.
		  console.log(input);
	 	  console.log(input.files)
	 	//참고.
	 	//<input type="file">인 태그객체의 files메소드를 호출하면
	 	//FileList라는 배열이 생성 되면서 FileList배열 내부의 0번쨰 인덱스 위치에
	 	//아래에서 선택한(업로드할) 파일 정보들을 key:value쌍으로 저장한 File객체가 저장되어 있음
	 	  
		//FileList라는 배열이 존재하고...
		//FileList라는 배열의 0번째 인덱스 위치에 아래에서 파일을 업로드하기 위해서 선택한 File객체가 저장되어 있다면?
		//요약 : 아래의 <input type="file">태그에서 업로드를 하기 위한 파일을 선택 했다면?
	    if (input.files && input.files[0]) {
	  	  
	  	  //파일을 문자 단위로 읽어들일 통로 생성 
		      var reader = new FileReader();
	  	     	  
		      //지정한 img태그에 첫번째 파일 input에 첨부한 파일에 대한 File객체를 읽어드립니다. 
		      reader.readAsDataURL(input.files[0]);
	  	  
	  	  //업로드 하기 위해 선택한 파일을 모두 읽어 들였다면?
		      reader.onload = function (ProgressEvent) {
	  		 //읽어들인 File객체의 정보는 매개변수로 넘어오는 ProgressEvent객체내부의?
	  		 //target속성에 대응되는 객체(JSON객체 데이터형식)로 저장 되어 있다.
	  		 console.log(ProgressEvent);
	  		  
			    //id가 preview인 <img>태그를 선택해 
			    //attr메서드를 이용해 파일 첨부시 미리보기 이미지를 나타내기 위해
			    //src속성값에  new FileReader()객체를 이용하여 읽어들인 첨부할 File객체정보를 지정하여
			    //추가 함으로써 이미지 파일의 미리보기기능이 가능 한 것입니다.
		        $('#preview').attr('src', ProgressEvent.target.result);
		        
	        }
	  	
	    }
	}  
	//BlogController로 글쓰기 내용 전송
	//이거 왜쓰냐면 밑에 글 등록 버튼(button태그 아니고 이미지에 a태그건거)누르면
	//<a href="javascript:fnInsert();>"부분에서
	//지금 여기 아래 함수가 실행되게 하고 이 함수는 submit을 해줘서
	function fnInsert() {
		//패스워드 입력하지 않았을때
		if (document.getElementById("pass").value == "") {
			alert("Please enter pass");
			return false;
		}

		document.frmInsert.submit();
	}
</script>
</head>

<jsp:include page="./inc/top.jsp"></jsp:include>
<body>
	<!-- 상단 메뉴 디자인 -->
	<section class="page-header">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="content">
						<h1 class="page-name">WRITE ARTICLE</h1>
						<ol class="breadcrumb">
							<li><a href="index.jsp">Home</a></li>
							<li class="active">blog</li>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 상단 메뉴 디자인 끝 -->
	<div class="page-wrapper">
		<div class="container">
			<div class="row">
			<form method="post" action="writeConfirm.bg" name="frmInsert" enctype="multipart/form-data">
					<!-- 사이드바 시작 -->
					<div class="col-md-4">
						<aside class="sidebar">
							<div class="widget widget-subscription">
							<h4 class="widget-title">enter password</h4>
							<input type="text" style="margin-bottom: 10px;" name="writer" id="name" class="form-control" placeholder="name">
							<input type="password" style="margin-bottom: 10px;" name="pass" id="pass" class="form-control" placeholder="password">
								
								<div style="margin-bottom: 60px;">
									<button type="button" onclick="javascript:fnInsert();"
										class="btn btn-main">+ SUBMIT</button>
								</div>
								<div style="margin-bottom: 10px;">
									<button type="button" onclick="location.href='BlogList.bg'"
										class="btn btn-main">LIST</button>
								</div>
								<div>
									<button type="reset" class="btn btn-main">RESET</button>
								</div>
							</div>
						</aside>
					</div>
					<!-- 사이드바끝 -->
					<div class="col-md-8" align="center">
						<!-- 		글쓰기양식시작 -->

						<div class="post" align="center">
							<!-- 이미지 미리보기창 만들기 -->
							<div class="post-media post-thumb">
								<img id="preview" src="#" alt="userImage" width=669.33 height=304.79>
								<input style="margin-bottom: 10px"type="file" name="imageFileName" id="image" onchange="readURL(this);" />
							</div>
							<div class="form-group">
								<!-- 								<h2 class="post-title">WRITER</h2><hr> -->
								<input type="text" name="title" id="title" class="form-control"
									placeholder="TITLE" />
							</div>
							<div class="form-group">
								<textarea class="form-control" name="content" id="content" rows="20"
									cols="100s" placeholder="CONTENT"></textarea>
							</div>
						</div>
					</div>
				<!-- 				글쓰기블럭끝 -->
				</form>
			</div>
		</div>
	</div>
	</div>

	<jsp:include page="./inc/bottom.jsp"></jsp:include>

	<!-- 
    Essential Scripts
    =====================================-->

	<!-- Main jQuery -->
	<script src="${contextPath}/plugins/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap 3.1 -->
	<script src="${contextPath}/plugins/bootstrap/js/bootstrap.min.js"></script>
	<!-- Bootstrap Touchpin -->
	<script
		src="${contextPath}/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
	<!-- Instagram Feed Js -->
	<script src="${contextPath}/plugins/instafeed/instafeed.min.js"></script>
	<!-- Video Lightbox Plugin -->
	<script
		src="${contextPath}/plugins/ekko-lightbox/dist/ekko-lightbox.min.js"></script>
	<!-- Count Down Js -->
	<script
		src="${contextPath}/plugins/syo-timer/build/jquery.syotimer.min.js"></script>

	<!-- slick Carousel -->
	<script src="${contextPath}/plugins/slick/slick.min.js"></script>
	<script src="${contextPath}/plugins/slick/slick-animation.min.js"></script>

	<!-- Google Mapl -->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
	<script type="text/javascript"
		src="${contextPath}/plugins/google-map/gmap.js"></script>

	<!-- Main Js File -->
	<script src="${contextPath}/js/script.js"></script>



</body>
</html>