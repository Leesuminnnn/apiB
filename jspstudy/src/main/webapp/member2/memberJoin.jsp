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
		//ajax를 이용하기
		
		
		// 자바스크립트 유효성 검사
//		alert("테스트입니다.")
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
		// ajax를 이용한 유효성 검사
		
		
		
		
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
					<td><input type="password" name="memberPwd" placeholder="비밀번호를 입력해주세요">
					<font id="checkPwd" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>비밀번호확인</td>
					<td><input type="password" name="memberPwd2" placeholder="비밀번호를 입력해주세요">
					<font id="checkPwd2" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="memberName" placeholder="이름을 입력해주세요">
					<font id="checkName" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="memberEmail" placeholder="이메일을 입력해주세요">
					<font id="checkEmail" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<label><input type="radio" name ="memberGender" value="M" checked>남자</label>
						<label><input type="radio" name ="memberGender" value="F">여자</label>
						<font id="checkGender" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>지역</td>
					<td>
						<select name="memberAddr">
							<option value="">지역선택</option>
							<option value="서울">서울</option>
							<option value="대전">대전</option>
							<option value="전주">전주</option>
						</select>
						<font id="checkAddr" size="2"></font>
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
						<input type="text" name="memberPhone" maxlength="13" placeholder="010-0000-0000">
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
