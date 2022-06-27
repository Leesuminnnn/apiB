<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE> 마이 페이지 </TITLE>
	<link type="text/css" rel="stylesheet" href="../board2/boardcss.css">
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
	border-bottom: 1px solid #aaaaaa;
	height: 50px;
	vertical-align: middle;
	}
	.user{
	margin-right: 10px;
	text-align: right;
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
		}else if(fm.memberPhone.value ==""){
			alert("연락처를 입력하세요")
			fm.memberPhone.focus();
			return;
		}else if(fm.memberAddr.value ==""){		//지역을 선택하지 않으면
			alert("지역을 선택해주세요")				
			fm.memberAddr.focus();
			return;			
		}
		
		
		
		
		alert("전송합니다.");
		가상경로 사용
		fm.action = "${pageContext.request.contextPath}/member/memberJoinAction.do2";
		fm.method = "post";
		fm.submit();
		
		return;	
	}
	//돌아가기를 누르면
	
	function fg(){
		var fm = document.frm;
		
		alert("메인화면으로 돌아갑니다.");
		fm.action = "${pageContext.request.contextPath}/board2/index2.do2";
		fm.method = "post";
		fm.submit();
		
		return;
	}
	
	</script>
	</HEAD>

	<BODY>
	<!-- 공통nav -->
	<jsp:include page="../link.jsp"/>
	<!-- 공통nav끝 -->
		<h1>마이페이지</h1>
		<br>
		
		<div class="tab">	
			<ul class="tabnav">
				<li><a href="${pageContext.request.contextPath}/member2/memberMyPageModify.do2?midx=${midx}">회원정보수정</a></li>
				<li><a href="${pageContext.request.contextPath}/board2/MyEstm.do2?midx=${midx}">내가작성한견적</a></li>
			</ul>
		</div>
		<form name="frm">
		<input type="hidden" name="midx" value="${mv.midx }">
			<table style="text-align:left; width:400px; height:300px">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId" size="25" placeholder="아이디를 입력해주세요"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPwd" size="25" placeholder="비밀번호를 입력해주세요"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="memberName" size="25" placeholder="이름을 입력해주세요"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="memberEmail" size="25" placeholder="이메일을 입력해주세요"></td>
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
						<input type="text" name="memberPhone" size="25" maxlength="13" placeholder="010-0000-0000">
					</td>
				</tr>
														
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="button" class="btn" value="수정하기" onclick="check();">
						<input type="button" class="btn" value="회원탈퇴">				
						<input type="button" class="btn" value="돌아가기" onclick="fg();">
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
