<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="single.dbconn.*" %>
<%@ page import="java.util.*" %>
<%
	ArrayList<MemberVo> alist = (ArrayList<MemberVo>)request.getAttribute("alist");
%>
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
	<li><a href="<%=request.getContextPath()%>/member2/usersInfo.do2">&nbsp;사용자</a></li>
	
</ul>
<p>컨텐츠관리</p>
<ul>
	<li><a href="<%=request.getContextPath()%>/board2/iqylist.do2">&nbsp;문의내역</a></li>
	<li><a href="<%=request.getContextPath()%>/board2/estimatelist.do2">&nbsp;견적내역</a></li>
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
			<%for( MemberVo mv : alist ) {%>
			<tr>
				<td><%=mv.getMidx() %></td>
				<td><%=mv.getMembername() %></td>
				<td><%=mv.getMemberid() %></td>
				<td><%=mv.getMemberemail() %></td>
				<td><%=mv.getMembergender() %></td>
				<td><%=mv.getMemberphone() %></td>
				<td><%=mv.getWriteday() %></td>
			</tr>
			<%} %>
			<tr>
				<td colspan=7><a href="javascript:history.back();">돌아가기</a></td>
				
			</tr>
		</table>	
	</form>
</body>
</html>