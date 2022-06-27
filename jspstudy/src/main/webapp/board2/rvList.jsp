<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>고객후기</title>
<style>

.content{
	text-align:center;
	margin: 0 auto;
}

tr{
	width: 690px;
	height: 40px;
}
.container{
	text-align: left;
	margin: 0 auto;
	margin-top: 50px;
	width: 690px;
}

.container div{
	display: inline-block;
}
</style>
<script>
	
</script>
</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<!-- 게시판 리스트 검색기능 -->
<form name="frm" action="${pageContext.request.contextPath}/board2/rvList.do2" method="post">
	<table class="sch">
		<tbody style="">
			<tr style="border-top: none; text-align:right; height: 25px; margin:0 auto;">
				<td style="width: 230px; "></td>
				<td style="width: 230px; "></td>
				<td style="width: 230px; height: 40px; padding: 5px; border: 1px solid #fff; border-radius: 5px; display:flex; flex:1; flex-direction: row; justify-content: flex-end;">
					<select name="searchType" style="margin-right:5px;">
						<option value="subject">제목</option>
						<option value="tag">태그</option>
					</select>
					<input type="text" name="keyword" size="10" style="margin-right:5px;">
					<input class="btn" type="submit" name="submit" value="검색">
				</td>
			</tr>
		</tbody>	
	</table>
</form>
<!-- 검색기능 끝 -->
<!-- 글이 존재하지 않을경우 -->
<c:choose>
	<c:when test="${alist eq '[]'}">
		<p style="text-align:center;">글이 존재하지 않습니다.</p>
	</c:when>
	<c:otherwise>
	

<c:forEach var="rv" items="${alist}">
<table border="1" class="content">
	<tbody>
		<tr>
			<td style="text-align:left;"><a href="${pageContext.request.contextPath}/board2/rvView.do2?ridx=${rv.ridx}">${rv.subject}<br>${rv.content}</a></td>
			<td rowspan="2" style="width:150px; height:200px;">
			<c:choose>
				<c:when test="${rv.filename eq null}">
					<img style="height:150px;width:200px;" src="${pageContext.request.contextPath}/images/noimg.jpg">
				</c:when>
				<c:otherwise>
					<img style="height:150px;width:200px;" src="${pageContext.request.contextPath}/images/${rv.filename}">
				</c:otherwise>
			</c:choose>
				
			</td>
		</tr>
		<tr>
			<td style="text-align:left; height:60px; width:540px;">
			별점:${rv.star} ${rv.writer}님<br>
			<a href="${pageContext.request.contextPath}/board2/rvList.do2?page=${pm.startPage-1}&keyword=${rv.tag}&searchType=tag${rv.tag}">${rv.tag}</a>
			</td>
		</tr>
	</tbody>
</table>
<br>
</c:forEach>
</c:otherwise>
</c:choose>
<table class="content">
	<tbody>
		<tr>
			<td><a href="${pageContext.request.contextPath}/board2/rvwrite.do2">리뷰작성하기</a></td>
		</tr>
	</tbody>
</table>
<!-- 게시판 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; border-bottom: none;">
		<td style="width:200px; text-align:right;">
			<c:if test="${pm.prev eq true}">
				<a href="${pageContext.request.contextPath}/board2/rvList.do2?page=${pm.startPage-1}&keyword=${pm.scri.keyword }&searchType=${pm.scri.searchType}">◀</a>
			</c:if>
		</td>
		<td>
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
				<a href="${pageContext.request.contextPath}/board2/rvList.do2?page=${i}&keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}">[${i}]</a>
			</c:forEach>
		</td>
		<td style="width:200px; text-align:left;">
			<c:if test="${pm.next and pm.endPage lt 0}">
				<a href="${pageContext.request.contextPath}/board2/rvList.do2?page=${pm.endPage+1}&keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}">▶</a>
			</c:if>
		</td>
	</tr>
</table>
<!-- 게시판 페이징 끝 -->
</body>
</html>