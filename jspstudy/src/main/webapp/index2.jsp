<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<style>
*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
}

h1, .dv{
	text-align: center;
}
.dv2{
	margin-right: 10px;
	text-align: right;
	
}
.dv{
	margin-top: 20px;
}
.dv>div, .dv2>div{
	display: inline-block;
}
a{
	color: #000000;
}
a:hover{
	color: #a828a8;
}
</style>
<script>
	
</script>
</head>
<body>
<div class="dv2">
	<div><a href="<%=request.getContextPath() %>/member/memberList.do">회원 리스트</a></div><br>
	<%
		if(session.getAttribute("midx") != null){
			out.println("회원아이디:" +session.getAttribute("memberId"));
			out.println("회원이름:" +session.getAttribute("memberName"));
			out.println("<a href='"+request.getContextPath()+"/member/memberLogout.do'>로그아웃</a>"+"<br>");
		}else{

	%>
	<div><a href="<%=request.getContextPath() %>/member/memberJoin.do">회원가입</a></div>
	
	<div><a href="<%=request.getContextPath() %>/member/memberLogin.do">로그인</a></div>
	<% }%>
</div>
<h1>메인 페이지 입니다.</h1>
<div class="dv">
	<div><a href="<%=request.getContextPath() %>/board/boardWrite.do">게시판 글쓰기</a></div>
	<div><a href="<%=request.getContextPath() %>/board/boardList.do">게시판 리스트</a></div>
</div>
</body>
</html>