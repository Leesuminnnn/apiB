<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jspstudy.domain.BoardVo" %>
<%@ page import="java.util.*" %>
<% BoardVo bv =  (BoardVo)request.getAttribute("bv"); %>	<!-- 강제 형변환 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보보기</title>
<style>

	*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
	}
	
	h1{
	height: 27px;
	margin-top: 5px;
	text-align: center;
	}
	
	table{
	margin-top: 20px;
	border-collapse: collapse;
	margin: 0 auto;
	}
	
	input[type=button]{
	padding: 5px;
	cursor: pointer;
	border-radius: 10px;
	border: 1px solid #bdbdbd;
	background: #fafafa;
	font-size: 12px;
} 
	tr>td:first-child{
	text-align: center;
	}
	.user{
	margin-right: 10px;
	text-align: right;
}
</style>

</head>
<body>
<div class="user">	
	<div><a href="member/관리자페이지.jsp">관리자페이지</a>ㅣ로그아웃</div>
	<div>관리자님 환영합니다!</div>
</div>

	<form name="frm">
	<h1>관리자 추가하기</h1>
	<br>
		<table border=1>
			<tr>
				<td>관리자이름</td>
				<td>관리자2</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>admin1</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>adimin1@naver.com</td>
			</tr>
			<tr>
				<td>성별</td>
				<td>남</td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>010-1234-1234</td>
			</tr>
			<tr>
				<td colspan=2>
					<button>추가하기</button>
					<button>돌아가기</button>
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>