<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.*" %>
<%@ page import="java.util.*" %>
<% 
	ArrayList<BoardVo> alist = (ArrayList<BoardVo>)request.getAttribute("alist");
	PageMaker pm = (PageMaker)request.getAttribute("pm");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>boardList</title>
</head>
<style>
*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
	color: #000000;
	}
.dv{
	text-align: right;
	margin-bottom: 20px;
	display: flex;
	display: flex;
	flex-wrap: wrap;
	flex-direction: row; /*수평 정렬*/
	align-items: center;
	justify-content: space-between;
}

.dv div{
	display: inline-block;
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
	border-bottom: 1px solid #ccc;
}

.list tr:first-child{
	border-top: 3px solid #505050;
}
.list tr:last-child{
	border-bottom: none;
}
a:hover{
	color: #a828a8;
}
.btn{
	cursor: pointer;
	padding: 5px;
}
input, select{
	border-radius: 5px;
	border:1px solid;
	height: 30px;
	outline-color: #787878;
}	
input:focus, select:focus{
	outline-color: #646464;
}
	
</style>
<body>
<div style="text-align:right;">
<%
if(session.getAttribute("midx") != null){
	out.println("회원아이디:" +session.getAttribute("memberId"));
	out.println("회원이름:" +session.getAttribute("memberName"));
	
	out.println("<a href='"+request.getContextPath()+"/member/memberLogout.do'>로그아웃</a>"+"<br>");
}

%>
</div>
<h1><a onClick="window.location.reload()">게시판 리스트</a></h1>
<!-- 게시판 리스트 검색기능 -->
<form name="frm" action="<%=request.getContextPath()%>/board/boardList.do" method="post">
	<table class="sch">
	<tbody style="">
		<tr style="border-top: none; text-align:right; height: 25px;">
			<td style="width: 230px; "></td>
			<td style="width: 230px; "></td>
			<td style="width: 230px; height: 40px; padding: 5px; border: 1px solid #fff; border-radius: 5px; display:flex; flex:1; flex-direction: row; justify-content: flex-end;">
				<select name="searchType" style="margin-right:5px;">
					<option value="subject">제목</option>
					<option value="writer">작성자</option>
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

<table class="list">
	<tr>
		<td style="width:80px;">글번호</td>
		<td style="width:310px;">제목</td>
		<td style="width:150px;">작성자</td>
		<td style="width:150px;">작성일</td>
	</tr>
	<%for (BoardVo bv : alist ) {%>
	<tr>
		<td><%=bv.getBidx() %></td>
		
		<td style="text-align:left;">
		<!-- 답변형 게시판 -->
		<%for (int i =1; i<= bv.getLevel_(); i++){
			out.println("&nbsp;&nbsp;");
			if(i == bv.getLevel_()){
				out.println("ㄴ");
				
			}
			
		} %>
		<a href="<%=request.getContextPath() %>/board/boardContent.do?bidx=<%=bv.getBidx() %>"><%=bv.getSubject() %></a>
		
		</td>
		
		<td><%=bv.getWriter() %></td>
		<td><%=bv.getWriteday().substring(5,10) %></td>
	</tr>
	<% }%>
	<tr>
		<td colspan=4>
			<div class="dv">
				<div><a style="text-align:left;" href="<%=request.getContextPath() %>/board/boardWrite.do">게시판 글쓰기</a></div>
				<div><a href="../index.jsp">메인화면</a></div>
			</div>
		</td>
	</tr>
	
		
</table>
<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; 
	border-bottom: none;">
		<td style="width:200px; text-align:right;">
		<%
		
		String keyword = pm.getScri().getKeyword();
		
		String searchType = pm.getScri().getSearchType();
		
		if(pm.isPrev() == true)
			out.println("<a href='"+request.getContextPath()+"/board/boardList.do?page="+(pm.getStartPage()-1)+"&keyword="+keyword+"&searchType="+searchType+"'>◀</a>");
		%>
		</td>
		<td>
		<%
		for(int i = pm.getStartPage(); i<=pm.getEndPage(); i++){
			out.println("<a href='"+request.getContextPath()+"/board/boardList.do?page="+i+"&keyword="+keyword+"&searchType="+searchType+"'>"+i+"</a>");
			
		}
		
		%>
		</td>
		<td style="width:200px; text-align:left;">
		<%
		if(pm.isNext()&&pm.getEndPage() > 0){
			out.println("<a href='"+request.getContextPath()+"/board/boardList.do?page="+(pm.getEndPage()+1)+"&keyword="+keyword+"&searchType="+searchType+"'>▶</a>");
		}
		 %>
		</td>
	</tr>
</table>

</body>
</html>