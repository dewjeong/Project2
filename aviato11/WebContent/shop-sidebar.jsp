

<%@page import="shopPage.ProductsVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- jstl 라이브러리 사용을 위한 선언 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<c:set var="Path" value="${pageContext.request.contextPath}"/>  
 
<!DOCTYPE html>
<jsp:include page="/inc/top.jsp"></jsp:include>

<style>

#product-quantity{ width: 195px; height: 34px;}

</style>

<script type="text/javascript">

/***** 카트페이지로 값 넘기기 ******/
//function sendCart() {
	
//	var c = selectColor();
//	var q = selectQty();
//	var pNum = $('#pNum').val();
//	var pName = $('#pName').val();
//	var pImg = $('#pImg').val();
//	var cPrice = $('#cPrice').val();
//	var fPrice = document.getElementById('fPrice').value;
	
	
	
//// 	if(c=='Color' || q =='0'){
//// 		alert("상품 옵션을 선택해주세요");
//// 		return false;
//// 	}else{
		
//		location.href = "${Path}/shop/Cart.do?pNum="+pNum+"&pName="+pName"&cPrice="+cPrice
//			 		  +"&fPrice="+fPrice+"&pImg="+pImg+"&pdqty="+q+"&pdColor="+c;
//	//}
//}

/***** sendCart()메소드로 보낼 컬러 선택한 값 ******/
function selectColor() {

	var color = $('select[name=color]').val();
	alert(color);
	return color;
} 

/****** sendCart()메소드로 보낼 수량 선택한 값 *******/
function selectQty() {
	var pdqty =   $('input[name=product-quantity]').val();
	alert(pdqty);
	return pdqty;
}

/***대분류 온체인지***/
function OptionChange() {
	var option = $('select[name=optionList]').val();
	
 	//alert("value = " + option);
    
	location.href = "${Path}/shop/SelectCategory.do?option="+option;
}

/***카테고리부분 온클릭***/
function CateChange(id) {
	
	var cate = id;
	
	//alert(cate);
    
	location.href = "${Path}/shop/SelectCategory.do?cate=" + cate;
}

/***검색부분 온클릭***/
function SearchChange() {

	var search = $('#search').val();
	
	//alert(search);
	
	location.href = "${Path}/shop/SelectCategory.do?search=" + search;
} 

/**** 좋아요 *****/
function heartAlert(pdnum) {


    var pdNum =pdnum;
    
      $.ajax({
    	  
    	    url: "http://localhost:8081/aviato/shop/Heart.do?pdNum="+pdnum,
			type: "post",
			dataType: "text",
			success: function(data) {
			  	
				if(true){
						
					var a = "#updateHeart"+pdNum;
					
					$(a).text(data);
				
				}
						
			}
		
	});//ajax

}//heartAlert() 메소드 끝


 
</script>


<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Shop</h1>
					<ol class="breadcrumb">
						<li><a href="${Path}/index.jsp">Home</a></li>
						<li class="active">shop</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="products section">
	<div class="container">
		<div class="row">
			<div class="col-md-3">
		

				<!-- 대분류 -->		
				<div class="widget">
					<h4 class="widget-title">WOMEN</h4>
					<form method="post" id="optionForm" action="#" 
							onchange="OptionChange()" name="optionfrm" >
                        <select class="form-control" name="optionList" id="optionList" >
                        	<option value="all" <c:if test='${option eq "all"}'> selected </c:if> >ALL</option>
                            <option value="best" <c:if test='${option eq "best"}'> selected </c:if> >BEST</option>
                            <option value="y" <c:if test='${option eq "y"}'> selected </c:if> >SALE</option>     
                   
                        </select>
                    </form>
	            </div>				

				<!--  카테고리부분 -->	  
				<div class="widget product-category">
					<h4 class="widget-title">CATEGORIES</h4>
					<div class="panel-group commonAccordion" id="accordion" role="tablist" aria-multiselectable="true">
					  	
					  
					  	<div class="panel panel-default">
						    <div class="panel-heading" role="tab" id="headingOne">
						      	<h4 class="panel-title">
						        	<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
						          	CLOTHES
						        	</a>
						      	</h4>
						    </div>
					    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
							<div class="panel-body">
								<ul>
									<li><a id="top" onclick="CateChange(this.id)" href="#">Top</a></li>
									<li><a id="bottom" onclick="CateChange(this.id)" href="#">Bottom</a></li>
									<li><a id="dress" onclick="CateChange(this.id)" href="#">Dress</a></li>
								</ul>
							</div>
					    </div>
					  </div>
					
					  <div class="panel panel-default">
					    <div class="panel-heading" role="tab" id="headingTwo">
					      <h4 class="panel-title">
					        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					         	ACCESSORIES
					        </a>
					      </h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					    	<div class="panel-body">
					     		<ul>
									<li><a id="muffler" onclick="CateChange(this.id)" href="#">muffler</a></li>
									<li><a id="sunglasses" onclick="CateChange(this.id)" href="#">sunglasses</a></li>
								</ul>
					    	</div>
					    </div>
					  </div>
					 

					</div>
				</div>



                                    		
				<!-- 검색부분 -->
			
					<div class="widget">
						<form action="#" method="get">
						<h4 class="widget-title">Search</h4>
						<input type="search" id="search" class="form-control" placeholder="search..." name="search" style=" white-space : nowrap;">
						<br>
	   					<button type="submit" onclick="SearchChange()" style="display: none;"><i  class="tf-ion-ios-search-strong"></i></button>
	   				   </form>
		            </div>
			

			</div>
		
			<div class="col-md-9">
				<div class="row">







		
<c:choose>



	<c:when test="${!empty cateList}">
		<c:forEach var="cList" items="${cateList}" varStatus="i">
			<div class="col-md-4">
				<div class="product-item">
					<div class="product-thumb">
			       <c:if test="${cList.sale eq 'y' }">
						<span class="bage">Sale</span> 
				   </c:if>
						<img class="img-responsive" src="${Path}/images/shop/products/${cList.pdImg_Main}" alt="" />
						<div class="preview-meta">
						<ul>
						 <li>
							<span  data-toggle="modal" data-target="#product-modal${i.count}">
								<i class="tf-ion-ios-search-strong"></i>
							</span>
						 </li>						
						</ul>						
						</div>
						
					</div>

					<div class="product-content">
						<h4><a href="${Path}/single/viewSingle.do?pdNum=${cList.pdNum}">${cList.pdName}</a></h4>
						<c:if test="${cList.sale eq 'n'}">
						<p class="price"> $${cList.pdPrice}</p>
						</c:if>
								
						<c:set value="${cList.pdPrice}" var="price"/>
						<c:set value="${cList.sale_Val}" var="sale_val"/>
						<fmt:parseNumber value="${price*(100-sale_val)/100}" var="final_price" integerOnly="true"/>	
	
						<c:if test="${cList.sale eq 'y'}">
						<p class="price"><span style="text-decoration:line-through;">$${cList.pdPrice}</span>
						    &nbsp;
							<i style="color: red;">${cList.sale_Val}% →&nbsp;</i>  
							<b style="color: red;">$${final_price}</b> 
						</p>
						</c:if>					
					</div>
						
					<div class="product-content">
						<a id="heart" href="#!" onclick="heartAlert(${cList.pdNum})"><i class="tf-ion-ios-heart"></i></a> 
						<i id='updateHeart${cList.pdNum}'>${cList.heartCnt}</i>
						&nbsp;&nbsp; 
						<input type="hidden" id="pdnum" value="${cList.pdNum}">
						<input type="hidden" id="pdname" value="${cList.pdName}">
						<input type="hidden" id="cartprice" value="${cList.pdPrice}">
						<input type="hidden" id="pdimg" value="${cList.pdImg_Main}">
						<a id="cart${cList.pdNum}"
						href="${Path}/shop/Cart.do?pNum=${cList.pdNum}&pName=${cList.pdName}&cPrice=${cList.pdPrice}&fPrice=${final_price}&pImg=${cList.pdImg_Main}&pdqty=1&pdColor=White">
						<i class="tf-ion-android-cart"></i>
						</a>
					</div>

				</div>
			</div>
		
		
	<div class="modal product-modal fade" id="product-modal${i.count}">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<i class="tf-ion-close"></i>
			</button>
		  	<div class="modal-dialog " role="document">
		    	<div class="modal-content">
			      	<div class="modal-body">
			        	<div class="row">
			        		<div class="col-md-8 col-sm-6 col-xs-12">
			        			<div class="modal-image">
				        			<img class="img-responsive" src="${Path}/images/shop/products/${cList.pdImg_Main}" alt="product-img" />
			        			</div>
			        		</div>
			        		<div class="col-md-4 col-sm-6 col-xs-12">
			        			<div class="product-short-details">
			        				<h2 class="product-title">${cList.pdName}</h2>
							        	
							        	<c:choose>
								        	 <c:when test="${cList.sale eq 'y'}">
								        	    <p class="product-price"><span style="text-decoration:line-through;">$${cList.pdPrice}</span>
											    &nbsp;<br>
												<i style="color: red;">${cList.sale_Val}% →&nbsp;</i>  
												<b style="color: red;">$${final_price}</b> </p>
								        	 </c:when>
								        	<c:otherwise>
								        		<p class="product-price">$ ${cList.pdPrice}</p>
								        	</c:otherwise>
							        	</c:choose>
									<p class="product-short-description">
			        					${cList.pdInfo}
			        				</p>
			        	 
			        	 <br><br><br>
			        	 
			        	 
			        	 <div class="product-color">
		                  <span>Color:</span>
		                  <select class="form-control" name="color" onchange="selectColor()">
		                   <option>Color</option>
		                     <option>Black</option>
		                     <option>White</option>
		                  </select>
		               </div>
   					 <br>
		               <div class="product-quantity">
		                  <span>Quantity:</span>
		                  <div class="product-quantity-slider">
		                     <input onchange="selectQty()" id="product-quantity" type="text" value="0" name="product-quantity">
		                  </div>
		               </div>
             		
	             	  <div align="center">
	       				<a 
	       				href="${Path}/shop/Cart.do?pNum=${cList.pdNum}&pName=${cList.pdName}&cPrice=${cList.pdPrice}&fPrice=${final_price}&pImg=${cList.pdImg_Main}&pdqty=1&pdColor=White" 
	       				class="btn btn-main">Add To Cart</a>
	       				
	       			
	       				<a href="${Path}/single/viewSingle.do?pdNum=${cList.pdNum}" class="btn btn-transparent">View Product Details</a>
	       			  </div> 		        		
					
			        			</div>
			        		</div>
			        	</div>
			        </div>
		    	</div>
		  	</div>
		</div>			
		
		
		
		
		</c:forEach>
	</c:when>



	
	<c:otherwise>
			<div>

				<br> <br> <br>
				<h2 class="widget-title" align="center">검색 결과가 없습니다.</h2>
				<br>
				<div align="center">
					<a href="${Path}/shop/SelectCategory.do?option=all" class="btn btn-main">GO BACK</a>
				</div>
				<br> <br> <br>


			</div>
	</c:otherwise>	
	
</c:choose>	
		
			
			
		
		

				</div>				
			</div>
		
		</div>
	</div>
</section>




<jsp:include page="/inc/bottom.jsp"></jsp:include>

    <!-- 
    Essential Scripts
    =====================================-->
    
    <!-- Main jQuery -->
    <script src="${Path}/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="${Path}/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap Touchpin -->
    <script src="${Path}/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
    <!-- Instagram Feed Js -->
    <script src="${Path}/plugins/instafeed/instafeed.min.js"></script>
    <!-- Video Lightbox Plugin -->
    <script src="${Path}/plugins/ekko-lightbox/dist/ekko-lightbox.min.js"></script>
    <!-- Count Down Js -->
    <script src="${Path}/plugins/syo-timer/build/jquery.syotimer.min.js"></script>

    <!-- slick Carousel -->
    <script src="${Path}/plugins/slick/slick.min.js"></script>
    <script src="${Path}/plugins/slick/slick-animation.min.js"></script>

    <!-- Google Mapl -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
    <script type="text/javascript" src="${Path}/plugins/google-map/gmap.js"></script>

    <!-- Main Js File -->
    <script src="${Path}/js/script.js"></script>
   
   <script type="text/javascript">


 /************************************************************** 다시하자 ************************************/

// $("#heart").click(function(){
 
//             // json 형식으로 데이터 set
//             var params = {
//                       name      : $("#name").val()
//                     , sex       : $("#sex").val()
//                     , age       : $("#age").val()
//                     , tellPh    : $("#tellPh").val()
//             }
                
//             // ajax 통신
//             $.ajax({
//                 type : "POST",            // HTTP method type(GET, POST) 형식이다.
//                 url : "/test/ajax",      // 컨트롤러에서 대기중인 URL 주소이다.
//                 data : params,            // Json 형식의 데이터이다.
//                 success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
//                     // 응답코드 > 0000
//                     alert(res.code);
//                 },
//                 error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
//                     alert("통신 실패.")
//                 }
//             });
//         });
 
 
 

</script> 


  </body>
  </html>
