<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>Iqy상세보기</title>
<style>

</style>

</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
	<form name="frm">
	<h1>Iqy 상세보기</h1>
	<br>
		<table border=1 class="content">
			<tr>
				<td style="width: 180px; height: 40px;">제목 / 작성일</td>
				<td>${iv.subject} / ${iv.writeday}</td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td>${iv.writer}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 500px; height: 300px; vertical-align:top;">
				${iv.content}
				<br>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<input type="button" name="modipy" value="수정" onclick="location.href='${pageContext.request.contextPath}/board2/iqyModify.do2?iidx=${iv.iidx}'">
					<input type="button" name="delete" value="삭제" onclick="location.href='${pageContext.request.contextPath}/board2/iqyDelete.do2?iidx=${iv.iidx}'">
					<input type="button" name="Reply" value="답변" onclick="location.href='${pageContext.request.contextPath}/board2/iqyReply.do2?iidx=${iv.iidx}&originiidx=${iv.originiidx}&depth=${iv.depth}&level_=${iv.level_}'">
					<input type="button" name="list" value="목록" onclick="location.href='${pageContext.request.contextPath}/board2/iqylist.do2'">
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>