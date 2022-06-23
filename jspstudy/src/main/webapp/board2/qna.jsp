<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>QnA</title>
</head>
<style>
.content{
	text-align:center;
	margin: 0 auto;
	width:690px;
	text-align:left;
	}
</style>
<script>
	
</script>
</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<h1><a href="${pageContext.request.contextPath}/board2/qna.do2">QnA</a></h1>
<ul>
	<li><a href="${pageContext.request.contextPath}/board2/qna.do2">Q n A</a></li>
	<li><a href="${pageContext.request.contextPath}/board2/iqy.do2">1:1 문의</a></li>
</ul>
<!-- 게시판 리스트 검색기능 -->
<form name="frm" action="${pageContext.request.contextPath}/board2/qna.do2" method="post">
	<table class="sch">
	<tbody style="">
		<tr style="border-top: none; text-align:right; height: 25px; margin:0 auto;">
			<td style="width: 230px; "></td>
			<td style="width: 230px; "></td>
			<td style="width: 230px; height: 40px; padding: 5px; border: 1px solid #fff; border-radius: 5px; display:flex; flex:1; flex-direction: row; justify-content: flex-end;">
				<select name="searchType" style="margin-right:5px;">
					<option value="subject">제목</option>
				</select>
				<input type="text" name="keyword" size="10" style="margin-right:5px;">
				<input class="btn" type="submit" name="submit" value="검색">
			</td>
		</tr>
	</tbody>	
	</table>
</form>
<!-- 검색기능 끝 -->

<!-- Q n A -->


<table class="content" border=1>
	<tbody>
		<c:forEach var="qv" items="${alist}">
		<tr>
			<td>
			<!-- 답변형 게시판 -->
			<c:forEach var="i" begin="1" end="${qv.level_}" step="1">
			&nbsp;&nbsp;
				<c:if test="${i==qv.level_}">
				└
				</c:if>
			</c:forEach>
			<a href="${pageContext.request.contextPath}/board2/qnaView.do2?qidx=${qv.qidx}">${qv.subject}
			</a>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td>
				<div class="dv">
					<!-- 회원은 작성하지 못하고 관리자만 작성할 수 있게 만들기 -->
					<c:choose>
						<c:when test="${sessionScope.memberName eq '관리자'}">
							<div style="text-align:right;"><a href="${pageContext.request.contextPath}/board2/qnawrite.do2">글쓰기</a></div>
						</c:when>
						<c:otherwise>
							<div style="display:none"></div>
						</c:otherwise>
					</c:choose>
				</div>
			</td>
		</tr>
		
	</tbody>	
</table>

<!-- Q n A 끝 -->

<!-- 게시판 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; 
	border-bottom: none;">
		<td style="width:200px; text-align:right;">
			<c:if test="${pm.prev eq true}">
				<a href="${pageContext.request.contextPath}/board2/qna.do2?page=${pm.startPage-1}&keyword=${pm.scri.keyword }&searchType=${pm.scri.searchType}">◀</a>
			</c:if>
		</td>
		<td>
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
				<a href="${pageContext.request.contextPath}/board2/qna.do2?page=${i}&keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}">[${i}]</a>
			</c:forEach>
		</td>
		<td style="width:200px; text-align:left;">
			<c:if test="${pm.next and pm.endPage lt 0}">
				<a href="${pageContext.request.contextPath}/board2/qna.do2?page=${pm.endPage+1}&keyword=${pm.scri.keyword}&searchType=${pm.scri.searchType}">▶</a>
			</c:if>
		</td>
	</tr>
</table>
<!-- 게시판 페이징 끝 -->
</body>
</html>