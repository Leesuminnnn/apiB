<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>Qna상세보기</title>
<style>

</style>

</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
	<form name="frm">
	<h1>Qna 상세보기</h1>
	<br>
		<table border=1 class="content">
			<tr>
				<td style="width: 180px; height: 40px;">제목 / 작성일</td>
				<td>${qv.subject} / ${qv.writeday}</td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td>${qv.writer}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 500px; height: 300px; vertical-align:top;">
				${qv.content}
				<br>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<c:choose>
						<c:when test="${sessionScope.memberName eq '관리자'}">
							<input type="button" name="list" value="목록" onclick="location.href='${pageContext.request.contextPath}/board2/qna.do2'">
							<input type="button" name="modipy" value="수정" onclick="location.href='${pageContext.request.contextPath}/board2/qnaModify.do2?qidx=${qv.qidx}'">
							<input type="button" name="delete" value="삭제" onclick="location.href='${pageContext.request.contextPath}/board2/qnaDelete.do2?qidx=${qv.qidx}'">
							<input type="button" name="Reply" value="답변" onclick="location.href='${pageContext.request.contextPath}/board2/qnaReply.do2?qidx=${qv.qidx}&originqidx=${qv.originqidx}&depth=${qv.depth}&level_=${qv.level_}'">
						</c:when>
						<c:when test="${sessionScope.memberName eq qv.writer}">
							<input type="button" name="list" value="목록" onclick="location.href='${pageContext.request.contextPath}/board2/qna.do2'">
							<input type="button" name="modipy" value="수정" onclick="location.href='${pageContext.request.contextPath}/board2/qnaModify.do2?qidx=${qv.qidx}'">
							<input type="button" name="delete" value="삭제" onclick="location.href='${pageContext.request.contextPath}/board2/qnaDelete.do2?qidx=${qv.qidx}'">
						</c:when>
						<c:otherwise>
							<input type="button" name="list" value="목록" onclick="location.href='${pageContext.request.contextPath}/board2/qna.do2'">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>