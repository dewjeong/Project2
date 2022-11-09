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


<script>
	
	function getDiscount() {
		
		var tot = $('#subtotal').text();
		var finalprice = tot-30;
		
		var code = $("#code").val();
		var email = $("#email").val();
		
		$.ajax({
				url:'${contextPath}/single/getDiscount.do?code='+code+'&email='+email,
				type:'post',	
		      	dataType : 'text',		 		
				success:function(resData){
					
					if(resData == 1){
						alert("쿠폰번호가 확인되었습니다.");	
						
						var price = '<li><span>Discount:</span>'
									+'<span style="text-decoration:line-through; margin-left: 110px;">$'+tot+'</span>'
									+'<span style="color: red;">&nbsp;→&nbsp;<b>$'+finalprice+'</b></span><li>';
									
						$("#applyCoupon").html(price);
						
						$("#finalPrice").text('$'+finalprice);//수정 필요할 수도..?
						return false;		
								
					}else if(resData == -1){alert("유효하지 않은 쿠폰번호입니다.");}			
			}
		
	});
		
		return false;
	}


</script>




<jsp:include page="./inc/top.jsp"></jsp:include>


<section class="page-header">
	<div class="container">
		<div class="row">
			<div  class="col-md-12">
				<div class="content">
					<h1  class="page-name">Checkout</h1>
					<ol class="breadcrumb">
						<li><a href="index.jsp">Home</a></li>
						<li class="active">checkout</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="page-wrapper">
   <div class="checkout shopping">
      <div class="container">
         <div class="row">
            <div class="col-md-8">
               <div class="block billing-details">
                  <h4 class="widget-title">Billing Details</h4>
                  <form class="checkout-form">
                     <div class="form-group">
                        <label for="full_name">Full Name</label>
                        <input type="text" class="form-control" id="full_name" placeholder="" value="${mVO.name}">${mVO.name}
                     </div>
                     <div class="form-group">
                        <label for="user_address">Address</label>
                        <input type="text" class="form-control" id="user_address" placeholder="" value="${mVO.add2}">
                     </div>
                     <div class="checkout-country-code clearfix">
                        <div class="form-group">
                           <label for="user_post_code">Zip Code</label>
                           <input type="text" class="form-control" id="user_post_code" name="zipcode" value="${mVO.add1}">
                        </div>
                        <div class="form-group" >
                           <label for="user_city">City</label>
                           <input type="text" class="form-control" id="user_city" name="city" value="${mVO.add4}">
                        </div>
                     </div>
                     <div class="form-group">
                        <label for="user_country">Country</label>
                        <input type="text" class="form-control" id="user_country" placeholder="" value="${mVO.add3}">
                     </div>
                  </form>
               </div>
               <div class="block">
                  <h4 class="widget-title">Payment Method</h4>
                  <p>Credit Cart Details (Secure payment)</p>
                  <div class="checkout-product-details">
                     <div class="payment">
                        <div class="card-details">
                           <form  class="checkout-form">
                              <div class="form-group">
                                 <label for="card-number">Card Number <span class="required">*</span></label>
                                 <input  id="card-number" class="form-control"   type="tel" placeholder="•••• •••• •••• ••••">
                              </div>
                              <div class="form-group half-width padding-right">
                                 <label for="card-expiry">Expiry (MM/YY) <span class="required">*</span></label>
                                 <input id="card-expiry" class="form-control" type="tel" placeholder="MM / YY">
                              </div>
                              <div class="form-group half-width padding-left">
                                 <label for="card-cvc">Card Code <span class="required">*</span></label>
                                 <input id="card-cvc" class="form-control"  type="tel" maxlength="4" placeholder="CVC" >
                              </div>
                              <a href="${contextPath}/single/placeOrder.do?email=${email}" class="btn btn-main mt-20">Place Order</a >
                           </form>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-4">
               <div class="product-checkout-details">
                  <div class="block">
                     <h4 class="widget-title">Order Summary</h4>
                     
 <!-- 총합계를 구할 변수 --> <c:set var="total" value="0"/>
                     <c:forEach var="cList" items="${cList}">
                     	<c:set var="total" value="${total + cList.finalPrice*cList.pdQty}"/>
                     
	                     <div class="media product-card">
	                        <a class="pull-left" href="product-single.jsp">
	                           <img class="media-object" src="${contextPath}/images/shop/products/${cList.pdImg_Main}" alt="Image" />
	                        </a>
	                        <div class="media-body">
	                           <h4 class="media-heading"><a href="product-single.jsp">${cList.pdName}</h4>
	                           <p class="price">${cList.pdQty} x $ ${cList.finalPrice}</p>
	                           <span class="remove" >Remove</span><!-- 메소드 작성하기 -->
	                        </div>
	                     </div>
                     
                     
                     </c:forEach>
                     
                     
                     <div class="discount-code">
                        <p>Have a discount ? <a href="#!" data-toggle="modal" data-target="#coupon-modal" style="cursor: pointer;"><b>enter it here</b></a></p>
                     </div>
                     <ul class="summary-prices">
                        <li>
                           <span>Subtotal:</span>
                           <span class="price">$<span id="subtotal">${total}</span></span>
                        </li>
                        <li>
                           <span>Shipping:</span>
                           <span>Free</span>
                        </li>
                        
                     </ul>
                     
                     <ul id="applyCoupon">
                     	<!-- 쿠폰 적용 -->
                     </ul>
                     
                     
                     <div class="summary-total">
                        <span>Total</span>
                        <span id="finalPrice">$ ${total}</span>
                     </div>
                     <div class="verified-icon">
                        <img src="${contextPath}/images/shop/verified.png">
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
   <!-- Modal -->
   <div class="modal fade" id="coupon-modal" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-body">
               <form >
                  <div class="form-group">
                     <input name="code" id="code" class="form-control" type="text" placeholder="Enter Coupon Code"/>
                     <input name="email" id="email" type="hidden"  value="${email}"/>
                  </div>
                  <button onclick="return getDiscount();" class="btn btn-main">Apply Coupon</button>
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