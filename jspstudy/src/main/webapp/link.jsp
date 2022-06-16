<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<!--  로그인 탭 -->
<div class="user_wrap" style="display:flex;">
	<strong style="font-size:1.5rem;">
		<a href="<%=request.getContextPath()%>/board2/index.do2">logo</a>
	</strong>
	
	<!-- 탭메뉴 -->
	<div class="title" style="text-align: left; margin-bottom: 20px;">
		<div style="display: inline-block;">
			<div><a href="<%=request.getContextPath()%>/board2/ctn.do2">시공사례</a></div>ㅣ
			<div><a href="<%=request.getContextPath()%>/board2/rvList.do2">고객후기</a></div>ㅣ
			<div><a href="<%=request.getContextPath()%>/board2/estimatewrite.do2">견적신청</a></div>ㅣ
			<div><a href="<%=request.getContextPath()%>/board2/help.do2">고객센터</a></div>
		</div>	
	</div>
	<!-- 탭메뉴 끝 -->
	<div class="user" style="margin-right: 10px;text-align: right;">	
	 <%
	 	//만약 midx가 존재한다면
	 	if(session.getAttribute("midx") != null){
	 		out.println(session.getAttribute("memberName")+"("+session.getAttribute("memberId")+")"+"님 안녕하세요"+"<br>");
	 		out.println("<a href='"+request.getContextPath()+"/member2/Logout.do2'>로그아웃</a>");
	 		//만약 이름이 관리자 이면 관리자 계정으로 로그인한다
	 		if(session.getAttribute("memberName").equals("관리자")){
	 		out.println("<a href='"+request.getContextPath()+"/board2/admin.do2'>관리자페이지</a>"+"<br>");
	 		}
	 	}else{
	%>
		<div><a href="<%=request.getContextPath()%>/member2/memberJoin.do2">회원가입</a>ㅣ<a href="<%=request.getContextPath()%>/member2/Login.do2">로그인</a></div>
		<div>로그인을 해주세요</div>
		<% }%>
	 </div>
</div>
 <!-- 로그인 탭 끝 -->



