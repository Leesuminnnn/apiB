<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>
<%
	ArrayList<EstmVo> alist = (ArrayList<EstmVo>)request.getAttribute("alist");


%>
<% 
	PageMaker pm = (PageMaker)request.getAttribute("pm");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>견적내역게시판</title>
<style>

</style>
<script>
	
</script>
</head>
<body>
<div class="wrap">

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->

<h1>견적내역게시판</h1>
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

<div class="container">
	<div></div>
</div>


<section>
<table style="width:690px;" border="1" class="content" >
	<tbody>
		<tr>
			<td>이름</td>
			<td>지역</td>
			<td>희망공사일</td>
			<td>작성일</td>
			<td>상태</td>
			<td>결제일</td>
		</tr>
		
		<%for (EstmVo ev : alist) {%>
		<tr>
			<td><%=ev.getWriter() %></td>
			<td><%=ev.getPlace() %></td>
			<td><%=ev.getEsdays() %></td>
			<td><%=ev.getWriteday().substring(5,10) %></td>
			<td><%=ev.getChecked() %><br>
			<%if(ev.getChecked().equals("N")){
				%>
			
			<a href="<%=request.getContextPath() %>/board2/estimatecontent.do2?eidx=<%=ev.getEidx() %>">확인하기</a>
			<%}else{%>
			<a href="<%=request.getContextPath() %>/board2/estimatecontent.do2?eidx=<%=ev.getEidx() %>">상세보기</a>
			<%}%>
			</td>
			<td>
			<%=ev.getPmdays()%>
			</td>
		</tr>
		
<%} %>
	</tbody>
</table>
</section>

<!-- 게시판 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; 
	border-bottom: none;">
		<td style="width:200px; text-align:right;">
		<%
		
		String keyword = pm.getScri().getKeyword();
		
		String searchType = pm.getScri().getSearchType();
		
		if(pm.isPrev() == true)
			out.println("<a href='"+request.getContextPath()+"/board2/estimatelist.do2?page="+(pm.getStartPage()-1)+"&keyword="+pm.encoding(pm.getScri().getKeyword())+"&searchType="+pm.getScri().getSearchType()+"'>◀</a>");
		%>
		</td>
		<td>
		<%
		for(int i = pm.getStartPage(); i<=pm.getEndPage(); i++){
			out.println("<a href='"+request.getContextPath()+"/board2/estimatelist.do2?page="+i+"&keyword="+pm.encoding(pm.getScri().getKeyword())+"&searchType="+pm.getScri().getSearchType()+"'>"+"["+i+"]"+"</a>");
			
		}
		
		%>
		</td>
		<td style="width:200px; text-align:left;">
		<%
		if(pm.isNext()&&pm.getEndPage() > 0){
			out.println("<a href='"+request.getContextPath()+"/board2/estimatelist.do2?page="+(pm.getEndPage()+1)+"&keyword="+pm.encoding(pm.getScri().getKeyword())+"&searchType="+pm.getScri().getSearchType()+"'>▶</a>");
		}
		 %>
		</td>
	</tr>
</table>
<!-- 게시판 페이징 끝 -->
</div>
</body>
</html>