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
*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
	}
	
	table{
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;		
	vertical-align: middle; /*글자 중앙정렬*/	
	}
	h1{
		text-align: center;
	}
	
	tr{
	border-bottom: 1px solid #aaaaaa;
	height: 50px;
	vertical-align: middle;
	}
	.user{
	margin-right: 10px;
	text-align: right;
}
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
<div class="user">	
		<div><a href="#">마이페이지</a>ㅣ<a href="#">로그아웃</a></div>
		<div>이**님 안녕하세요!</div>
	</div>
	<h1>내가 작성한 견적페이지</h1>
	<hr>
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