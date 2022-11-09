
//-----------------------------------------------------------회원가입 전체 공란 체크 // ok
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
		
	};
		
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
           			$("#join_check8").text("비밀번호 일치");
           			
           		}else if(requestPwd1 != requestPwd2){
					$("#join_check8").text("비밀번호 불일치");

				}
					
						});
						
						
