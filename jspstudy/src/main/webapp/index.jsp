<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link type="text/css" rel="stylesheet" href="board2/boardcss.css">
<title>메인화면</title>
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
<script>
/* 
	$(function(){
		$("#btn").css({
			"background" : "none",
			"border" : "2px solid dakseagreen",
			"color" : "#000000",
			"padding" : "10px 20px",
			"border-radius" : "20px",
			"outline" : "none",
			"transition" : "all .4s",
			"vertical-align" : "middle",
			"height" : "40px;
		});
		
		$("#btn:hover").css({
			"background":"darkslategray",
			"color":"white"
		});
		$("#content").css("width":"80%");
		$("img").css("width":"80%");
		
	});
	 */
</script>
</head>
<body>
<!-- 내용 -->
<!-- 메인화면 -->
<form class="frm">
<!-- 공통nav -->
<jsp:include page="link.jsp"/>
<!-- 공통nav끝 -->
<div>
	<table class="content" id="content">
		<tbody>
			<tr>
				<td><img src="${pageContext.request.contextPath}/images/인테리어6.jpg" alt=""></td>
			</tr>
		</tbody>
	</table>
</div>
	<div style="margin: 0 auto; text-align:center;" >
		<input type="button" name="btn" id="btn" value="자세히보기 >" onclick="location.href='${pageContext.request.contextPath}/member2/Login.do2'">
	</div>
</form>
</body>
</html>