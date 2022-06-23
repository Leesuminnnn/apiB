<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>내용보기</title>
<style>

</style>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>


function back(){
	var fm = document.frm;

	//alert("취소");
	fm.action = "${pageContext.request.contextPath}/board2/estimatelist.do2";
	fm.method = "post";
	fm.submit();
}
</script>
</head>
<body>
	<div class="wrap">
<!-- 자신이 작성한 견적이거나 관리자가 아니면 접근 금지
<c:if test="${sessionScope.memberName ne '관리자'}">
	<script type="text/javascript">
		alert("잘못된 접근입니다.");javascript:history.back();
	</script>
</c:if>
 -->
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
	<form name="frm">
	<h1>견적 내용 보기</h1>
	<br>
	<!-- 메뉴 -->
	<nav>
		<p>회원관리</p>
		<ul>
			<li><a href="${pageContext.request.contextPath}/member2/usersInfo.do2">&nbsp;사용자</a></li>
	
		</ul>
		<p>컨텐츠관리</p>
		<ul>
			<li><a href="${pageContext.request.contextPath}/board2/iqylist.do2">&nbsp;문의내역</a></li>
			<li><a href="${pageContext.request.contextPath}/board2/estimatelist.do2">&nbsp;견적내역</a></li>
		</ul>
	</nav>
	
		<table border=1 class="content">
			<tr>
				<td style="width: 150px; height: 40px;">이름</td>
				<td style="width: 180px; height: 40px;">${ev.writer}</td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">지역</td>
				<td>${ev.place}</td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">휴대폰 번호</td>
				<td>${ev.memberphone}</td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">희망공사일</td>
				<td>${ev.esdays}</td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">작성일</td>
				<td>${ev.writeday}</td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">상태</td>
				<td>${ev.checked}</td>
			</tr>
			<tr>
			<!-- 만약 처리된 상태라면 처리버튼 숨기기 -->
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<c:choose>
						<c:when test="${ev.checked eq 'N'}">
							<input type="button" name="select" value="처리" onclick="location.href='${pageContext.request.contextPath}/board2/estimatepm.do2?eidx=${ev.eidx}'">
							<input type="button" name="prev" value="돌아가기" onclick="back();">
						</c:when>
						<c:otherwise>
							<input type="button" name="prev" value="돌아가기" onclick="back();">
						</c:otherwise>
					</c:choose>	
				</td>
			</tr>
		</table>	
	</form>
	</div>
</body>
</html>