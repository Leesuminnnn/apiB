<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<%
	ArrayList<CtnVo> alist = (ArrayList<CtnVo>)request.getAttribute("alist");
%>
<% 
	PageMaker pm = (PageMaker)request.getAttribute("pm");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>시공사례</title>
<style>


*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
	color: #000000;
	}
.container{
	text-align: left;
	margin-bottom: 20px;
	margin-left: 600px;
	justify-content: space-between;
}

.container div{
		display: inline-block;
	}


h1, .list{
	text-align:center;
}

.list{
	margin: 0 auto;
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
.user{
	margin-right: 10px;
	text-align: right;
}

.sch{
	margin: 0 auto;
	width: 690px;
	margin-top: 20px;
}
.size{
	margin: 0 auto;
	width: 690px;
}
.content{
	text-align:center;
	margin: 0 auto;
	width:690px;
	text-align:center;
}
.content_gl{
	padding:5px 5px;
	margin: 0 auto;
}
.content_gl_content{
	width: 490px;
	last-botton:none;
	text-align: left;
	vertical-align:top;
	padding:10px;
	height: 160px;
}
.content_gl_tag{
	text-align: left;
	height:40px;
	padding:10px;
}
.content_gl_img{
	height:200px;
	width:200px;
	padding:5px;
}
<!-- 공통nav css -->
.title{
text-align: left;
margin: 0 auto;
margin-bottom: 20px;
}
.title div{
display: inline-block;
}
user_wrap{
	display: flex;
	flex-wrap: wrap;
	flex-direction: row; /*수평 정렬*/
	align-items: center;
	justify-content: space-between;
}
</style>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

</script>
</head>
<body>

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->

<!-- 게시판 리스트 검색기능 -->
<form name="frm" action="<%=request.getContextPath()%>/board2/ctn.do2" method="post">
	<table class="sch">
	<tbody style="">
		<tr style="border-top: none; text-align:right; height: 25px;">
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


<!-- 게시판 리스트 -->

<table class="content">
	<tbody>
		<%for (CtnVo cv : alist) {%>
		<tr>
			<td>
				<table border="1" class="content_gl">
					<tbody>
						<tr>
							<td class="content_gl_content">
							<a href="<%=request.getContextPath() %>/board2/ctnview.do2?cidx=<%=cv.getCidx() %>">
							<%=cv.getSubject() %></a>
							</td>
							<td rowspan="2" class="content_gl_img">
							<a href="<%=request.getContextPath() %>/board2/ctnview.do2?cidx=<%=cv.getCidx() %>">
							<%=cv.getFilename() %></a>
							</td>
						</tr>
						<tr>
							<td class="content_gl_tag">
							<a href="<%=request.getContextPath() %>/board2/ctn.do2?page=<%=pm.getStartPage()-1%>&keyword=<%=cv.getTag()%>&searchType=tag"><%=cv.getTag() %></a>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		
		<%} %>
		
		<!-- 글쓰기 권한은 관리자만 -->
		<tr>
			<td colspan=3 style="background-color:White; height: 50px; text-align:right;">
			<%
			if(session.getAttribute("memberName").equals("관리자")){
				out.println("<a href='"+request.getContextPath()+"/board2/ctnwrite.do2'>글쓰기</a>");
			}else{
				out.println("<a href='"+request.getContextPath()+"/board2/estimatewrite.do2'>견적신청</a>");
			}
			%>
			</td>
		</tr>
	</tbody>
</table>
<!-- 게시판리스트 끝 -->

<!-- 게시판 페이징 -->
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; 
	border-bottom: none;">
		<td style="width:200px; text-align:right;">
		<%
		
		String keyword = pm.getScri().getKeyword();
		
		String searchType = pm.getScri().getSearchType();
		
		if(pm.isPrev() == true)
			out.println("<a href='"+request.getContextPath()+"/board2/ctn.do2?page="+(pm.getStartPage()-1)+"&keyword="+keyword+"&searchType="+searchType+"'>◀</a>");
		%>
		</td>
		<td>
		<%
		for(int i = pm.getStartPage(); i<=pm.getEndPage(); i++){
			out.println("<a href='"+request.getContextPath()+"/board2/ctn.do2?page="+i+"&keyword="+keyword+"&searchType="+searchType+"'>"+"["+i+"]"+"</a>");
			
		}
		
		%>
		</td>
		<td style="width:200px; text-align:left;">
		<%
		if(pm.isNext()&&pm.getEndPage() > 0){
			out.println("<a href='"+request.getContextPath()+"/board2/ctn.do2?page="+(pm.getEndPage()+1)+"&keyword="+keyword+"&searchType="+searchType+"'>▶</a>");
		}
		 %>
		</td>
	</tr>
</table>
<!-- 게시판 페이징 끝 -->
</body>
</html>