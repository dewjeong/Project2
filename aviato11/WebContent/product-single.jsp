<%@page import="singleProduct.singleBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
 
<%request.setCharacterEncoding("utf-8");%>
   
   <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%-- JSTL라이브러리의 Formatting태그들을 사용하기 위해 taglib 지시자를 선언 --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
 <fmt:parseNumber value="${sBean.pdPrice*(100-sBean.sale_Val)/100}" var="final_price" integerOnly="true"/>

<jsp:include page="./inc/top.jsp"></jsp:include> 


<style>
	#paging{margin-left: 80px;}
	#reply{margin-left: 40px;}
	#leaveReview{margin-top: 50px; margin-bottom: 20px;}
	#review_input{width: 1030px; height: 80px;}
	#reply_input{width: 1010px; height: 50px;}
	#reply_ul{margin-left: 20px;}
	#edit_review_input{width: 1010px; height: 50px;}
	#edit_reply_input{width: 1010px; height: 50px;}
	
	.bage{	 position: absolute;
 			 top: 5px;
 			 left: 12px;	
		    font-size: 50px;
		    color: red;
		    width: 50px;
    }
    
    .carousel-inner{ position: relative;}
    .item{position: relative;}
    #down{border-color: lightgray;}
	
</style>

<%-- <% singleBean sBean = (singleBean)request.getAttribute("sBean"); %>
<%=sBean.getPdNum()%> --%>



<script>

//카트페이지로 값 넘겨주기
function sendCart() {
	
	var pdqty =   $('input[name=product-quantity]').val();

	var color = selectColor();
	
	location.href = "${contextPath}/shop/Cart.do?pNum=${sBean.pdNum}&pName=${sBean.pdName}&cPrice=${sBean.pdPrice}"
				  +"&fPrice=${final_price}&pImg=${sBean.pdImg_Main}&pdqty="+pdqty+"&pdColor="+color;
}

// sendCart()메소드로 보낼 컬러 선택한 값 
function selectColor() {
	
	var color = $('select[name=color]').val();
		
		return color;
} 

var os = 0;


 function showReview() {
	 
		$.ajax({
			url:'${contextPath}/single/showReview.do?offset='+os+'&pdNum='+${sBean.pdNum},
			type:"post",
			//data:{ 속성1:값1 , 속성2:[ㅇ,ㅇ],  속성3:[{속성1,속성값1, }    ]   },
		
       		dataType : 'text',//응답받을 데이터 타입
        	
			
			  success:function(resData){
				
				console.log(resData);
				
				var json = JSON.parse(resData);//컨트롤러에서 넘어온 String객체를 jason객체로 변환!
				
				var Comment_Item='';
				
		for(var i in json){
					
// 					$("#r_name").text(json[i].name);
// 					$("#r_time").text(json[i].rTime);
// 					$("#r_content").text(json[i].rContent);
					
				if(json[i].rNo != null){//부모글 갯수만큼 반복	
					
					Comment_Item += '<li class="media">'

			        +'<a class="pull-left" >'
			            +'<img class="media-object comment-avatar" src="${contextPath}/images/blog/avater-1.jpg" alt="" width="50" height="50">'
			        +'</a>'

			        +'<div class="media-body">'

			          + ' <div class="comment-info">'
			               + '<div class="comment-author">'
			                   + '<a id="r_name" >'+json[i].name+'</a>'
			               + '</div>'
			                +'<time id="r_time">'+json[i].rTime+'</time>'
			                
			                
			                +'<a class="comment-button" href="#!" onclick="rp_review('+json[i].rNo+');"><i class="tf-ion-chatbubbles"></i>REPLY</a>'
			                +'<a class="comment-button" href="#!" onclick="getReview('+json[i].rNo+');">&nbsp;/&nbsp;EDIT</a>'
			                +'<a class="comment-button" href="#!" onclick="r_delete('+json[i].rNo+');">&nbsp;/&nbsp;DELETE</a>'
			            
			                
			                +'</div>'
			           
			            +'<span hidden id="span_reply'+json[i].rNo+'">'+json[i].rNo+'</span>'//부모글 글번호
						
			            +'<p id="r_content'+json[i].rNo+'_">'
			            
			            +json[i].rContent
			              
			            +'</p>'
			            +'<p id="rr_content'+json[i].rNo+'_">'
			            +'</p>'
			            ;
			            
		//*****************************************댓글 시작*****************************//
		for(var j in json){	            
			if(json[i].rNo == json[j].__rPtNo){
				            
				Comment_Item += '<div class="comment-info" id="reply">'
			   					    +'<h4 class="comment-author">'
			   					    +'<span id="reply_rptNo" hidden>'+json[j].rNo+'</span>'//댓글 글번호
			    						+'<a>'+json[j].__name+'</a>&nbsp;&nbsp;&nbsp;<time>'+json[j].__rTime+'</time>'
			    							
			    							+'<a class="comment-button" href="#!" onclick="getReply('+json[j].__rNo+');"><time id="lower">&nbsp;&nbsp;&nbsp;&nbsp;EDIT</time></a>'
						                	+'<a class="comment-button" href="#!" onclick="rp_delete('+json[j].__rNo+');"><time id="lower">&nbsp;/&nbsp;&nbsp;&nbsp;DELETE</time></a>'
			    						
									+'</h4>'							
									+'<p id="rp_content'+json[j].__rNo+'">'
										+json[j].__rContent
									+'</p>'
								+'</div>';		            
				}//if문	
				
				
				
				
			}//안쪽 for문	
		//*****************************************댓글 끝***************************//

	 Comment_Item += '</div>'

			    +'</li>';
			    
				}//바깥 if    	
			}//for

			
			$("#commen_item").html(Comment_Item);
			}//success:	
		});
}//showReview메소드 끝

function next() {
	
	os+=3;	
	var totrv = $("#totReviews").text();
	
	if(os>=totrv){  os=totrv-1;}
	//if(os>=${totReviews}){	os=${totReviews}-1; 	}
	//if(r_delete.load()){	os=${totReviews}-2;}		
	
	showReview();	
}
 

 
function prev() {	
	os-=3;	
	if(os<0){os=0;}
	
	showReview();		
} 

/*리뷰 작성 submit*/
function submit() {
	
	var name = $("#Name").text();
	var email = $("#Email").text();
	var content = $("#review_input").val();
	if(content == "" || content == null){alert("한 글자 이상 입력해주세요."); return false;}
	
	content = content.replace(/(\r\n|\n\r|\r|\n)/g, "<br>");//띄어쓰기 변환해줌
	
	
	$.ajax({
		url:'${contextPath}/single/leaveReview.do?content='+content+'&pdNum='+${sBean.pdNum}+'&name='+name+'&email='+email,
		type:"post",
		//data:{ 속성1:값1 , 속성2:[ㅇ,ㅇ],  속성3:[{속성1,속성값1, }    ]   },
	
      	dataType : 'text',//응답받을 데이터 타입
 		
		success:function(resData){
			
			var json = JSON.parse(resData);//컨트롤러에서 넘어온 String객체를 jason객체로 변환!
			
			$("#totReviews").text(json.totReviews);
			
			$("#review_input").val('');
			 os=${totReviews}-1;
			showReview(); 
						
		  }
	});
	
	
}//submit메소드 끝

/*댓글 입력창 띄우기*/
function rp_review(rptNo) {
	
	var rp_reply;
	
	rp_reply = 
		'<div class="panel-heading_1" role="tab" id="hideme">'		
			+'<h4 class="panel-title">'
	        	+'<a >'
	          	+'Leave Reply'
	        	+'</a>'
	      	+'</h4>'
		
		+'<ul id="reply_ul">'
			+'<span hidden id="span_reply">'+rptNo+'</span>'//부모글 번호 
			+'<textarea rows="3" style="resize: none; white-space:pre-wrap;" type="text" id="reply_input" name="reply_input"/>'
			+'<li><a href="#!" onclick="reply_submit('+rptNo+');">Leave a Reply</a>'//부모글 번호 매개변수로 넘기기
			//+'<a href="#!" onclick=$(this).parent().parent().parent().hide();>&nbsp;&nbsp;/&nbsp;&nbsp;Cancle</a></li>'
			+'<a href="#!" onclick=showReview();>&nbsp;&nbsp;/&nbsp;&nbsp;Cancle</a></li>'
		+'<ul>'
		+'</div>'
		;
	
	
	
	//console.log("번호 : "+ rptno);
	
	var tag_id = "#rr_content"+rptNo+"_";
		
	$(tag_id).html(rp_reply);
}//rp_review메소드 끝


/*댓글 작성하는 메소드*/
function reply_submit(rptNo) {
	
	var content = $("#reply_input").val();
	if(content == "" || content == null){alert("한 글자 이상 입력해주세요."); return false;}
	content = content.replace(/(\r\n|\n\r|\r|\n)/g, "<br>");
	
	$.ajax({
		url:'${contextPath}/single/leaveReply.do?rptNo='+rptNo+'&content='+content+'&pdNum='+${sBean.pdNum}+'&name=댓글&email=@naver.com',
		type:"post",
		//data:{ 속성1:값1 , 속성2:[ㅇ,ㅇ],  속성3:[{속성1,속성값1, }    ]   },
	
      	dataType : 'text',//응답받을 데이터 타입
 		
		success:function(resData){
			
			var json = JSON.parse(resData);//컨트롤러에서 넘어온 String객체를 jason객체로 변환!
			
			$("#reply_input").val('');
			$(".panel-heading_1").hide();
			 //os=${totReviews}-1;
			showReview(); 
		
		  }
	});
	
	
}//reply_submit메소드 끝


/*부모글 수정 메소드1 - 부모글 내용 받아오기*/
function getReview(rNo) {
	
var review;
	
	review = 
		'<div class="panel-heading_2" role="tab" id="headingOne">'		

		+'<ul id="reply_ul">'
			+'<span hidden id="span_reply">'+rNo+'</span>'//부모글 번호 
			+'<textarea rows="3" style="resize: none; white-space:pre-wrap;" id="edit_review_input" class="edit_review_input'+rNo+'" name="reply_input"/>'
			+'<li><a href="#!" onclick="edit_review_submit('+rNo+');">Edit Review</a>'//부모글 번호 매개변수로 넘기기
			+'<a href="#!" onclick=showReview();>&nbsp;&nbsp;/&nbsp;&nbsp;Cancle</a></li>'
			+'<ul>'
		+'</div>';
	
	var tag_id = "#r_content"+rNo+"_";
		
	$(tag_id).html(review);
	
	/*부모글 내용 받아오기*/
	$.ajax({url:'${contextPath}/single/getReview.do?rNo='+rNo+'&pdNum='+${sBean.pdNum},
			type:"post",
			dataType : "text",
			success:function(resData){
				
				//resData.replace("<br>", /(\r\n|\n\r|\r|\n)/g);
				
				var input = ".edit_review_input"+rNo;
				$(input).val(resData);
				
			}
			
	
	});
	
}

/*부모글 수정 메소드2 - submit했을 때*/
function edit_review_submit(rNo) {
	
	var input = ".edit_review_input"+rNo;
	var rContent = $(input).val();
	if(rContent == "" || rContent == null){alert("한 글자 이상 입력해주세요."); return false;}
	
	rContent = rContent.replace(/(\r\n|\n\r|\r|\n)/g, "<br>");
	
	$.ajax({url:'${contextPath}/single/editReview.do?rNo='+rNo+'&pdNum='+${sBean.pdNum}+"&rContent="+rContent,
		type:"post",
		dataType : "text",
		success:function(resData){
			
			
			$(input).val("");
			$(".panel-heading_2").hide();
			
			showReview();
		}
		

});
}


/*부모글 삭제 메소드*/
function r_delete(rNo) {
	
	if(!confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?")){
	    return false;
	}

	$.ajax({	url:'${contextPath}/single/deleteReview.do?rNo='+rNo+'&pdNum='+${sBean.pdNum},
		type:"post",
		
      	dataType : 'text',//응답받을 데이터 타입
 		
		success:function(resData){
			
			var json = JSON.parse(resData);//컨트롤러에서 넘어온 String객체를 jason객체로 변환!
			
			$("#totReviews").text(json.totReviews);
			 os=0;
			showReview(); 
		}
		
	});
}

/*댓글 수정 메소드1 - 글내용 받아오기*/
function getReply(rNo) {
	
	console.log(rNo);
	
var review;
	
	review = 
		'<div class="panel-heading_3" role="tab" id="headingOne">'		

		+'<ul id="reply_ul">'
			+'<span hidden id="span_reply">'+rNo+'</span>'//글번호 
			+'<textarea rows=3" style="resize: none; white-space:pre-wrap;" id="edit_reply_input" class="edit_reply_input'+rNo+'" name="reply_input"/>'
			+'<li><a href="#!" onclick="edit_reply_submit('+rNo+');">Edit Review</a>'//부모글 번호 매개변수로 넘기기
			+'<a href="#!" onclick=showReview();>&nbsp;&nbsp;/&nbsp;&nbsp;Cancle</a></li>'
		+'<ul>'
		+'</div>';
	
	var tag_id = "#rp_content"+rNo;
		
	$(tag_id).html(review);
	
	/*글 내용 받아오기*/
	$.ajax({url:'${contextPath}/single/getReview.do?rNo='+rNo+'&pdNum='+${sBean.pdNum},
			type:"post",
			dataType : "text",
			success:function(resData){
				console.log(resData);
				
				var input = ".edit_reply_input"+rNo;
				$(input).val(resData);
				
			}
			
	
	});
	
}

/*댓글 수정 메소드2 - submit했을 때*/
function edit_reply_submit(rNo) {
	
	var input = ".edit_reply_input"+rNo;
	var rContent = $(input).val();
	if(rContent == "" || rContent == null){alert("한 글자 이상 입력해주세요."); return false;}
	
	rContent = rContent.replace(/(\r\n|\n\r|\r|\n)/g, "<br>");
	
	$.ajax({url:'${contextPath}/single/editReview.do?rNo='+rNo+'&pdNum='+${sBean.pdNum}+"&rContent="+rContent,
		type:"post",
		dataType : "text",
		success:function(resData){
			
			
			$(input).val("");
			$(".panel-heading_3").hide();
			
			showReview();
		}
		
});
}


/*댓글 삭제 메소드*/
function rp_delete(rNo) {
	
	if(!confirm("삭제하면 복구할 수 없습니다. 정말로 삭제하시겠습니까?")){
	    return false;
	}	

	$.ajax({	url:'${contextPath}/single/deleteReply.do?rNo='+rNo,
		type:"post",
		
      	dataType : 'text',//응답받을 데이터 타입
 		
		success:function(resData){
			showReview();
		}		
	});	
}

/*쿠폰 다운로드 전 회원 확인 메소드*/
function email() {
	
	var email = $("#Email").text();

	if(email == null || email == ""){
		if(!confirm("로그인 후에 이용해주세요.")){
		    return false;
		}else{//location.href="${contextPath}/login.jsp";
			
		}
	}else{
	
		$.ajax({	url:'${contextPath}/single/sendPromoCode.do?email='+email,
			type:"post",			
	      	dataType : 'text',//응답받을 데이터 타입	 		
			success:function(resData){
				
				if(resData == 1){alert("이메일로 프로모션 코드가 발송되었습니다. 프로모션 코드는 발급일로부터 24시간 동안 유효합니다.");}
				else if(resData == -1){alert("프로모션 코드 전송에 실패했습니다. 잠시 후에 다시 시도해주세요.");}
				else if(resData == 0){alert("이미 프로모션 코드를 발급 받았습니다.");}
			}		
		});	
		
 	}
}


</script>


 
<section class="single-product">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<ol class="breadcrumb">
					<li><a href="${contextPath}/index.jsp">Home</a></li>
					<li><a href="${contextPath}/shop-sidebar.jsp">Shop</a></li>
					<li class="active">Single Product</li>
				</ol>
			</div>
			
		</div>
	<!-- 카트 넣기 -->	
	<form action="#" method="post"  enctype="multipart/form-data">
	
	
		<div class="row mt-20">
			<div class="col-md-5">
				<div class="single-product-slider">
					<div id='carousel-custom' class='carousel slide' data-ride='carousel'>
						<div class='carousel-outer'>
							<!-- me art lab slider -->
							<div class='carousel-inner '>
							
									
							
								<div class='item active'>							
									<img src='${contextPath}/images/shop/products/${sBean.pdImg_Main}' alt='' data-zoom-image="images/shop/single-products/product-1.jpg"/>
								
								<c:if test="${sBean.sale eq 'y'}"><span class="bage">Sale</span></c:if>
								
								</div>
								<div class='item'>
									<img src='${contextPath}/images/shop/products/${sBean.pdImg_Sub}' alt='' data-zoom-image="images/shop/single-products/product-2.jpg" />
									<c:if test="${sBean.sale eq 'y'}"><span class="bage">Sale</span></c:if>
								</div>
								
								<div class='item'>
									<img src='${contextPath}/images/shop/products/${sBean.pdImg_Main}' alt='' data-zoom-image="images/shop/single-products/product-3.jpg" />
									<c:if test="${sBean.sale eq 'y'}"><span class="bage">Sale</span></c:if>
								</div>
								<div class='item'>
									<img src='${contextPath}/images/shop/products/${sBean.pdImg_Sub}' alt='' data-zoom-image="images/shop/single-products/product-4.jpg" />
									<c:if test="${sBean.sale eq 'y'}"><span class="bage">Sale</span></c:if>
								</div>
								<div class='item'>
									<img src='${contextPath}/images/shop/products/${sBean.pdImg_Main}' alt='' data-zoom-image="images/shop/single-products/product-5.jpg" />
									<c:if test="${sBean.sale eq 'y'}"><span class="bage">Sale</span></c:if>
								</div>
								<div class='item'>
									<img src='${contextPath}/images/shop/products/${sBean.pdImg_Sub}' alt='' data-zoom-image="images/shop/single-products/product-6.jpg" />
									<c:if test="${sBean.sale eq 'y'}"><span class="bage">Sale</span></c:if>
								</div>
								
							</div>
							
							<!-- sag sol -->
							<a class='left carousel-control' href='#carousel-custom' data-slide='prev'>
								<i class="tf-ion-ios-arrow-left"></i>
							</a>
							<a class='right carousel-control' href='#carousel-custom' data-slide='next'>
								<i class="tf-ion-ios-arrow-right"></i>
							</a>
						</div>
						
						<!-- thumb -->
						<ol class='carousel-indicators mCustomScrollbar meartlab'>
							<li data-target='#carousel-custom' data-slide-to='0' class='active'>
								<img src='${contextPath}/images/shop/products/${sBean.pdImg_Main}' alt='' name="img"/>
							</li>
							<li data-target='#carousel-custom' data-slide-to='1'>
								<img src='${contextPath}/images/shop/products/${sBean.pdImg_Sub}' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='2'>
								<img src='${contextPath}/images/shop/products/${sBean.pdImg_Main}' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='3'>
								<img src='${contextPath}/images/shop/products/${sBean.pdImg_Sub}' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='4'>
								<img src='${contextPath}/images/shop/products/${sBean.pdImg_Main}' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='5'>
								<img src='${contextPath}/images/shop/products/${sBean.pdImg_Sub}' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='6'>
								<img src='${contextPath}/images/shop/single-products/product-7.jpg' alt='' />
							</li>
						</ol>
					</div>
				</div>
			</div>
			<div class="col-md-7">
				<div class="single-product-details">
				
					<h2 >${sBean.pdName}</h2>
					
					
					<c:choose>
						<c:when test="${sBean.sale eq 'n'}"><p class="product-price">$ ${sBean.pdPrice}</p></c:when>
						
						<c:otherwise>
							<p class="product-price" >
								<i style="text-decoration:line-through;">$ ${sBean.pdPrice}</i>
								<i style="color: red;">&nbsp;→&nbsp;<b>$ ${final_price}</b>(${sBean.sale_Val}%) </i>  								 
							</p>
						</c:otherwise>			
					</c:choose>
					
					<div class="product-size">
						<span>Color:</span>
						<select class="form-control" name="color" onchange="selectColor()">
							<option>Black</option>
							<option>White</option>
							
						</select>
					</div>
					<div class="product-size">
						<span>Size:</span>
						Free Size 
					</div>
					<div class="product-quantity">
						<span>Quantity:</span>
						<div class="product-quantity-slider">
							<input id="product-quantity" type="text" value="1" name="product-quantity">
						</div>
					</div>
					<div class="product-category">
						<span>Categories:</span>
						<ul>
							<c:if test = "${fn:contains(sBean.pdCategory, 'clothes')}"><li><a href="${contextPath}/product-single.jsp" onclick="return false;">Clothes</a></li></c:if>
							<c:if test = "${fn:contains(sBean.pdCategory, 'top')}"><li><a href="${contextPath}/product-single.jsp" onclick="return false;">Top</a></li></c:if>
							<c:if test = "${fn:contains(sBean.pdCategory, 'bottom')}"><li><a href="${contextPath}/product-single.jsp" onclick="return false;">Bottom</a></li></c:if>
							<c:if test = "${fn:contains(sBean.pdCategory, 'dress')}"><li><a href="${contextPath}/product-single.jsp" onclick="return false;">Dress</a></li></c:if>
							<c:if test = "${fn:contains(sBean.pdCategory, 'accessory')}"><li><a href="${contextPath}/product-single.jsp" onclick="return false;">Accessory</a></li></c:if>
							<c:if test = "${fn:contains(sBean.pdCategory, 'muffler')}"><li><a href="${contextPath}/product-single.jsp" onclick="return false;">Muffler</a></li></c:if>
						</ul>
					</div>
					
					
					<div class="product-category">
						<span>Coupon:</span>
						<a style="cursor:pointer;" id="down" class="btn btn-small btn-solid-border" onclick="return email();">Download</a>
						<a hidden id="Email">${email}</a>
						<a hidden id="Name">${name}</a>
					</div>
				
					<input type="hidden" name="name" value="${name}">
					<input type="hidden" name="email" value="${email}">
					<input type="hidden" name="pdNum" value="${sBean.pdNum}">
					<input type="hidden" name="pdName" value="${sBean.pdName}">
					<input type="hidden" name="pdPrice" value="${sBean.pdPrice}">
				
					<input type="button" class="btn btn-main mt-20" id="" value="Add To Cart"  onclick="sendCart()">
				</div>
			</div>
		</div>
	</form>		
	<!-- 카트에 넣기 끝 -->	
		
		
		<div class="row">
			<div class="col-xs-12">
				<div class="tabCommon mt-20">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#details" aria-expanded="true">Details</a></li>
						<li class=""><a data-toggle="tab" href="#reviews" onclick="showReview();" aria-expanded="false">Reviews (<span id="totReviews">${totReviews}</span>)</a></li>
					</ul>
					<div class="tab-content patternbg">
						<div id="details" class="tab-pane fade active in">
							<h4>Product Description</h4>
							
							<p>${sBean.pdInfo}
							
							<!-- <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut per spici</p> -->
							
						</div>
						<div id="reviews" class="tab-pane fade">
							<div class="post-comments">
						    	<ul class="media-list comments-list m-bot-50 clearlist" id="commen_item">
								    
								   <!-- 리뷰 달리는 곳 -->
								   
								</ul>
							
					
						
						<!-- next, prev버튼 -->	
						<div class="col-md-6" id="paging">
							<ol class="product-pagination text-right">
								<li><a href="javascript:void(0);" onclick="prev();" id="prev"><i class="tf-ion-ios-arrow-left"></i> Preview </a></li>
								<li><a href="javascript:void(0);" onclick="next();" id="next"> Next <i class="tf-ion-ios-arrow-right"></i></a></li>
							</ol>
						</div>
						<!-- next, prev버튼 -->	
						
							<div class="widget product-category" id="leaveReview">
				<!-- 리뷰 남기기 -->	
					<!-- <div class="panel-group commonAccordion" id="accordion" role="tablist" aria-multiselectable="true">
					  	<div class="panel panel-default">-->
						    <div class="panel-heading" role="tab" id="headingOne"> 
						      	<h4 class="panel-title">
						        	<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
						          	Leave Review
						        	</a>
						      	</h4>
						     </div>
					   <!-- <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
							<div class="panel-body"> -->
								<ul>
									
									<textarea  style="resize: none; white-space:pre-wrap;" id="review_input" name="review_input"></textarea>
									<li><a href="#!" onclick="submit();">Submit</a></li>
								</ul>	
								
				<!-- 리뷰 남기기 끝 -->					
								
							</div>
					    </div>
					  </div>
					</div>	
				</div>		
							
							
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="products related-products section">
	<div class="container">
		<div class="row">
			<div class="title text-center">
				<h2>Related Products</h2>
			</div>
		</div>
		<div class="row">
		
		<c:choose>
		
			<c:when test="${!empty relatedList}">
			  <c:forEach var="relList" items="${relatedList}">
				<div class="col-md-3">
					<div class="product-item">
						<div class="product-thumb">
							<c:if test="${relList.sale eq 'y'}"><span class="bage">Sale</span></c:if>
							<img class="img-responsive" src="${contextPath}/images/shop/products/${relList.pdImg_Main}" alt="product-img" />
							
						</div>
						<div class="product-content">
							<h4><a href="${contextPath}/single/viewSingle.do?pdNum=${relList.pdNum}">${relList.pdName}</a></h4>
							
							<fmt:parseNumber value="${relList.pdPrice*(100-sale_val)/100}" var="final_price" integerOnly="true"/>
						
						
						<c:choose>
							<c:when test="${relList.sale eq 'n'}"><p class="product-price">$ ${relList.pdPrice}</p></c:when>
							
							<c:otherwise>
								<p class="product-price" >
									<i style="text-decoration:line-through;">$ ${relList.pdPrice}</i>
									<i style="color: red;">&nbsp;→&nbsp;<b>$ ${final_price}</b>(${relList.sale_Val}%) </i>  								 
								</p>
							</c:otherwise>			
						</c:choose>
	
						</div>
					</div>
				</div>
			
			  </c:forEach>
			</c:when>
		</c:choose>
			
		</div>
		
	</div>
</section>



<!-- Modal -->
<div class="modal product-modal fade" id="product-modal">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<i class="tf-ion-close"></i>
	</button>
  	<div class="modal-dialog " role="document">
    	<div class="modal-content">
	      	<div class="modal-body">
	        	<div class="row">
	        		<div class="col-md-8">
	        			<div class="modal-image">
		        			<img class="img-responsive" src="${contextPath}/images/shop/products/modal-product.jpg" />
	        			</div>
	        		</div>
	        		<div class="col-md-3">
	        			<div class="product-short-details">
	        				<h2 class="product-title">GM Pendant, Basalt Grey</h2>
	        				<p class="product-price">$200</p>
	        				<p class="product-short-description">
	        					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rem iusto nihil cum. Illo laborum numquam rem aut officia dicta cumque.
	        				</p>
	        				<a href="#!" class="btn btn-main">Add To Cart</a>
	        				<a href="#!" class="btn btn-transparent">View Product Details</a>
	        			</div>
	        		</div>
	        	</div>
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