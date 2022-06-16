<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE> 회원가입 페이지 </TITLE>
	<style>
	*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
	}
	
	table{
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;		
	vertical-align: middle; /*글자 중앙정렬*/	
	}
	
	tr{
	height: 50px;
	vertical-align: middle;
	}
	
	
	/* 마지막 tr에 border-bottom빼기
	
	tr:rast-child{
	border-bottom:none;
	}
	*/
		
	.btn{
	cursor: pointer;
	padding: 5px;
	}
	
	input, select{
	border-radius: 5px;
	border:1px solid;
	height: 30px;
	outline-color: #787878;
	}
	
	
	input:focus, select:focus{
	outline-color: #646464;
	}
	
	</style>
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
		}
		
		alert("전송합니다.");
		//가상경로 사용
		fm.action = "<%=request.getContextPath()%>/member/memberLoginAction.do";
		fm.method = "post";
		fm.submit();
		
		return;
		
	}
	//돌아가기를 누르면
	
	function fg(){
		var fm = document.frm;
		
		fm.action = "javascript:history.back();";
		fm.method = "post";
		fm.submit();
		
		return;
	}
	
	//엔터키로 로그인하기 구현완료
	function enterkey(){
		if(window.event.keyCode == 13){
			//엔터키가 눌렸을때 실행할 내용
			check();
		}
		
	}
	
	</script>
	</HEAD>

	<BODY>
		<center><h1>로그인페이지</h1></center>
		<br>
		<form name="frm">
			<table style="text-align:left; width:400px; height:150px">
				<!-- 엔터키로 로그인하기 : 
					 onkeyup을 버튼에 주는것이 아니고, 아이디와 비밀번호 인풋박스에 넣기-->
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId" size="35" height="35" placeholder="아이디를 입력해주세요" onkeyup="enterkey();"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPwd" size="35" height="35" placeholder="비밀번호를 입력해주세요" onkeyup="enterkey();"></td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="button" class="btn" value="확인" onclick="check();"> 						
						<input type="button" class="btn" value="돌아가기" onclick="fg();">
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
