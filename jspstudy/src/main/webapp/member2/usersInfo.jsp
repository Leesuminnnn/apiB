<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="../board2/boardcss.css">
<title>회원정보보기</title>
<style>

</style>

</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->

<h1>회원정보 보기</h1>
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
	<form name="frm">
	
		<table class="content" border=1 style="width:690px;">
			
			<tr>
				<td>회원번호</td>
				<td>회원이름</td>
				<td>아이디</td>
				<td>이메일</td>
				<td>성별</td>
				<td>연락처</td>
				<td>가입일</td>
			</tr>
			<c:forEach var="mv" items="alist">
			<tr>
				<td>${mv.midx}</td>
				<td>${mv.memberName}</td>
				<td>${mv.memberId}</td>
				<td>${mv.memberEmail}</td>
				<td>${mv.memberGender}</td>
				<td>${mv.memberPhone}</td>
				<td>${mv.writeday}</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan=7><a href="javascript:history.back();">돌아가기</a></td>
				
			</tr>
		</table>	
	</form>
</body>
</html>