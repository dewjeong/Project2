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

<script>
//------------------------------------------------- 회원탈퇴시 <a>태그로 email값 넘기기 //

function deletemem() {
    
    var requestE = $("#Email").val();

    	if(confirm("정말로 탈퇴하시겠습니까?") == true){
    		
    		location.href="${contextPath}/member/drop.do?Email="+requestE;
    		
    	}else{
    		return false;
    	}
    
}
//------------------------------------------------- 회원탈퇴시 <a>태그로 email값 넘기기 //
</script>

<body id="body">

<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <a class="logo" href="${contextPath}/index.jsp">
            <img src="${contextPath}/images/logo.png" alt="">
          </a>
          <h2 class="text-center">Create Your Account</h2>
          
          <form class="text-left clearfix"
           		action="${contextPath}/member/modmember.do" 
           		method="post"
           		onsubmit="return validateForm(this);">
           		
           	<p style="color:red"> ※ *는 필수항목입니다. </p>
           	
           	<div id="join_check1" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
              <input type="text" class="form-control"  placeholder="이름" name="Name" id="Name" value="${vo.name}">
            </div>

            <div id="join_check2" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
             	<input type="text" class="form-control" id="sample2_postcode" 
             			placeholder="우편번호" name="addr1" value="${vo.add1}">
             	<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"> 
          	</div>
          	
          	<div id="join_check3" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
  	        <div class="form-group">
              	<input type="text" class="form-control" id="sample2_address" 
              		   placeholder="주소" name="addr2" value="${vo.add2}">
            </div>
            
            <div id="join_check4" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
            	<input type="text"class="form-control" id="sample2_detailAddress" 
            			placeholder="상세주소" name="addr3" value="${vo.add3}">
            </div>
            
            <div id="join_check5" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
            	<input type="text" class="form-control" id="sample2_extraAddress"
            			placeholder="참고항목" name="addr4" value="${vo.add4}">
            </div>             
            
            <div id="join_check6" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
              <input type="email" class="form-control"  placeholder="이메일" name="Email" id="Email" value="${vo.email}" readonly>
            </div>
            
            <div id="join_check7" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
              <input type="password" class="form-control"  placeholder="패스워드" name="Password" id="pwd1">
            </div>
            
            <div id="join_check8" style="color: red; font-size:14px; height:5px; text-align:-webkit-left;"></div>
            <div class="form-group">
              <input type="password" class="form-control"  placeholder="패스워드 확인" name="PassCheck" id="pwd2">
            </div>
            
            
            <div class="text-center">
              <button type="submit" class="btn btn-main text-center">Modification</button>
              <input type="reset" class="btn btn-main text-center" value="RESET">
            </div>
          </form>
          <p class="mt-20"> 계정을 삭제하고 싶으신가요?
          	<a href="#" onclick="deletemem()">회원탈퇴하기</a>
          </p>
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
    
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-------------------------------------------------- 우편번호검색 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" 
		style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script>
    
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var addr = ''; 
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                  
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                  
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                   
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }

                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }


                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                document.getElementById("sample2_detailAddress").focus();

                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        element_layer.style.display = 'block';

        initLayerPosition();
    }


    function initLayerPosition(){
        var width = 300; 
        var height = 400; 
        var borderWidth = 5; 

        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
    
</script>
<!--------------------------------------------------------- 우편번호검색 -->



<%------------------------------------------------ js페이지 ---------------------%>
<script type="text/javascript" src="${contextPath}/js/modCheck.js"></script>
<%------------------------------------------------ js페이지 ---------------------%>


  </body>
  </html>