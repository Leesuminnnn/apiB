<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="text/css" rel="stylesheet" href="../board2/boardcss.css">
	<TITLE> 마이 페이지 </TITLE>
	<style>
	
	
	</style>
	<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
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
			<li><a href="${pageContext.request.contextPath}/member2/memberMyPageModify.do2?midx=${mv.midx}">회원정보수정</a></li>
			<li><a href="${pageContext.request.contextPath}/board2/MyEstm.do2?midx=${mv.midx}">내가작성한견적</a></li>
		</ul>
	</div>
	<form name="frm">
			<table class="content" border="1" 
			style="text-align:left; width:400px; height:300px;">
				<tr>
					<td>아이디</td>
					<td><input type="hidden" name="memberId" size="25">${mv.memberid }</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="hidden" name="memberName" size="25">${mv.membername}</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="hidden" name="memberEmail" size="25">${mv.memberemail }</td>
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="hidden" name ="memberGender">${mv.membergender}</td>
				</tr>
				<tr>
					<td>지역</td>
					<td><input type="hidden" name="memberAddr">${mv.memberaddr }</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="hidden" name="memberPhone" size="25">${mv.memberphone }</td>
				</tr>
														
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="button" class="btn" value="회원탈퇴">				
						<input type="button" class="btn" value="돌아가기" onclick="fg();">
					</td>
				</tr>
			</table>
		</form>
		
	</BODY>
</HTML>
