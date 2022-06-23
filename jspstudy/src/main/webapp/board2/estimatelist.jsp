<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>견적내역게시판</title>
<style>

</style>
<script>
	
</script>
</head>
<body>
<div class="wrap">

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->

<h1>견적내역게시판</h1>
<br>
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

<div class="container">
	<div></div>
</div>


<section>
<!-- 게시판 리스트 검색기능 -->
<form name="frm" action="${pageContext.request.contextPath}/board2/estimatelist.do2" method="post">
	<table class="sch">
	<tbody style="">
		<tr style="border-top: none; text-align:right; height: 25px;">
			<td style="width: 230px; "></td>
			<td style="width: 230px; "></td>
			<td style="width: 230px; height: 40px; padding: 5px; border: 1px solid #fff; border-radius: 5px; display:flex; flex:1; flex-direction: row; justify-content: flex-end;">
				<select name="searchType" style="margin-right:5px;">
					<option value="writer">작성자</option>
					<option value="place">지역</option>
				</select>
				<input type="text" name="keyword" size="10" style="margin-right:5px;">
				<input class="btn" type="submit" name="submit" value="검색">
			</td>
		</tr>
	</tbody>	
	</table>
</form>

<table style="width:690px;" border="1" class="content" >
	<tbody>
		<tr>
			<td>이름</td>
			<td>지역</td>
			<td>희망공사일</td>
			<td>작성일</td>
			<td>상태</td>
			<td>결제일</td>
		</tr>
		<c:forEach var="ev" items="${alist}">
			
			
			
			<tr>
				<td>${ev.writer}</td>
				<td>${ev.place}</td>
				<td>${ev.esdays}</td>
				<!-- 날짜 자르기 -->
				<td>${ev.writeday}</td>
				<td>${ev.checked}<br>
				<c:choose>
					<c:when test="${ev.checked eq 'N'}">
						<a href="${pageContext.request.contextPath}/board2/estimatecontent.do2?eidx=${ev.eidx}">확인하기</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/board2/estimatecontent.do2?eidx=${ev.eidx}">상세보기</a>
					</c:otherwise>
				</c:choose>
				
				</td>
				<td>
				${ev.pmdays}
				</td>
			</tr>
		</c:forEach>

	</tbody>
</table>
</section>
<!-- 게시판 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; border-bottom: none;">
		<td style="width:200px; text-align:right;">
			<c:if test="${pm.prev eq true}">
				<a href="${pageContext.request.contextPath}/board2/estimatelist.do2?page=${pm.startPage-1}$keyword=${pm.scri.keword}&serchType=${pm.scri.searchType}">◀</a>
			</c:if>
		</td>
		<td>
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage }" step="1">
				<a href="${pageContext.request.contextPath}/board2/estimatelist.do2?page=${i}&keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}">[${i}]</a>
			</c:forEach>
		</td>
		<td style="width:200px; text-align:left;">
			<c:if test="${pm.next and pm.endPage lt 0}">
				<a href="${pageContext.request.contextPath}/board2/estimatelist.do2?page=${pm.endPage+1}&keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}">▶</a>
			</c:if>
		</td>
	</tr>
</table>
<!-- 게시판 페이징 끝 -->
</div>
</body>
</html>