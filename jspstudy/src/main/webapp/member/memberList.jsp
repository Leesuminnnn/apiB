<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jspstudy.domain.*" %>
<%@ page import="java.util.*" %>
<% 
	//MemberVo에 담겨있는 회원 정보들을 가져온다
	ArrayList<MemberVo> alist = (ArrayList<MemberVo>)request.getAttribute("alist");


	 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
</head>
<style>
*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing:border-box;
	}
	
h1, table, div{
	margin: 0 auto;
}
h1, div{
	text-align: center;
}

table,td{
	border: 1px solid #464646;
	border-collapse:collapse;
	width: 800px;
	text-align: center;
}
table{
	margin-top: 20px;
	
}
table tr:nth-child(even){
	background-color: aliceblue;

}
a{
	color: #000000;
}
</style>


<body>
<div style="text-align:right;">
<%
if(session.getAttribute("midx") != null){
	out.println("회원아이디:" +session.getAttribute("memberId"));
	out.println("회원이름:" +session.getAttribute("memberName"));
	out.println("<a href='"+request.getContextPath()+"/member/memberLogout.do'>로그아웃</a>"+"<br>");
}
%>
</div>
<h1>회원 목록</h1>
<table border="1">
	<tr>
		<td>midx번호</td>
		<td>이름</td>
		<td>전화번호</td>
		<td>작성일</td>
	</tr>	
	<%		//향상된 for문!!				
	for (MemberVo mv : alist) {%>	
	<tr>
		<td><%=mv.getMidx() %></td>
		<td><%=mv.getMembername() %></td>
		<td><%=mv.getMemberphone() %></td>
		<td><%=mv.getWriteday() %></td>
	</tr>
	<% }%>
	
		
</table>
<div>
	<a href="../index.jsp">메인 화면</a>
</div>
</body>
</html>