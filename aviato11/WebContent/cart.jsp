<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%request.setCharacterEncoding("utf-8");%> 
	
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%-- JSTL라이브러리의 Formatting태그들을 사용하기 위해 taglib 지시자를 선언 --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<jsp:include page="./inc/top.jsp"></jsp:include>

<script>

/**** 수량이 0이면 체크아웃으로 못 넘어갓! ****/
function beforeCH() {
	
		var qty = $('#product-quantity').val();
	 				
		if(qty == '0'){
			alert("수량을 선택해 주세요.");
			return false;
		}		
}

</script>

<style>

	.input-group-btn:last-child>.btn, .input-group-btn:last-child>.btn-group {
		margin-left: -25px;
	}
	
	#product-quantity{ width: 55px; height: 34px;}

</style>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Cart</h1>
					<ol class="breadcrumb">
						<li><a href="${contextPath}/index.jsp">Home</a></li>
						<li class="active">cart</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>


<c:choose>

<c:when test="${!empty cList}">

	<div class="page-wrapper">
		<div class="cart shopping">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<div class="block">
							<div class="product-list">

								<form method="post" action="${contextPath}/checkout.jsp" onsubmit="return beforeCH()">
									<table class="table">
										<thead>
											<tr>
												<th class="" ></th>
												<th class="">Item Name</th>
												<th class="">Item Price</th>
												<th class="">Item Size</th>
												<th class="">Item Color</th>
												<th class="">Item Quantity</th>
												<th class="">Actions</th>
											</tr>
										</thead>
 
									<c:forEach var="cList" items="${cList}">
										<tbody>
											<tr class="">												
												
												<td class="" align="center" id="item-image">
												<img width="80"
													 src="${contextPath}/images/shop/products/${cList.pdImg_Main}"/>
												</td>
												
												<td class="" id="item-name">
													<div style="text-align: center;">
														<a href="${contextPath}/single/viewSingle.do?pdNum=${cList.pdNum}"><b>${cList.pdName}</b></a>
													</div>
												
												</td>
											
												
												
												<c:choose>
													<c:when test="${cList.cartPrice != cList.finalPrice }">
													<td class="" align="center" id="item-price"> 
														<span style="text-decoration: line-through;"> $${cList.cartPrice}</span>
														<b style="color: red";>$${cList.finalPrice}</b>
													</td>
													</c:when>
												    
												    <c:otherwise>
												   	 <td class="" align="center" id="item-price">$${cList.cartPrice}</td>
												    </c:otherwise>
												</c:choose>
												
										
												
												<td class="" align="center">Free</td>
												
												<td class="" align="center" id="item-color">${cList.pdColor}</td>
											
											<td class="" align="center" id="item-quantity">		
												<div class="product-quantity-slider">
												<input id="product-quantity" type="text" value="${cList.pdQty}" name="product-quantity">
												</div>	
											</td>

												<td class="">
												<a class="product-remove"
												   href="${contextPath}/shop/RemoveCart.do?pdName=${cList.pdName}&pdColor=${cList.pdColor}">Remove</a>
												</td>
											</tr>
										</tbody>
									</c:forEach>																		
								</table>
								<div align="right">
									<a href="${contextPath}/shop/SelectCategory.do?option=all"
								       class="btn btn-main ">MORE</a> &nbsp;
								    <a href="${contextPath}/shop/AllRemoveCart.do"
								       class="btn btn-main ">REMOVE ALL</a> &nbsp; 
								 	<input type="submit" value="CHECKOUT"
								       class="btn btn-main " >

								</div>  	
							</form>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:when>

<c:otherwise>
		
		<div>
			<br> <br> <br>
			<h2 class="widget-title" align="center">장바구니에 담은 상품이 없습니다.</h2>
			<br>
			<div align="center">
				<a href="${contextPath}/shop/SelectCategory.do?option=all" class="btn btn-main">CONTINUE SHOPPING</a>
			</div>
			<br> <br> <br>
		</div>
		
</c:otherwise>


</c:choose>




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
