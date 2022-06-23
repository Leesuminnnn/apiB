<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%><%-- 
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %> --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>문의내역게시판</title>
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

<h1>문의내역게시판</h1>
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
<table style="width:690px;" border="1" class="content" >
	<tbody>
		<tr>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
		</tr>
			<c:forEach var="iv" items="${alist}">
			
			
			<tr>
				<td style="text-align:left;">
				<!-- 답변형 게시판 -->
				<c:forEach var="i" begin="1" end="${iv.level_}" step="1">
				&nbsp;&nbsp;
					<c:if test="${i==iv.level_}">
					└
					</c:if>
				</c:forEach>
				<!-- 답변형 게시판 끝 -->			
				<a href="${pageContext.request.contextPath}/board2/iqyView.do2?iidx=${iv.iidx}">${iv.subject}</a>
				
				</td>
				<td>${iv.writer}</td>
				<td>${iv.writeday}</td>
			</tr>
			</c:forEach>
	</tbody>
</table>
</section>

<!-- 게시판 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; 
	border-bottom: none;">
		<td style="width:200px; text-align:right;">
		<c:if test="${pm.prev eq true}">
			<a href="${pageContext.request.contextPath}/board2/iqylist.do2?page=${pm.startPage-1}&keyword=${pm.scri.keyword }">◀</a>
		</c:if>
		
		</td>
		<td>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" step="1" var="i">
			<a href="${pageContext.request.contextPath}/board2/iqylist.do2?page=${i}&keyword=${pm.scri.keyword}">[${i}]</a>
		</c:forEach>
		
		</td>
		<td style="width:200px; text-align:left;">
		<c:if test="${pm.next and pm.endPage lt 0}">
			<a href="${pageContext.request.contextPath}/board2/iqylist.do2?page=${pm.endPage+1}&keyword=${pm.scri.keyword}">▶</a>
		</c:if>
		
		</td>
	</tr>
</table>
<!-- 게시판 페이징 끝 -->
</div>
</body>
</html>