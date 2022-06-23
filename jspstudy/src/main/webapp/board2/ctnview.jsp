<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>시공사례상세보기</title>
<style>

</style>

</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<div class="wrap">
<!-- 필요없는 코드
<c:if test="${sessionScope.memberName ne '관리자' }">
	<script type="text/javascript">
		alert("잘못된 접근입니다.");javascript:history.back();
	</script>
</c:if>
 -->

	<form name="frm">
	<h1>시공사례 상세보기</h1>
	<br>
		<table border=1 class="content">
			<tr>
				<td style="width: 180px; height: 40px;">제목 / 작성일</td>
				<td style="text-align:left;">${cv.subject} / ${cv.writeday.substring(5,10)}</td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="text-align:left;">${cv.writer}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 500px; height: 300px; vertical-align:top; text-align:left;">
				${cv.content}
			
				<br>
				<c:choose>
					<c:when test="${cv.filename ne null}">
						<img src="${pageContext.request.contextPath}/images/${cv.filename}">
					</c:when>
					<c:otherwise>
						<img src="${pageContext.request.contextPath}/images/${cv.filename}" onerror="this.src='${pageContext.request.contextPath}/images/noimg.jpg'">
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<c:choose>
						<c:when test="${sessionScope.memberName eq cv.writer }">
							<input type="button" name="ctnmodipy" value="수정" onclick="location.href='${pageContext.request.contextPath}/board2/ctnmodify.do2?cidx=${cv.cidx}'">
							<input type="button" name="ctndelete" value="삭제" onclick="location.href='${pageContext.request.contextPath}/board2/ctndelete.do2?cidx=${cv.cidx}'">
							<input type="button" name="ctnlist" value="목록"onclick="location.href='${pageContext.request.contextPath}/board2/ctn.do2'">
						</c:when>
						<c:when test="${sessionScope.memberName eq '관리자'}">
							<input type="button" name="ctndelete" value="삭제" onclick="location.href='${pageContext.request.contextPath}/board2/ctndelete.do2?cidx=${cv.cidx}'">
							<input type="button" name="ctnlist" value="목록"onclick="location.href='${pageContext.request.contextPath}/board2/ctn.do2'">
						</c:when>
						<c:otherwise>
						<input type="button" name="ctnlist" value="목록"onclick="location.href='${pageContext.request.contextPath}/board2/ctn.do2'">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>	
	</form>
</div>
</body>
</html>