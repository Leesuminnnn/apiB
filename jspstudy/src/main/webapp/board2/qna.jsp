<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>

<%
	ArrayList<QnaVo> alist = (ArrayList<QnaVo>)request.getAttribute("alist");
%>
<%	MemberVo mv = (MemberVo)request.getAttribute("mv"); %>
<% 
	
	PageMaker pm = (PageMaker)request.getAttribute("pm");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>QnA</title>
</head>
<style>
.content{
	text-align:center;
	margin: 0 auto;
	width:690px;
	text-align:left;
	}
</style>
<script>
	
</script>
</head>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<h1><a href="<%=request.getContextPath()%>/board2/qna.do2">QnA</a></h1>
<ul>
	<li><a href="<%=request.getContextPath()%>/board2/qna.do2">Q n A</a></li>
	<li><a href="<%=request.getContextPath()%>/board2/iqy.do2">1:1 문의</a></li>
</ul>
<!-- 게시판 리스트 검색기능 -->
<form name="frm" action="<%=request.getContextPath()%>/board2/qna.do2" method="post">
	<table class="sch">
	<tbody style="">
		<tr style="border-top: none; text-align:right; height: 25px; margin:0 auto;">
			<td style="width: 230px; "></td>
			<td style="width: 230px; "></td>
			<td style="width: 230px; height: 40px; padding: 5px; border: 1px solid #fff; border-radius: 5px; display:flex; flex:1; flex-direction: row; justify-content: flex-end;">
				<select name="searchType" style="margin-right:5px;">
					<option value="subject">제목</option>
				</select>
				<input type="text" name="keyword" size="10" style="margin-right:5px;">
				<input class="btn" type="submit" name="submit" value="검색">
			</td>
		</tr>
	</tbody>	
	</table>
</form>
<!-- 검색기능 끝 -->

<!-- Q n A -->


<table class="content" border=1>
	<tbody>
		<%for (QnaVo qv : alist) {%>
		
		<tr>
			<td>
			<!-- 답변형 게시판 -->
		<%for (int i =1; i<= qv.getLevel_(); i++){
			out.println("&nbsp;&nbsp;");
			if(i == qv.getLevel_()){
				out.println("A :");
				
			}
			
		} %>
			<a href="<%=request.getContextPath()%>/board2/qnaView.do2?qidx=<%=qv.getQidx()%>"><%=qv.getSubject() %>
			</a>
			</td>
		</tr>
		
		<% }%>
		<tr>
			<td>
				<div class="dv">
					<!-- 회원은 작성하지 못하고 관리자만 작성할 수 있게 만들기 -->
					<%if(session.getAttribute("midx")!=null){ %>
					<div style="text-align:right;"><a href="<%=request.getContextPath()%>/board2/qnawrite.do2">글쓰기</a></div>
					<% }else{%>
					<div></div>
					<%} %>
				</div>
			</td>
		</tr>
		
	</tbody>	
</table>

<!-- Q n A 끝 -->

<!-- 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; 
	border-bottom: none;">
		<td style="width:200px; text-align:right;">
		<%
		
		String keyword = pm.getScri().getKeyword();
		
		String searchType = pm.getScri().getSearchType();
		
		if(pm.isPrev() == true)
			out.println("<a href='"+request.getContextPath()+"/board2/qna.do2?page="+(pm.getStartPage()-1)+"&keyword="+keyword+"&searchType="+searchType+"'>◀</a>");
		%>
		</td>
		<td>
		<%
		for(int i = pm.getStartPage(); i<=pm.getEndPage(); i++){
			out.println("<a href='"+request.getContextPath()+"/board2/qna.do2?page="+i+"&keyword="+keyword+"&searchType="+searchType+"'>"+"["+i+"]"+"</a>");
			
		}
		
		%>
		</td>
		<td style="width:200px; text-align:left;">
		<%
		if(pm.isNext()&&pm.getEndPage() > 0){
			out.println("<a href='"+request.getContextPath()+"/board2/qna.do2?page="+(pm.getEndPage()+1)+"&keyword="+keyword+"&searchType="+searchType+"'>▶</a>");
		}
		 %>
		</td>
	</tr>
</table>

<!-- 페이징끝 -->
</body>
</html>