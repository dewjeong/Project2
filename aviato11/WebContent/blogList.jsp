<%@page import="blog.BlogVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");

	//int total = Integer.parseInt (request.getAttribute("total").toString());
	//out.println(String.valueOf(total));
	//valueOf()는 객체를 문자열로 변환하여 반환하는 메소드입니다.
	//int로 선언된 total변수는 리퀘스트에서 문자열로 가져온 total을 Integer.parseInt를 통해
	//숫자로 변환하여 int total에 저장되었고 이 int값을 문자열로 출력하기 위해서
	//out.println내에서 valueOf 메소드를 통해 문자열로 만들어준것으로 보입니다.
	
	//페이징처리 변수 처리
	int totalRecord = 0; //게시판의 총 글의 개수
	int numPerPage = 5; //한 페이지 당 보여질 글의 개수
	int pagePerBlock = 5; //하나의 블럭당 묶여질 페이지 개수 //1,2,3 <-- 하나의 블럭
	int totalPage = 0; //총 페이지 수
	int totalBlock = 0; //총 블럭 수
	int nowPage = 0;//현재 사용자에게 보여질 페이지 번호 (선택된 페이지 번호를 말합니다.)
	int nowBlock = 0;//현재 사용자에게 보여질 블럭 번호 (선택된 페이지의 블럭 위치를 말합니다.)
	int beginPerPage = 0; //각각의 매 페이지마다 보여질 시작 글번호(맨 위의 글번호)
	
	//blogController.java(서블릿)에서 전달한 request영역 내부에 select한 글목록이 담긴 ArrayList가져오기
	//컨트롤러에서 req.setAttr를 통해 DAO에서 가져온 글 목록을 배열을 list라는 키로 저장했습니다.
	//현재 페이지에서 req.getAttr를 통해 list키로 꺼내어서
	//list라는 ArrayList를 생성하여 컨트롤러에서 온 글목록을 저장해줍니다.
	//getAttr에서는 오브젝트 타입으로 반환하기 때문에 ArrayList형식으로 다운캐스팅합니다.
	ArrayList list = (ArrayList) request.getAttribute("list");
	
	//게시판에 존재하는 총 글의 개수는 totalRecord에 담습니다.
	//총 글의 개수는 DB에 존재하는 1개 글(행) 단위로 1개의 인덱스를 가지는
	//list배열에 담겨있으므로 list배열의 (인덱스)크기가 즉 총 글의 개수가 됩니다.
	totalRecord = list.size(); //게시판의 총 글의 개수를 구하여 저장
	
	/*현재 사용자에게 보여질 페이지번호 구하기*/
	//blogController로부터 전달받는데..현재 사용자에게 보여질 페이지번호가 있을때
	if (request.getAttribute("nowPage") != null) {//컨트롤러에서 현재페이지번호를 저장했었음
		//blogController로부터 전달받는데 현재 사용자에게 보여질 페이지 번호를 받아와서 저장
		//nowPage는 int타입
		//request.getAttribute("nowPage")는 Obj타입
		//Integer.parseInt()는 String을 int로 변환함
		nowPage = Integer.parseInt(request.getAttribute("nowPage").toString());
	
	}
	
	/*매 페이지마다 보여질 시작 글번호 (맨위의 글번호) 구하기*/
	//시작 글번호 = 현재페이지번호*한 페이지 당 보여질 글의 개수
	//만약 현재 페이지번호가 2이고 한 페이지당 보여질 글개수가 5개로 설정했으므로
	//2페이지를 눌렀을때 보여질 시작 글번호는 10입니다.
	//1페이지 - 1~ 5번글
	//2페이지 - 6~ 10번글 이 보이도록 페이지당 5개글씩 설정돼있으므로
	//가장 최신글인 10번글을 2번페이지를 눌렀을때 시작 글번호가 10번이 됩니다.
	beginPerPage = nowPage * numPerPage;
	//0 = 0 * 5
	
	//+ beginPerPage설명 :
	//예를 들어 한페이지당 보여질 글의 개수가 6개라고 가정할때..(&총 글의 개수는 14개이면)
	//1번페이지의 경우... 1번 페이지가 보여질 시작 글번호는 6이다.
	//nowPage * numPerPage
	//페이지번호 1 * 한페이지당 보여질 글의 개수 6 = 시작 글번호 6
	
	//2번페이지의 경우... 2번 페이지가 보여질 시작 글번호는 12이다.
	//nowPage * numPerPage
	//페이지번호 2 * 한페이지당 보여질 글의 개수 6 = 시작 글번호 12
	
	//3번페이지의 경우... 3번 페이지가 보여질 시작 글번호는 14이다.
	//3번페이지에서 보여질 시작 글번호는 총 글의 개수로 구한다.
	/*
	
	6				12				14(총 글 개수)
	5				11				13
	4				10
	3				9
	2				8
	1				7
	------------------------------------------------
	1번 페이지			2번 페이지			3번 페이지
	
	*/
	/*총 페이지 수 구하기*/
	//총 페이지 수 = 총 글의 개수 / 한페이지당 보여질 글의 개수
	//참고 ! 하나의 글이 더 오버될 경우에 한페이지 올림 처리 글이 14개면 14 / 6 = 2개페이지 하고 2개글 남으니 3개페이지 나와야함
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
	//추가 설명                            44        /    5
	//9
	
	//Math.ceil()는 소숫점 발생시 바로 다음 정수값을 반환합니다.
	//만약 숫자가 이미 정수라면 다른 작업을 하지 않고 그 숫자를 그대로 반환합니다
	//즉 소수점이 있다면 무조건 올림처리합니다. ex) 15.1 -> 16 , 16 -> 16, 16.8 -> 17
	
	//그러니까 Math.ceil((double)totalRecord / numPerPage);은
	//일단 Math.ceil은 double타입이니까
	//원래 int인 totalRecord와 numPerPage를 double로 만들어 계산
	//Math.ceil(14.0 / 6.0 )= 2.3인데 .ceil로 올림해서 3.0 만들어주고
	//저장할 totalPage변수가 int이니까
	//앞에 (int)Math.ceil을 해서 3.0을 3으로 만들어서 3을 totalPage로 저장한것
	
	/*현재 사용자에게 보여질 블럭번호 구하기*/
	//blogController로부터 전달받는데..현재 사용자에게 보여질 블럭번호가 있을때
	if (request.getAttribute("nowBlock") != null) {
		//blogController로부터 전달받는데 현재 사용자에게 보여질 블럭번호를 받아와서 저장
		nowBlock = Integer.parseInt(request.getAttribute("nowBlock").toString());
	}
	
	/*총 블럭 수 구하기*/
	//총 블럭 수 = 총 페이지수 / 하나의 블럭당 묶여질 페이지 개수
	//설명 : 하나의 페이지가 더 오버할 경우 한블럭 올림 처리
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Blog List</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/style.css" />

<script type="text/javascript">
	
<%-- 순서2. 검색어를 입력하지 않고 검색 눌렀을때..--%>
	function fnSearch() {
		//검색어 값 가져오기
		var word = document.getElementById("word").value;
		//검색어를 입력 하지 않았다면 ..
		if (word == null || word == "") {
			alert("검색어를 입력하세요."); //메세지창
			//id가 word인 input에 포커스 줍니다.
			document.getElementById("word").focus();
			return;
		} else {//검색어를 입력 했다면 blogController로 검색어,검색 기준값 전송
			document.frmSearch.submit();
		}
	}
<%-- 순서2. 검색어를 입력하지 않았을때 끝---------- --%>
	
</script>

<script type="text/javascript">
	//하나의 글 상세보기 하기 위한 글제목 링크를 클릭했을때
	//글 번호를 전달받는다
	function fnRead(val) {
		//blogController에 전달할 글 상세보기 페이지 요청 가상 주소 저장
		document.frmRead.action = "read.bg";
		//blogController에 전달할 상세볼 글번호 저장
		document.frmRead.idx.value = val;
		//blogController로 요청
		document.frmRead.submit();

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
						<h1 class="page-name">Blog</h1>
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
				<!-- 사이드바 시작 -->
				<div class="col-md-4">
					<aside class="sidebar">
						<div class="widget widget-subscription">
							<div style="margin-bottom: 60px;">
								<button type="button" onclick="location.href='write.bg'"
									class="btn btn-main">+ WRITE</button>
							</div>
							<h4 class="widget-title">Get notified updates</h4>
							<form action="<%=request.getContextPath()%>/blog/searchList.bg"
								method="post" name="frmSearch" onsubmit="javascript:fnSearch();">
								<div class="form-group">
									<select name="key" class="form-control">
										<option value="titleContent">
											<h4 class="widget-title">TITLE + CONTENT</h4>
										</option>
										<option value="name">
											<h4 class="widget-title">WRITER</h4>
										</option>
									</select>
								</div>
								<input type="text" style="margin-bottom: 10px;" name="word"
									id="word" class="form-control">
								<button type="submit" class="btn btn-main">Search</button>
							</form>
						</div>

						<!-- Widget Latest Posts -->
						<div class="widget widget-latest-post">
							<h4 class="widget-title">Latest Posts</h4>
							<% //검색 결과 개수에 따라 달라지기 떄문에..목록에 있는 글이 5개 미만일때
								if (list.size() < 5) {
								for (int i = 0; i < list.size(); i++) {
									BlogVO vo = (BlogVO) list.get(i);
									String title = vo.getB_title();
									String content = vo.getB_content();
									String imageFileName = vo.getB_imageFN();
									int idx = vo.getB_idx();
							%>
							<div class="media">
								<a class="pull-left" href="javascript:fnRead('<%=idx%>')"> <img
									class="media-object"
									src="${contextPath}/download.fl?idx=<%=idx %>&imageFileName=<%=imageFileName%>"
									alt="Image">
								</a>
								<div class="media-body">
									<h4 class="media-heading">
										<a href="javascript:fnRead('<%=idx%>')"><%=title%></a>
									</h4>
									<p><%=content%>Lorem ipsum dolor sit amet.
									</p>
								</div>
							</div>
							<%
								}
							} else {//목록에 있는 총 글의 개수가 5개 이상일때
							for (int i = 0; i < 5; i++) {

							BlogVO vo = (BlogVO) list.get(i);
							String title = vo.getB_title();
							String content = vo.getB_content();
							String imageFileName = vo.getB_imageFN();
							int idx = vo.getB_idx();
							%>
							<div class="media">
								<a class="pull-left" href="javascript:fnRead('<%=idx%>')"> <img
									class="media-object"
									src="${contextPath}/download.fl?idx=<%=idx %>&imageFileName=<%=imageFileName%>"
									alt="Image">
								</a>
								<div class="media-body">
									<h4 class="media-heading">
										<a href="javascript:fnRead('<%=idx%>')"><%=title%></a>
									</h4>
									<p><%=content%>Lorem ipsum dolor sit amet.
									</p>
								</div>
							</div>
							<%
								}
							}
							%>
						</div>
						<!-- End Latest Posts -->


					</aside>
				</div>
				<!-- 사이드바끝 -->
				<div class="col-md-8">
					<!-- 글 내용 뿌려주기 -->
					<%
						//게시판에 글이 없다면
					if (list.isEmpty()) { //게시판 글을 모두 저장한 list배열이 비어있으면
					%>
					<h3>No article registered</h3>
					<%
						//게시판에 글이 있다면
					} else {
					%>
					<!-- 	        			글내용한블럭시작 -->
					<%
						//0                                  5
					//각 페이지마다 보여질 시작 글번호 -> beginPerPage부터 
					//(각 페이지마다 보여질 시작글번호 + 한페이지당 보여질 글의 개수) 만큼 반복
					for (int i = beginPerPage; i < (beginPerPage + numPerPage); i++) {
						//여기는 DB입장에서 보기
						//ex	i = 6		i<(6+6)		6++
						// 6번글~11번글까지 6개의 글

						//만약 각 페이지마다 보여질 시작 글번호가 게시판 총 글의 개수와 같아질때
						if (i == totalRecord) {//마지막 페이지에 글이 하나만 존재할때
							//for문 빠짐
							break;
						}
						//ArrayList안에 있는 하나의 글정보 (VO)를 꺼내와서 저장
						//VO클래스타입의 변수 vo에다가 list 값을 넣어준다.
						//DAO에서 전체 글목록 저장할때 list.add(vo);했고
						//list.add(vo);를 bloglist.jsp에서 뿌려줄때 쓸 dto생성하고
						BlogVO vo = (BlogVO) list.get(i);
						//dto.get해서 각 변수에 담아준다
						String name = vo.getB_name();
						String title = vo.getB_title();
						String date = vo.getB_date();
						String content = vo.getB_content();
						String imageFileName = vo.getB_imageFN();
						int idx = vo.getB_idx();//글번호
						int cnt = vo.getB_cnt();
					%>
					<!-- 		글한개시작 -->
					<div class="post">
						<div class="post-media post-thumb">
							<a href="javascript:fnRead('<%=idx%>')"> <input type="hidden"
								name="originalFileName" value="${imageFileName}" /> <%-- 조회된 이미지 파일이름이 존재하면 글 번호와 이미지 파일이름을  
				         FileDownloadController서블릿으로 전송한 후 <img>태그자체에 다운로드시켜 표시합니다.  --%>
								<img
								src="${contextPath}/download.fl?idx=<%=idx %>&imageFileName=<%=imageFileName%>"
								width=750 height=341.53 align="center" /><br>
							</a>
						</div>
						<h2 class="post-title">
							<!-- 					<a href="blog-single.jsp">How To Wear Bright Shoes</a> -->
							<!-- 글제목 눌렀을때 상세페이지로 이동하는 요청 컨트롤러에 전달하고
						상세 볼 글번호를 fnRead함수로 전달합니다 -->
							<a href="javascript:fnRead('<%=idx%>')"><%=title%></a>
						</h2>
						<div class="post-meta">
							<ul>
								<li><i class="tf-ion-ios-calendar"></i><%=date%></li>
								<li><i class="tf-ion-android-person"></i> POSTED BY <%=name%></li>
								<li><a href="#!"><i class="tf-ion-ios-pricetags"></i> <%=cnt%>
										HTIS</a></li>
<!-- 								<li><a href="#!"><i class="tf-ion-chatbubbles"></i> -->
<!-- 										4 COMMENTS</a></li> -->
							</ul>
						</div>
						<div class="post-content">
							<p>
								<a href="javascript:fnRead('<%=idx%>')"><%=content%>Lorem
									ipsum dolor sit amet, consectetur adipisicing elit. Velit vitae
									placeat ad architecto nostrum asperiores vel aperiam, veniam
									eum nulla. Maxime cum magnam, adipisci architecto quibusdam
									cumque veniam fugiat quae. Lorem ipsum dolor sit amet,
									consectetur adipisicing elit. Odio vitae ab doloremque
									accusamus sit, eos dolorum officiis a perspiciatis aliquid.
									Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quod,
									facere.
							</p>
							<a href="javascript:fnRead('<%=idx%>')" class="btn btn-main">Continue
								Reading</a>
						</div>

					</div>
					<!-- 				글목록한블럭끝 -->
					<%
						} //if ~ else 끝
					%>

					<!-- 				페이징시작 -->
					<div class="text-center">
						<ul class="pagination post-pagination">
							<%
								if (totalRecord != 0) {//게시판 총 글의 개수가 0이 아닐때
							%>
							<%
								if (nowBlock > 0) {//현재 보고 있는 블럭이 0보다 클때
							%>
							<!-- 이전 버튼을 눌렀을때 -->
							<li class="active"><a
								href="BlogList.bg?nowBlock=<%=nowBlock - 1%>
							&nowPage=<%=((nowBlock - 1) * pagePerBlock)%>">Prev
									<%-- 							<%=pagePerBlock %> --%>
							</a></li>
							<%
								}
							%>
							<%
								for (int i = 0; i < pagePerBlock; i++) {
							%>
							<li><a class="viewPG"
								href="BlogList.bg?nowBlock=<%=nowBlock%>
							&nowPage=<%=(nowBlock * pagePerBlock) + i%>">
									<%=(nowBlock * pagePerBlock) + i + 1%> <%
 	if ((nowBlock * pagePerBlock) + i + 1 == totalPage)
 	break;
 %>
							</a></li>
							<%
								}
							%>
							<%
								if (totalBlock > nowBlock + 1) {
							%>
							<li class="active"><a
								href="BlogList.bg?nowBlock=<%=nowBlock + 1%>&nowPage=<%=((nowBlock + 1) * pagePerBlock)%>">
									Next <%-- 						<%=pagePerBlock %> --%>
							</a></li>
							<%
								}
							%>
							<%
								}
							%>
							<%
								}
							%>
						</ul>
					</div>
					<!-- 				페이징끝 -->
				</div>
			</div>
		</div>
	</div>

	<%-- read.jsp로 이동시 동적으로 바뀌는 글번호와, 현재 선택한 페이지번호를 전달한다. --%>
	<form name="frmRead" method="post">
		<input type="hidden" name="idx" value=""> <input type="hidden"
			name="nowPage" value="<%=nowPage%>">
	</form>

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