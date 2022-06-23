<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>help</title>
</head>
<style>
tr>td:first-child{
	text-align: center;
	}
</style>
<script>
	
</script>
</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<form name="frm" action="#" method="post">
<h1><a onClick="window.location.reload()">고객센터</a></h1>

<ul>
	<li><a href="${pageContext.request.contextPath}/board2/qna.do2">Q n A</a></li>
	<li><a href="${pageContext.request.contextPath}/board2/iqy.do2">1:1 문의</a></li>
</ul>

<table class="list">
	<tr>
		<td>불편한점이 있으신가요?</td>
	</tr>
	<tr>
		<td><a href="${pageContext.request.contextPath}/board2/iqywrite.do2">문의하기</a></td>
	</tr>
</table>


</form>
</body>
</html>