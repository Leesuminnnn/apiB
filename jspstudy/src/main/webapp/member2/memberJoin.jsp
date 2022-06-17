<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="text/css" rel="stylesheet" href="../board2/boardcss.css">
	<TITLE> 회원가입 페이지 </TITLE>
	<style>
	
	table{
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;		
	vertical-align: middle; /*글자 중앙정렬*/	
	}
	
	tr{
	border-bottom: 1px solid #aaaaaa;
	height: 60px;
	vertical-align: middle;
	}
	
	tr:last-child{
	border-bottom:none;
	}
	input[type=text], input[type=email], input[type=password], select{
	width: 200px;
	height: 35px;
	}
	select{
	width:100px;
	}
	input[type=reset]{
	padding: 5px;
	cursor: pointer;
	border-radius: 10px;
	border: 1px solid #bdbdbd;
	background: #fafafa;
	font-size: 12px;
}
	font{
		font-size:10px;
		
	}
	
	</style>
	<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
	// 자바스크립트 유효성 검사
//	alert("테스트입니다.")
	/* 
	var fm = document.frm;
	
	if (fm.memberId.value==""){
		alert("아이디를 입력하세요.");
		fm.memberId.focus();
		return;
	}else if(fm.memberPwd.value==""){
		alert("비밀번호를 입력하세요.")
		fm.memberPwd.focus();
		return;
	}else if(fm.memberPwd2.value==""){
		alert("비밀번호 확인을 입력하세요.")
		fm.memberPwd2.focus();
		return;
	}else if(fm.memberPwd.value !==fm.memberPwd2.value){
		alert("비밀번호가 일치하지 않습니다.")
		fm.memberPwd2.value = "";
		fm.memberPwd2.focus();
		return;
	}else if(fm.memberName.value ==""){
		alert("이름을 입력하세요")
		fm.memberName.focus();
		return;
	}else if(fm.memberEmail.value ==""){
		alert("이메일을 입력하세요")
		fm.memberEmail.focus();
		return;
	}else if(fm.memberAddr.value ==""){		//지역을 선택하지 않으면
		alert("지역을 선택해주세요")				
		fm.memberAddr.focus();
		return;			
	}else if(fm.memberPhone.value ==""){
		alert("연락처를 입력하세요")
		fm.memberPhone.focus();
		return;
	} 
	*/
	
	$(function check(){

		//===============
		// ajax를 이용한 아이디 중복체크와 정규식
		$('#idCheck').on('focusout' , function(){
		var memberId = $(this).val();
		var regId = /^[a-z]+[a-z0-9]{4,19}$/g;
		if(memberId == ""){
			$('#checkId').html('아이디를 입력해주세요');
			$('#checkId').attr('color','red');
		}else if(!regId.test($(this).val())){
			$('#checkId').html('아이디는 영문, 숫자만 가능하며 5-19자리만 가능합니다');
			$('#checkId').attr('color','red');
			$('#checkId').focus();
		}else if(!regId.test(this)){
			$.ajax({
				url : "<%=request.getContextPath()%>/member2/checkId.do2",
				type : 'POST',
				data : { "memberId": memberId },
				async : false,
				success : function(idCheck){
					if(idCheck == 1){
						$('#checkId').html('중복된 아이디입니다.');
						$('#checkId').attr("color","red");
						$('#idCheck').focus();
					}else{
						$('#checkId').html('사용할 수 있는 아이디입니다.');
						$('#checkId').attr("color","green");
					}
				},
				error : function(){
					alert("서버요청실패")
				}
			});
		};
	});
	
		$('#pwd').on('focusout' , function(){
   			
	 		  var memberPwd = $(this).val();
	    	  var regPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
	 		  if(memberPwd == "") {
				   $('#checkPwd').html('비밀번호를 입력해주세요.');
				   $('#checkPwd').attr('color','red');
	 		  }else if(regPwd.test($(this).val())){
				   $('#checkPwd').html('');
	 		  }else{
	 			   $('#checkPwd').html('비밀번호는 최소 8자, 하나의 이상의 대소문자 및 하나의 숫자, 하나의 특수문자로 입력해주세요');
	 			   $('#checkPwd').attr('color','red');
	 			   $('#pwd').focus();
	 		  }
	    });
		$('#pwd2').on('focusout' , function(){
			 	 
	  		  var memberPwd2 = $(this).val();
	  		  
	  		  if(memberPwd2 == "") {
	 			   $('#checkPwd2').html('비밀번호 확인을 입력해주세요.');
	 			   $('#checkPwd2').attr('color','red');
	 			   
	  		  }else	if($('#pwd2').val() == ($('#pwd').val())){
	 	 			   $('#checkPwd2').html('비밀번호가 일치합니다.');
	 	 			   $('#checkPwd2').attr('color','green');
	  		       }else{
	 	  		       $('#checkPwd2').html("비밀번호가 일치하지 않습니다.");
	 	  		       $('#checkPwd2').attr('color','red');
	 	  		       $('#pwd2').focus();
	  	    }
	    });
		
		$('#name').on('focusout' , function(){
			
			
	 		  var memberName = $(this).val();
	    	  var regName = /^([가-힣]{2,})+$/
	    		  
	 		  if(memberName == "") {
				   $('#checkName').html('이름을 입력해주세요.');
				   $('#checkName').attr('color','red');
	 		  }else if(regName.test($(this).val())){
				   $('#checkName').html('');
	 		  }else{
	 			   $('#checkName').html('올바른 이름 형식이 아닙니다.');
	 			   $('#checkName').attr('color','red');
	 			   $('#name').focus();
	 			}
			});
		
		$('#email').on('focusout' , function(){
 			
	 		  var memberEmail = $(this).val();
	    	  var regPhone = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	    		  
	 		  if(memberEmail == "") {
				   $('#checkEmail').html('이메일을 입력해주세요');
				   $('#checkEmail').attr('color','red');
				   
	 		  }else if(regPhone.test($(this).val())){
				   $('#checkEmail').html('');
	 		  }else{
	 			   $('#checkEmail').html('올바른 이메일 형식이 아닙니다.');
	 			   $('#checkEmail').attr('color','red');
	 			   $('#email').focus();
	 		  }
 			});
		
		$('#addr').on('focusout' , function(){
		 			
			 		var memberAddr = $(this).val();
			    		  
			 		if(memberAddr == "") {
						   $('#checkAddr').html('지역을 선택해주세요');
						   $('#checkAddr').attr('color','red');
			 		}else{
							$('#checkAddr').html('');
			 		}
		 });
		
		
		$('#phone').on('focusout' , function(){
 			
	 		  var memberPhone = $(this).val();
	    	  var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	    		  
	 		  if(memberPhone == "") {
				   $('#checkPhone').html('휴대폰 번호를 입력해주세요');
				   $('#checkPhone').attr('color','red');
				   
	 		  }else if(regPhone.test($(this).val())){
				   $('#checkPhone').html('');
	 		  }else{
	 			   $('#checkPhone').html('올바른 휴대폰 번호 형식이 아닙니다.');
	 			   $('#checkPhone').attr('color','red');
	 			   $('#phone').focus();
	 		  }
  });
		
		// ajax를 이용한 유효성 검사
		$("#frm").on('submit' , function(){
			
			var memberId = $("#idCheck").val();
  			var memberPwd = $("#pwd").val();
  			var memberPwd2 = $("#pwd2").val();
  			var memberName = $("#name").val();
  			var memberEmail = $("#email").val();
  			var memberGender = $("#gender").val();
  			var memberAddr = $("#addr").val();
  			var memberPhone = $("#phone").val();
  			
  			if(memberId == ''){
  				alert("아이디를 입력해주세요");
  				$("#idCheck").focus();
  				return false;
  			}else if(memberPwd == ''){
  				alert("비밀번호를 입력해주세요");
  				$("#pwd").focus();
  				return false;
  			}else if(memberPwd2 == ''){
  				alert("비밀번호 확인을 입력해주세요");
  				$("#pwd2").focus();
  				return false;
  			}else if(memberName == ''){
  				alert("이름을 입력해주세요");
  				$("#name").focus();
  				return false;
  			}else if(memberEmail == ''){
  				alert("이메일을 입력해주세요");
  				$("#emaild").focus();
  				return false;
  			}else if(memberAddr == ''){
  				alert("지역을 선택해주세요");
  				$("#addr").focus();
  				return false;
  			}else if(memberPhone == ''){
  				alert("휴대폰 번호를 입력해주세요");
  				$("#phone").focus();
  				return false;
  			}
		});
		//다시작성을 누르면
		function rst(){						
			var fm = document.frm;
			if (confirm("다시 작성 하시겠습니까?") == true){    //확인

		    document.frm.submit();

			}else{   //취소
				
		    	return;		
			}
			fm.method = "post";
			fm.submit();
			return;	
		}
		//돌아가기를 누르면
		
		function fg(){
			var fm = document.frm;
			
			alert("메인화면으로 돌아갑니다.");
			fm.action = "<%=request.getContextPath()%>/board2/index.do2";
			fm.method = "post";
			fm.submit();
			
			return;
		}
		
		
		
	});	 
	
	
	
	
	
		
	</script>
	</HEAD>

	<BODY>

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
		<h1>회원가입</h1>
		<br>
		<form name="frm" id="frm" action="<%=request.getContextPath()%>/member2/memberJoinAction.do2" method="post">
		
			<table style="text-align:left; width:400px; height:300px">
				<tr>
					<td>아이디</td>
					<td style="width:300px;"><input type="text" name="memberId" id="idCheck" placeholder="아이디를 입력해주세요" value="">
					<br>
					<font id="checkId" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPwd" id="pwd"  placeholder="비밀번호를 입력해주세요" >
					<br>
					<font id="checkPwd" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>비밀번호확인</td>
					<td><input type="password" name="memberPwd2" id="pwd2" placeholder="비밀번호를 입력해주세요">
					<br>
					<font id="checkPwd2" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" id="name" name="memberName" placeholder="이름을 입력해주세요">
					<br>
					<font id="checkName" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" id="email" name="memberEmail" placeholder="이메일을 입력해주세요">
					<br>
					<font id="checkEmail" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<label><input type="radio" id="gender" name ="memberGender" value="M" checked>남자</label>
						<label><input type="radio" id="gender" name ="memberGender" value="F">여자</label>
						<font id="checkGender" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>지역</td>
					<td>
						<select name="memberAddr" id="addr">
							<option value="">지역선택</option>
							<option value="서울">서울</option>
							<option value="대전">대전</option>
							<option value="전주">전주</option>
						</select>
						<br>
						<font id="checkAddr" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
						<input type="text" id="phone" name="memberPhone" maxlength="13" placeholder="010-0000-0000">
						<br>
						<font id="checkPhone" size="2"></font>
					</td>
				</tr>
														
				<tr>
					<td colspan="2" style="text-align:center;">
					 <input type="submit" id="joinBtn" name="join_Btn" class="btn" value="가입하기"> 
	  					<!-- <input type="button" class="btn" value="확인" onclick="check();"> --> 
						<input type="reset" class="btn" value="다시작성" onclick="rst();"> 						
						<input type="button" class="btn" value="돌아가기" onclick="fg();">
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
