<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
<meta charset="utf-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="/boardcss.css">
<style>


*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
	color: #000000;
	}
.content{
	text-align:center;
	margin: 0 auto;
}
	
.title div{
	display: inline-block;
	
}
.title{
	text-align: left;
	margin: 0 auto;
	margin-bottom: 20px;
}

h1, .list{
	text-align:center;
}

.list{
	margin: 0 auto;
}

.sch{
	margin: 0 auto;
	width: 690px;
	margin-top: 20px;
}

tr{
	height: 40px;
}

a:hover{
	color: #a828a8;
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
<script>
	
</script>
</head>
<body>
<div class="wrap">
<%if(session.getAttribute("memberName")!=("관리자")){
		out.println("<script>alert(잘못된 접근입니다.);javascript:history.back() </script>");
		}
	 %>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->


<h1>관리자 페이지</h1>
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
<section>
<!-- 사용자 -->
<form name="frm">
		<table class="content" border=1 style="width:690px;">
			<tr>
				<td>회원번호</td>
				<td>회원이름</td>
				<td>아이디</td>
			</tr>
			<%for( MemberVo mv : alist ) {%>
			<tr>
				<td><%=mv.getMidx() %></td>
				<td><%=mv.getMembername() %></td>
				<td><%=mv.getMemberid() %></td>
			</tr>
			<%} %>
			
		</table>	
	</form>
</section>
</div>
</body>
</html>