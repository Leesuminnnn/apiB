<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인페이지</title>
<style>
* {
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;
	box-sizing: border-box;
}

h1, .dv {
	text-align: center;
}

h1 {
	margin-top: 50px;
	margin-bottom: 50px;
}
.title div{
	display: inline-block;
	
}
.title{
	text-align: center;
	margin: 0 auto;
	margin-bottom: 20px;
}

.dv2 {
	margin-right: 10px;
	text-align: right;
}

.dv {
	margin-top: 20px;
}

.dv>div, .dv2>div {
	display: inline-block;
}

a {
	color: #000000;
}

a:hover {
	color: #a828a8;
}

table {
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;
	vertical-align: middle; /*글자 중앙정렬*/
}

tr {
	height: 50px;
	vertical-align: middle;
}

input, select {
	border-radius: 5px;
	border: 1px solid;
	height: 35px;
	outline-color: #787878;
}

input:focus, select:focus {
	outline-color: #646464;
}

label[for="ch"] {
	position: relative;
	top: -12px;
}

label[for="stmlg"] {
	position: relative;
	top: -12px;
}

label[for="gstlg"] {
	position: relative;
	top: -12px;
}

.btn {
	cursor: pointer;
	height: 35px;
	width: 206px;
}
</style>
<script>

	function check(){
//		alert("테스트");
		
		var fm = document.frm;
		
		if(fm.memberId.value == ""){
			alert("아이디를 입력해주세요!");
			fm.memberId.focus();
			return;
			
		}else if(fm.memberPwd.value == ""){
			alert("비밀번호를 입력해주세요!");
			fm.memberPwd.focus();
			return;
		}
		
//		alert("전송");
		fm.action = "<%=request.getContextPath()%>/member2/LoginAction.do2";
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
</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<!-- 탭메뉴 -->

	<h1>로그인 페이지</h1>
	<form name="frm">
		<table style="text-align: left; width: 400px; height: 150px">
			<!-- <tr style="text-align: center;">
				<td style="width: 200px; padding-right: 50px;"><input
					type="radio" value="login" name="login" id="gstlg" checked><label
					for="gstlg">회원</label></td>
				<td style="width: 200px; padding-left: 50px;"><input
					type="radio" value="login" name="login" id="stmlg"><label
					for="stmlg">관리자</label></td>
			</tr> -->
			<tr style="text-align: center;">
				<td colspan="2"><input type="text" name="memberId" size="25"
					height="35" placeholder="아이디를 입력해주세요" onkeyup="enterkey();" ></td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="2">
				<input type="password" name="memberPwd" size="25" height="35"
					placeholder="비밀번호를 입력해주세요" onkeyup="enterkey();" ></td>
			</tr>
			<!-- 
			<tr>
				<td style="text-align: center;" colspan="2">
					<div>
						<input type="checkbox" id="checkbox">&nbsp;<label for="checkbox">아이디
							저장하기</label>
					</div>

				</td>
			</tr>
			 -->
			<tr>
				<td style="text-align: center;" colspan="2">
				<input type="button" class="btn" value="LOGIN" onclick="check();">
				</td>
			</tr>
		</table>
		<div class="dv">
			<div>
				<a href="<%=request.getContextPath()%>/member2/memberJoin.do2">회원가입</a>
			</div>
			ㅣ
			<div>
				<a href="javascript:alert('준비중입니다.');">ID/PW찾기</a>
			</div>
		</div>
	</form>
</body>
</html>