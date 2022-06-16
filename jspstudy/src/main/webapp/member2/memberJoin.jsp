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
	height: 50px;
	vertical-align: middle;
	}
	
	tr:last-child{
	border-bottom:none;
	}
	input[type=text], input[type=email], input[type=password]{
	width: 200px;
	height: 25px;
	}
	input[type=reset]{
	padding: 5px;
	cursor: pointer;
	border-radius: 10px;
	border: 1px solid #bdbdbd;
	background: #fafafa;
	font-size: 12px;
}
	
	
	</style>
	<script src="../resources/js/jquery-3.6.0.min.js"></script>
	<script>
	
	var IsDuplicated = false;
	
	function idck()
	{
		var id = $("#memberId").val();	
		
		$("#result_checkId").html("");
		if(id == "")
		{
			$("#result_checkId").html("아이디를 입력하세요.");
			return;
		}
		
		// 아이디 입력방식이 잘못 되었을 경우
		if(!IDValueCheck(id))
		{
			//alert("2");
			$("#result_checkId").html("영문자로 시작하고 영문자 또는 숫자 6~20자로 입력해 주세요 .");
			$("#result_checkId").css("color","red")
			return;
		}
		
		$.ajax({
			type : "get",
			url: "checkId.jsp?memberId=" + id,
			dataType: "html",
			success : function(data) 
			{
				data = data.trim();
				if(data == "ERROR")
				{
					$("#result_checkId").html("아이디 조회 오류입니다.");
				}
				if(data == "DUPLICATE")
				{
					$("#result_checkId").html("중복된 아아디입니다.");
					$("#result_checkId").css("color","red");
					
					IsDuplicated = true;
				}else
				{
					$("#result_checkId").html("사용 가능한 아이디입니다.");
					$("#result_checkId").css("color","black");
				}					
			}
		});	
		
	}
	
	
	
	
	
	/*
	//중복체크
	$(function(){
		
		$("#checkId").click(function(){
			alert("ㅇㅇㅇㅇ");
			let userid = $("#memberId").val();
			
			$.ajax({
				type: 'get',
				url: "checkId.jsp"
				data: {"userid":userid},
				success: function(data){
					
					let obj = JSON.parse(data);
					
					if(obj.flag == "N"){
						result = "사용 가능한 아이디입니다.";
						$("#result_checkId").html(result).css("color","green");
					}else{
						result = "이미 사용중인 아이디입니다.";
						$("#result_checkId").html(result).css("color","red");
						$("#memberId").val("").trigger("focus");
					}
				},
				error : function(error){
					alert(error);
				}
			});
		});
	});
	*/
	</script>
	<script>
	function check(){
//		alert("테스트입니다.")
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
		
		
		
		alert("전송합니다.");
		fm.action = "<%=request.getContextPath()%>/member2/memberJoinAction.do2";
		fm.method = "post";
		fm.submit();
		
		return;
		
	}
	 
	
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
	
	
	
		
	</script>
	</HEAD>

	<BODY>

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
		<h1>회원가입</h1>
		<br>
		<form name="frm">
			<input type="hidden" name="memberPw" value="">
			<table style="text-align:left; width:400px; height:300px">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId" id="memberId" placeholder="아이디를 입력해주세요" value="">
					<input type="button" id="checkId" value="중복체크" onclick="idck"><br>
					<label id="result_checkId"></label>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPwd" placeholder="비밀번호를 입력해주세요"></td>
				</tr>
				<tr>
					<td>비밀번호확인</td>
					<td><input type="password" name="memberPwd2" placeholder="비밀번호를 입력해주세요"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="memberName" placeholder="이름을 입력해주세요"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="memberEmail" placeholder="이메일을 입력해주세요"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<label><input type="radio" name ="memberGender" value="M" checked>남자</label>
						<label><input type="radio" name ="memberGender" value="F">여자</label>
					</td>
				</tr>
				<tr>
					<td>지역</td>
					<td>
						<select name="memberAddr" style="width:100px; height:25px">
							<option value="">지역선택</option>
							<option value="서울">서울</option>
							<option value="대전">대전</option>
							<option value="전주">전주</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
						<input type="text" name="memberPhone" maxlength="13" placeholder="010-0000-0000">
					</td>
				</tr>
														
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="button" class="btn" value="확인" onclick="check();"> 
						<input type="reset" class="btn" value="다시작성" onclick="rst();"> 						
						<input type="button" class="btn" value="돌아가기" onclick="fg();">
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
