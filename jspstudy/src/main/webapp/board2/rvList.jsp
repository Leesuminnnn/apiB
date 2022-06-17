<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<%
	ArrayList<RvVo> alist = (ArrayList<RvVo>)request.getAttribute("alist");
%>
<% 
	PageMaker pm = (PageMaker)request.getAttribute("pm");
	MemberVo mv = (MemberVo)request.getAttribute("mv");
	
	String keyword = pm.getScri().getKeyword();
	
	String searchType = pm.getScri().getSearchType();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>고객후기</title>
<style>

.content{
	text-align:center;
	margin: 0 auto;
}

tr{
	width: 690px;
	height: 40px;
}
.container{
	text-align: left;
	margin: 0 auto;
	margin-top: 50px;
	width: 690px;
}

.container div{
	display: inline-block;
}
</style>
<script>
	
</script>
</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<!-- 게시판 리스트 검색기능 -->
<form name="frm" action="<%=request.getContextPath()%>/board2/rvList.do2" method="post">
	<table class="sch">
		<tbody style="">
			<tr style="border-top: none; text-align:right; height: 25px; margin:0 auto;">
				<td style="width: 230px; "></td>
				<td style="width: 230px; "></td>
				<td style="width: 230px; height: 40px; padding: 5px; border: 1px solid #fff; border-radius: 5px; display:flex; flex:1; flex-direction: row; justify-content: flex-end;">
					<select name="searchType" style="margin-right:5px;">
						<option value="subject">제목</option>
						<option value="tag">태그</option>
					</select>
					<input type="text" name="keyword" size="10" style="margin-right:5px;">
					<input class="btn" type="submit" name="submit" value="검색">
				</td>
			</tr>
		</tbody>	
	</table>
</form>
<!-- 검색기능 끝 -->

<% 
if(alist == null && keyword == null){
	out.println("작성된 글이 존재하지 않습니다.");
	
}

%>

<%for (RvVo rv: alist) {%>
<table border="1" class="content">
	<tbody>
		<tr>
			<td style="text-align:left;"><a href="<%=request.getContextPath()%>/board2/rvView.do2?ridx=<%=rv.getRidx()%>"><%=rv.getSubject()%><br><%=rv.getContent() %></a></td>
			<td rowspan="2" style="width:150px; height:200px;"><%=rv.getFilename() %></td>
		</tr>
		<tr>
			<td style="text-align:left; height:60px; width:540px;">
			별점:<%=rv.getStar() %> <%=rv.getWriter().substring(0,1) %>**님<br>
			<a href="<%=request.getContextPath() %>/board2/rvList.do2??page=<%=pm.getStartPage()-1%>&keyword=<%=rv.getTag()%>&searchType=tag<%=rv.getTag() %>"><%=rv.getTag() %></a>
			</td>
		</tr>
	</tbody>
</table>
<br>
<%} %>
<table class="content">
	<tbody>
		<tr>
			<td><a href="<%=request.getContextPath()%>/board2/rvwrite.do2">리뷰작성하기</a></td>
		</tr>
	</tbody>
</table>
<!-- 게시판 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; border-bottom: none;">
		<td style="width:200px; text-align:right;">
		<%
		
		
		if(pm.isPrev() == true)
			out.println("<a href='"+request.getContextPath()+"/board2/rvList.do2?page="+(pm.getStartPage()-1)+"&keyword="+keyword+"&searchType="+searchType+"'>◀</a>");
		%>
		</td>
		<td>
		<%
		for(int i = pm.getStartPage(); i<=pm.getEndPage(); i++){
			out.println("<a href='"+request.getContextPath()+"/board2/rvList.do2?page="+i+"&keyword="+keyword+"&searchType="+searchType+"'>"+"["+i+"]"+"</a>");
			
		}
		
		%>
		</td>
		<td style="width:200px; text-align:left;">
		<%
		if(pm.isNext()&&pm.getEndPage() > 0){
			out.println("<a href='"+request.getContextPath()+"/board2/rvList.do2?page="+(pm.getEndPage()+1)+"&keyword="+keyword+"&searchType="+searchType+"'>▶</a>");
		}
		 %>
		</td>
	</tr>
</table>
<!-- 게시판 페이징 끝 -->
<% %>
</body>
</html>