<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="single.domain.MemberVo" %>

<% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>
<% 
	out.println("<script>alert('준비중입니다.');location.href='"+request.getContextPath()+"/board2/index.do2'</script>"); 

%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="text/css" rel="stylesheet" href="../board2/boardcss.css">
	<TITLE> 마이 페이지 </TITLE>
	<style>
	
	.tab{
	
	float:left;
	}
	</style>
	<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	//돌아가기를 누르면
	
	function fg(){
		var fm = document.frm;
		
		alert("메인화면으로 돌아갑니다.");
		fm.action = "../board2/index.jsp";
		fm.method = "post";
		fm.submit();
		
		return;
	}
	
	
	</script>
	</HEAD>

	<BODY>
	<!-- 공통nav -->
	<jsp:include page="../link.jsp"/>
	<!-- 공통nav끝 -->	
	
		
	<h1>마이페이지</h1>
	<br>
	
	<div class="tab">	
		<ul class="tabnav">
			<li><a href="<%=request.getContextPath()%>/member2/memberMyPageModify.do2?midx=<%=mv.getMidx()%>">회원정보수정</a></li>
			<li><a href="<%=request.getContextPath()%>/member2/memberMyPageModify.do2?midx=<%=mv.getMidx()%>">내가작성한견적</a></li>
		</ul>
	</div>
		
	</BODY>
</HTML>
