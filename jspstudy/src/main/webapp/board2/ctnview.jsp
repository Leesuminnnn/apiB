<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.service.*" %>
<% CtnVo cv =  (CtnVo)request.getAttribute("cv"); %>	<!-- 강제 형변환 -->

<% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>
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
<%if(session.getAttribute("memberName")!=("관리자")){
		out.println("<script>alert(잘못된 접근입니다.);javascript:history.back() </script>");
		}
	 %>

	<form name="frm">
	<h1>시공사례 상세보기</h1>
	<br>
		<table border=1 class="content">
			<tr>
				<td style="width: 180px; height: 40px;">제목 / 작성일</td>
				<td style="text-align:left;"><%=cv.getSubject() %> / <%=cv.getWriteday().substring(5,10) %></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="text-align:left;"><%=cv.getWriter() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 500px; height: 300px; vertical-align:top; text-align:left;">
				<%=cv.getContent() %>
				<%
				
				%>
				<br>
				<%if(cv.getFilename() != null){ %>
				
				<img src="<%=request.getContextPath()%>/images/<%=cv.getFilename()%>">
				<%}else{ %>
					<div></div>
					<%} %>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<input type="button" name="ctnmodipy" value="수정" onclick="location.href='<%=request.getContextPath() %>/board2/ctnmodify.do2?cidx=<%=cv.getCidx()%>'">
					<input type="button" name="ctndelete" value="삭제" onclick="location.href='<%=request.getContextPath() %>/board2/ctndelete.do2?cidx=<%=cv.getCidx()%>'">
					<input type="button" name="ctnlist" value="목록"onclick="location.href='<%=request.getContextPath() %>/board2/ctn.do2'">
				</td>
			</tr>
		</table>	
	</form>
</div>
</body>
</html>