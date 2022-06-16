<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<%
	RvVo rv = (RvVo)request.getAttribute("rv");
%>
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
				<td><%=rv.getSubject() %> / <%=rv.getWriteday().substring(5,10) %></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자 / 별점</td>
				<td><%=rv.getWriter().substring(0,1) %>**님 / <%=rv.getStar() %></td>
				
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 500px; height: 300px; vertical-align:top;">
				<%=rv.getContent() %>
				<br>
				<img src="<%=request.getContextPath()%>/images/<%=rv.getFilename()%>">
				
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<%if (session.getAttribute("memberId") != null
						&& session.getAttribute("imadmin").equals("N")) {%>
					<input type="button" name="list" value="목록" onclick="location.href='<%=request.getContextPath() %>/board2/rvList.do2'">
				<%} %>
					<input type="button" name="modipy" value="수정" onclick="location.href='<%=request.getContextPath() %>/board2/rvModify.do2?ridx=<%=rv.getRidx()%>'">
					<input type="button" name="delete" value="삭제" onclick="location.href='<%=request.getContextPath() %>/board2/rvDelete.do2?ridx=<%=rv.getRidx()%>'">
					<input type="button" name="list" value="목록" onclick="location.href='<%=request.getContextPath() %>/board2/rvList.do2'">
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