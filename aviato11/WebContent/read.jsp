<%@page import="blog.BlogVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getAttribute("name").toString();//뿌려줄 글쓴이 이름
	String title = request.getAttribute("title").toString();//뿌려줄 글제목
	String date = request.getAttribute("date").toString();//작성일
	String cnt = request.getAttribute("cnt").toString();//조회수
	//뿌려줄 글 내용
	String content = request.getAttribute("content").toString().replace("\r\n", "<br/>");
	String nowPage = request.getAttribute("nowPage").toString();//현재 상세보기 페이지로 오기 전의 페이지 번호
	String idx = request.getAttribute("idx").toString();//뿌려줄 글번호
	String imageFileName = request.getAttribute("imageFileName").toString();
	
	//여기부터는 댓글 내용
	ArrayList reList = (ArrayList) request.getAttribute("reList");
	String totalRe = request.getAttribute("totalRe").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="./inc/top.jsp"></jsp:include>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Read Blog</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/style.css" />
<%-- (2) --%>
<script type="text/javascript">
	function fnDelete() {
		//패스워드 입력하지 않았을때
		if (document.getElementById("pass").value == "") {
			alert("반드시 암호를 입력하세요");
			document.getElementById("pass").focus();
			return;
		}
		//패스워드 입력 했다면..<form>전송
		document.frmDelete.submit();
	}

	function fnEdit() {
		//패스워드 입력하지 않았을때
		if (document.getElementById("pass").value == "") {
			alert("반드시 암호를 입력하세요");
			document.getElementById("pass").focus();
			return;
		}
		//패스워드 입력 하고 EDIT버튼을 눌렀다면..frmDelete폼의 action이 변경되어 수정요청 주소로 바꿨다.
		document.frmDelete.action = "modifyPass.bg";
		//패스워드 입력 했다면..<form action = "modifyPass.bg"> 비밀번호 확인으로 전송
		document.frmDelete.submit();
	}
	
	function fnReply() {
		//패스워드 입력하지 않았을때
		if (document.getElementById("repass").value == "") {
			alert("반드시 암호를 입력하세요");
			document.getElementById("repass").focus();
			return;
		}
		//패스워드 입력 했다면..<form>전송
		document.frmReply.submit();

	}
	
	function fnDeleteRe() {
		
		document.frmDeleteRe.submit();

	}
	
</script>
</head>
<body>
	<!-- 상단 메뉴 디자인 -->
	<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Blog</h1>
					<ol class="breadcrumb">
						<li><a href="${contextPath}/index.jsp">Home</a></li>
						<li onclick="location.href='BlogList.bg?nowPage=<%=nowPage%>'"
							class="active">LIST</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
	</section>
	<!-- 상단 메뉴 디자인 끝 -->
	<section class="page-wrapper">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- 	        			글내용한블럭시작 -->
				<div class="post post-single">
					<div class="post-thumb">
						<input type="hidden" name="originalFileName"
							value="${imageFileName}" />
						<%-- 조회된 이미지 파일이름이 존재하면 글 번호와 이미지 파일이름을  
				         FileDownloadController서블릿으로 전송한 후 <img>태그자체에 다운로드시켜 표시합니다.  --%>
						<img
							src="${contextPath}/download.fl?idx=<%=idx %>&imageFileName=<%=imageFileName%>"
							width=1140 height=700 align="center" /><br>
					</div>
					<h2 class="post-title"><%=title%></h2>
					<div class="post-meta">
						<ul>
							<li><i class="tf-ion-ios-calendar"></i> <%=date%></li>
							<li><i class="tf-ion-android-person"></i> POSTED BY <%=name%>
							</li>
							<li><a href="#!"><i class="tf-ion-ios-pricetags"></i> <%=cnt%>
									HTIS</a></li>
							<li><a href="#!"><i class="tf-ion-chatbubbles"></i> <%=totalRe %>
									COMMENTS</a></li>
						</ul>
					</div>
					<!-- 글 내용  -->
					<div class="post-content post-excerpt">
						<p><%=content%><br>Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Velit vitae placeat ad architecto nostrum
							asperiores vel aperiam, veniam eum nulla. Maxime cum magnam,
							adipisci architecto quibusdam cumque veniam fugiat quae. Lorem
							ipsum dolor sit amet, consectetur adipisicing elit. Odio vitae ab
							doloremque accusamus sit, eos dolorum officiis a perspiciatis
							aliquid. Lorem ipsum dolor sit amet, consectetur adipisicing
							elit. Quod, facere.
						</p>
						
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Ex error esse a dolore, architecto sapiente, aliquid commodi,
							laudantium eius nemo enim. Enim, fugit voluptatem rem molestiae.
							Sed totam quis accusantium iste nesciunt id exercitationem cumque
							repudiandae voluptas perspiciatis, consequatur quasi, molestias,
							culpa odio adipisci. Nesciunt optio fugiat iste quam modi, ex
							vitae odio pariatur! Corrupti explicabo at harum qui doloribus,
							sit dicta nemo, dolor, enim eum molestias fugiat obcaecati autem
							eligendi? Nisi delectus eaque architecto voluptatibus, unde sit
							minus quae quod eligendi soluta recusandae doloribus, officia,
							veritatis voluptatum eius aliquam quos. Consectetur, nisi?
							Veritatis totam, unde nostrum exercitationem tempora suscipit,
							molestias, deserunt ipsum laborum aut iste eaque? Vitae delectus
							dicta maxime non mollitia? Sapiente eos a quia eligendi deserunt
							repudiandae modi molestias tenetur autem pariatur ullam itaque,
							quas eveniet, illo quam rerum ex obcaecati voluptatum nesciunt
							incidunt culpa provident illum soluta.</p>
					</div>
					<hr>
					<div>
						<div class="form-group">
							<h5>Please enter password</h5>
							<form name="frmDelete" method="post" action="delete.bg"
								style="padding-bottom: 10px">
								<input type="hidden" name="idx" value="<%=idx%>" />
								<input type="hidden" name="nowPage" value="<%=nowPage%>" />
								<input type="password" name="pass" style="margin-bottom: 10px"
									id="pass" class="form-control" placeholder="password" >
								<%-- 글 수정 버튼 onclick="location.href='modify.bg?nowPage=<%=nowPage%>&idx=<%=idx%>'"--%>
								<button type="button" class="btn btn-main btn-small"
									onclick="fnEdit();">EDITE</button>
								<%-- 글 목록 버튼 --%>
								<button type="button" class="btn btn-main btn-small"
									onclick="location.href='BlogList.bg?nowPage=<%=nowPage%>'">
									LIST</button>
								<%-- 글 삭제 버튼 (1) --%>
								<button type="button" class="btn btn-main btn-small"
									onclick="fnDelete();">DELETE</button>
							</form>
						</div>
					</div>

					<!-- 댓글달기 시작 -->
				<form method="post" name="frmDeleteRe" action="deleteRe.bg">
					<div class="post-comments">
						<h3 class="post-sub-heading"> <%=totalRe%> Comments</h3>
						<ul class="media-list comments-list m-bot-50 clearlist">
							<!-- Comment Item start-->
							<%
								//게시판에 글이 없다면
								if (reList.isEmpty()) { //게시판 글을 모두 저장한 list배열이 비어있으면
								%>
								<h3>No registered Comments</h3>
								<%
								//게시판에 글이 있다면
								} else {
									
								%>
								<!-- 댓글 한블럭시작 -->
								<%
									for(int i=0;i<reList.size();i++){
										
									BlogVO vo = (BlogVO) reList.get(i);
									
									String r_name = vo.getR_name();
									String r_date = vo.getR_date();
									String r_content = vo.getR_content();
									int r_idx = vo.getR_idx();
									int r_group = vo.getR_group();
									int r_level = vo.getR_level();
									int b_idx = vo.getB_idx();
								%>
							<li class="media"><a class="pull-left" href="#!">
							</a> <!-- 댓글목록 -->
								<div class="media-body">
									<div class="comment-info">
										<h4 class="comment-author">
											<a href="#!"><%=r_name%></a>
										</h4>
										<time><%=r_date%></time>
										<input type="hidden" name="r_idx" value="<%=r_idx%>">
										<input type="hidden" name="b_idx" value="<%=b_idx%>">
										<a class="comment-button" onclick="fnDeleteRe();">
										Delete</a>
										
									</div>
									<p><%=r_content%></p><hr>
								</div>
							</li>
							<%
								}//댓글목록출력 for문 끝
							}//else끝		
							%>
							<!-- End Comment Item -->
						</ul>
						
					</div>
				</form>
					<!-- 답변 글쓰기 -->
					<div class="post-comments-form">
						<h3 class="post-sub-heading">Leave You Comments</h3>
						<form name="frmReply" method="post" action="sendRe.bg">
							<input type="hidden" name="b_idx" value="<%=idx%>" />
							<input type="hidden" name="nowPage" value="<%=nowPage%>" />
							<div class="row">
								<div class="col-md-6 form-group">
									<!-- 답글 이름 -->
									<input type="text" name="rewriter" id="name"
										class=" form-control" placeholder="Name">
								</div>
								<div class="col-md-6 form-group">
									<input type="password" name="repass" id="repass"
										class=" form-control" placeholder="password">
								</div>
								<!-- 답변 내용 입력창 -->
								<div class="form-group col-md-12">
									<textarea name="recontent" id="recontent" class=" form-control"
										rows="6" placeholder="Comment" maxlength="400"></textarea>
								</div>

								<!-- 답변글 등록 버튼 -->
								<div class="form-group col-md-12">
									<button type="button" onclick="fnReply();" class="btn btn-small btn-main ">
										Send comment
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>

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
	<script type="text/javascript" src="plugins/google-map/gmap.js"></script>

	<!-- Main Js File -->
	<script src="${contextPath}/js/script.js"></script>

	</body>
</html>