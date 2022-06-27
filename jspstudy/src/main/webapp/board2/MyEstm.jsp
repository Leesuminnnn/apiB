<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 작성한 견적 페이지</title>
<link type="text/css" rel="stylesheet" href="../board2/boardcss.css">
<style>

</style>
<script>
	function back(){
	var fm = document.frm;
		
		fm.action = "javascript:history.back();";
		fm.method = "post";
		fm.submit();
		
		return;
	}
</script>
</head>
<body>
	<!-- 공통nav -->
	<jsp:include page="../link.jsp"/>
	<!-- 공통nav끝 -->
	<h1>내가 작성한 견적페이지</h1>
	<br>
	<div class="tab">	
		<ul class="tabnav">
			<li><a href="${pageContext.request.contextPath}/member2/memberMyPageModify.do2?midx=${midx}">회원정보수정</a></li>
			<li><a href="${pageContext.request.contextPath}/board2/MyEstm.do2?midx=${midx}">내가작성한견적</a></li>
		</ul>
	</div>
	
	
	<form name="frm">
	<input type="hidden" name="midx" value="${mv.midx }">
		<table class="content" border=1>
			<tbody>
				<tr>
					<td style="width:50px;">지역</td>
					<td>희망공사일</td>
					<td>확인여부</td>
					<td>확인날짜</td>
				</tr>
			<c:forEach var="ev" items="${myalist}">
				<tr>
					<td>${ev.place}</td>
					<td>${ev.esdays}</td>
					<td>${ev.checked}</td>
					<td>${ev.pmdays}</td>
				</tr>
			</c:forEach>
				<tr>
					<td colspan=4 style="text-align:center;">
					<input type="button" value="견적신청하기" onclick="location.href='${pageContext.request.contextPath}/board2/estimatewrite.do2'">
					<input type="button" class="back" onclick="back();" value="돌아가기"></td>
				</tr>
			</tbody>
		</table>
</form>
</body>
</html>