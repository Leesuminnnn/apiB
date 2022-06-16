<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jspstudy.domain.BoardVo" %>
<%@ page import="java.util.*" %>
<% BoardVo bv =  (BoardVo)request.getAttribute("bv"); %>	<!-- 강제 형변환 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내용보기</title>
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
</style>

</head>
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
	<form name="frm">
	<h1>글 내용 보기</h1>
	<br>
		<table border=1>
			<tr>
				<td style="width: 180px; height: 40px;">제목(<%=bv.getWriteday().substring(5,10) %>)</td>
				<td><%=bv.getSubject() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 500px; height: 300px; vertical-align:top;">
				<%=bv.getContent() %>
				<%
				
				
				%>
				
				<br><img src="<%=request.getContextPath()%>/images/<%=bv.getFilename()%>">
				<br><a href="<%=request.getContextPath()%>/board/fileDownload.do?filename=<%=bv.getFilename()%>"><%=bv.getFilename()%></a>
				</td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td><%=bv.getWriter() %></td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<input type="button" name="modipy" value="수정" onclick="location.href='<%=request.getContextPath() %>/board/boardModify.do?bidx=<%=bv.getBidx()%>'">
					<input type="button" name="delete" value="삭제" onclick="location.href='<%=request.getContextPath() %>/board/boardDelete.do?bidx=<%=bv.getBidx()%>'">
					<input type="button" name="Reply" value="답변" onclick="location.href='<%=request.getContextPath() %>/board/boardReply.do?bidx=<%=bv.getBidx()%>&originbidx=<%=bv.getOriginbidx() %>&depth=<%=bv.getDepth() %>&level_=<%=bv.getLevel_() %>'">
					<input type="button" name="list" value="목록" onclick="location.href='<%=request.getContextPath() %>/board/boardList.do'">
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>