<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.*" %>
<%@ page import="java.util.*" %>
<% 
	ArrayList<BoardVo> alist = (ArrayList<BoardVo>)request.getAttribute("alist");
	PageMaker pm = (PageMaker)request.getAttribute("pm");

%>
<% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>iqy</title>
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
<form name="frm" action="<%=request.getContextPath()%>/board2/iqy.do2" method="post">
<h1><a onClick="window.location.reload()">1 : 1 문의하기</a></h1>

<ul>
	<li><a href="<%=request.getContextPath()%>/board2/qna.do2">Q n A</a></li>
	<li><a href="<%=request.getContextPath()%>/board2/iqy.do2">1:1 문의</a></li>
</ul>

<table class="list">
	<tr>
		<td>불편한점이 있으신가요?</td>
	</tr>
	<tr>
		<td><a href="<%=request.getContextPath()%>/board2/iqywrite.do2">문의하기</a></td>
	</tr>
</table>
</form>
</body>
</html>