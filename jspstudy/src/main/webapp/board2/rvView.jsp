<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>고객후기상세보기</title>
<style>

</style>

</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
	<form name="frm">
	<h1>고객후기 상세보기</h1>
	<br>
		<table border=1 class="content">
			<tr>
				<td style="width: 180px; height: 40px;">제목 / 작성일</td>
				<td>${rv.subject} / ${rv.writeday}</td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자 / 별점</td>
				<td>${rv.writer}님 / ${rv.star}</td>
				
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 500px; height: 300px; vertical-align:top;">
				${rv.content}
				<br>
				<img src="${pageContext.request.contextPath}/images/${rv.filename}">
				
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<c:choose>
						<c:when test="${sessionScope.memberId ne null and 
							sessionScope.imadmin eq 'N'}">
							<input type="button" name="list" value="목록" onclick="location.href='${pageContext.request.contextPath}/board2/rvList.do2'">
						</c:when>
						<c:otherwise>
							<input type="button" name="modipy" value="수정" onclick="location.href='${pageContext.request.contextPath}/board2/rvModify.do2?ridx=${rv.ridx}'">
							<input type="button" name="delete" value="삭제" onclick="location.href='${pageContext.request.contextPath}/board2/rvDelete.do2?ridx=${rv.ridx}'">
							<input type="button" name="list" value="목록" onclick="location.href='${pageContext.request.contextPath}/board2/rvList.do2'">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>총 **개의 댓글</td>
				<td>준비 중 입니다.</td>
			</tr>
		</table>	
	</form>
</body>
</html>