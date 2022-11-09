
//-----------------------------------------------------------회원가입 전체 공란 체크, 패스워드 불일치&패스워드 수 제한(4~10자)// ok
 	function validateForm() {
 		
		//필수란 하나라도 입력하지 않았다면
		if($("#Name").val() == ""||
			$("#sample2_postcode").val() == ""||
			$("#sample2_address").val() == ""||
			$("#sample2_detailAddress").val() == ""||
			$("#sample2_extraAddress").val() == ""||
			$("#Email").val() == ""||
			$("#pwd1").val() == ""||
			$("#pwd2").val() == "") {
				
			alert(" *필수정보를 입력해주세요!"); 
			return false;
		}
				
		else if( $("#pwd1").val() != $("#pwd2").val() ){
			alert("패스워드가 일치하지 않습니다!");
			return false;
		}
		
		else if( $("#pwd1").val().length < 4){
			alert("패스워드를 확인하세요!");
			return false;
		}
		
		else if( $("#pwd1").val().length > 10){
			alert("패스워드는 4~10글자로 입력해주세요!");
			return false;
		}		
		
	}
//--------------------------------------------------

	
//-----------------------------------------------name 공란체크 // ok
	$("#Name").blur(
		
		function() {
	
			var requestName = $("#Name").val();
	
					if (requestName=="") {
						
						$("#join_check1").text("*");
						
				
					}
				}
			
		)

//-----------------------------------------------address 공란체크

	// 우편번호
	$("#sample2_postcode").blur(
	
		function(){
		
			var add1 = $("#sample2_postcode").val();

				if(add1 == ""){
				
					$("#join_check2").text("*");
				
				}
		}
	)

	// 주소
	$("#sample2_address").blur(
	
		function(){
		
			var add2 = $("#sample2_address").val();

				if(add2 == ""){
				
					$("#join_check3").text("*");
				
				}
		}
	)


	// 상세주소
	$("#sample2_detailAddress").blur(
	
		function(){
		
			var add3 = $("#sample2_detailAddress").val();
		
				if(add3 == ""){
				
					$("#join_check4").text("*");
				
				}
		}
	)
	
	// 참고항목
	
		$("#sample2_extraAddress").blur(
	
		function(){
		
			var add4 = $("#sample2_extraAddress").val();
		
				if(add4 == ""){
				
					$("#join_check5").text("*");
				
				}
		}
	)
	
//----------------------------------------------- email중복체크 
	$("#Emails").click(function() {
			
			var requestEmail = $("#Email").val();
			//alert(requestEmail);
			
			$.ajax({
				// 비동기방식으로 요청을 보낼 서버페이지의 URL
				url: 'http://localhost:8081/aviato11/member/emailcheck.do?Email=' + requestEmail,
				
				// 전송방식을 get 또는 post로 지정
				type: 'post',
				
				// 서버페이지로 요청시 전송할 데이터를 지정
				data: {email:requestEmail},
				
				// 서버페이지로부터 응답받을 데이터의 타입을 지정
				dataType: "text",
				
				// 서버페이지에 비동기방식으로 요청에 성공했을 때, 서버페이지가 응답하는 응답데이터를 받을 콜백함수 function이
				// 자동으로 호출이되어 매개변수로 전달받아 처리하게 된다.
				success: function(respData) {
					
					if (requestEmail == "" || requestEmail == null) {
						$("#emailok").text("이메일을 입력하세요!");

					} else if (respData == 0 && $("#Email").val().includes(".com")) {
						$("#emailok").text("멋진 이메일이네요!");
						
					} else if(respData == 0 && !$("#Email").val().includes(".com") ){
						$("#emailok").text("올바른 이메일 형식을 입력해주세요!(.com)");
						
					} else if(respData == 1){
						$("#emailok").text("이미 사용중인 이메일이에요!");	
					}
				}
			});
		});
		
//-----------------------------------------------email 공란체크 // ok		
	$("#Email").blur(
		function() {

			var email = $("#Email").val();

					if (email == "") {
						
						$("#join_check6").text("*");
				
					}
				}	
		)

//-----------------------------------------------pwd1 공란체크 //ok
	$("#pwd1").blur(
	
		function() {

			var requestPwd1 = $("#pwd1").val();

					if (requestPwd1 == "") {
						
						$("#join_check7").text("*");
				
					}else if(requestPwd1.length < 4){
						
						$("#join_check7").text("4~10글자로 입력해주세요.");
					
					}
				}	
		)

//-----------------------------------------------pwd2 중복&공란체크 // ok
	$("#pwd2").blur(function() {
		
			var requestPwd1 = $("#pwd1").val();
			var requestPwd2 = $("#pwd2").val();
					
           		if(requestPwd2 == ""){
           			$("#join_check8").text("*");
           		}else if(requestPwd1 == requestPwd2){
           			$("#join_check8").text("패스워드 일치");
           			
           		}else if(requestPwd1 != requestPwd2){
					$("#join_check8").text("패스워드 불일치");

				}
					
						});
						
//------------------------------------------------- <form>태그의 submit금지

