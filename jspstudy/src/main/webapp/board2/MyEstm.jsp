<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.domain.MemberVo" %>
<%
	ArrayList<EstmVo> myalist = (ArrayList<EstmVo>)request.getAttribute("myalist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 작성한 견적 페이지</title>
<style>

</style>
<script>
	function back(){
	var fm = document.frm;
		
		fm.action = "javascript:history.back();";
		fm.method = "post";
		fm.submit();
		
		return;
	}
</script>
</head>
<body>
	<!-- 공통nav -->
	<jsp:include page="../link.jsp"/>
	<!-- 공통nav끝 -->
	<h1>내가 작성한 견적페이지</h1>
	<br>
	<form name="frm">
<table border=1>
	<tbody>
		<tr>
			<td>이름</td>
			<td>연락처</td>
			<td>지역</td>
			<td>희망공사일</td>
			<td>확인여부</td>
		</tr>
		<tr>
		<%for (EstmVo ev : myalist ) {%>
			<td><%=ev.getWriter() %></td>
			<td><%=ev.getMemberphone() %></td>
			<td><%=ev.getPlace() %></td>
			<td><%=ev.getEsdays() %></td>
			<td><%=ev.getChecked() %></td>
		</tr>
		<%} %>
		<tr>
			<td colspan=2><input type="button" class="back" onclick="back();" value="돌아가기"></td>
		</tr>
	</tbody>
</table>
</form>
</body>
</html>