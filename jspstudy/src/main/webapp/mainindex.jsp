<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.Dbconn" %>

<% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>
<% 
Dbconn dbconn = new Dbconn(); 
System.out.println("dbconn "+dbconn);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link type="text/css" rel="stylesheet" href="board2/boardcss.css">
<title>메인화면 git test 33</title>
<style>
	input[type=button]{
	background: none;
	border: 2px solid darkseagreen;
	color: #000;
	padding: 10px 20px;
	border-radius: 20px;
	outline: none;
	transition: all .4s;
	vertical-align:middle;
	height: 40px;
	}
	input[type=button]:hover{
	background: darkslategray;
	color: white;
	}
	.content, img{
	width: 80%;
	}
</style>

</head>
<body>
<!-- 내용 -->
<!-- 메인화면 -->
<form class="frm">
<div>
	<table class="content">
		<tbody>
			<tr>
				<td><img src="images/인테리어6.jpg" alt=""></td>
			</tr>
		</tbody>
	</table>
</div>
	<div style="margin: 0 auto; text-align:center;" >
		<input type="button" value="자세히보기 >" onclick="location.href='<%=request.getContextPath() %>/board2/index.do2'">
	</div>
</form>
</body>
</html>