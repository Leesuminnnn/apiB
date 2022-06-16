<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.BoardVo" %>

<% BoardVo bv =  (BoardVo)request.getAttribute("bv"); %>
<%

if(session.getAttribute("midx") == null){
	out.println("<script>alert('로그인을 해주세요');location.href='"+request.getContextPath()+"/member/memberLogin.do'</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 수정하기</title>
</head>
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
	
	textarea{
	width: 500px;
	height: 300px;
	resize: none; 
	}
	
	input[type=text]{
	width: 200px;
	height: 25px;
	}
	
	input[type=button]{
	padding: 5px;
	cursor: pointer;
	border-radius: 10px;
	border: 1px solid #bdbdbd;
	background: #fafafa;
	font-size: 12px;
} 
</style>
<script>
function check(){
//	alert("테스트입니다.")
	var fm = document.frm;
	
	if (fm.subject.value==""){
		alert("제목을 입력하세요.");
		fm.subject.focus();
		return;
	}else if(fm.content.value==""){
		alert("내용을 입력하세요.")
		fm.content.focus();
		return;
	}else if(fm.writer.value==""){
		alert("작성자를 입력하세요.")
		fm.writer.focus();
		return;
	}	
	if (confirm("수정끝?") == true){    //확인

	    document.frm.submit();

		}else{   //취소
			
	    	return;		
		}
	//가상경로 사용
	fm.action = "<%=request.getContextPath()%>/board/boardModifyAction.do";
	fm.method = "post";
	fm.submit();
	
	return;
	
}


function prev(){
	
	var fm = document.frm;
	
	fm.action = "javascript:history.back();";
	fm.method = "post";
	fm.submit();
	
	return;
}

</script>
<body>
	<h1>게시판 글수정하기</h1>
	<br>
	<form name="frm">
	<input type="hidden" name="bidx" value="<%=bv.getBidx() %>">
		<table border=1>
			<tr>
				
				<td style="width: 180px; height: 40px;">제목</td>
				<td style="padding-left: 10px;"><input type="text" name="subject" value="<%=bv.getSubject() %>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="padding: 10px;"><textarea name="content" placeholder="내 용"><%=bv.getContent() %></textarea></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="padding-left:10px;"><input type="text" name="writer" placeholder="작성자" value="<%=session.getAttribute("memberName") %>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td style="padding: 10px;"><input type="file" name="filetype"></td>
			</tr>
			<tr style="text-align: center;" >
				<td colspan=2 style="padding-top:5px; padding-bottom:5px;">
					<input type="button" value="확인" onclick="check();">
					<input type="button" value="취소" onclick="prev();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>