<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>    

<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<% IqyVo iv = (IqyVo)request.getAttribute("iv"); %>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>1:1문의 답변페이지</title>
</head>
<style>
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
		fm.write.focus();
		return;
	}		
	alert("전송합니다.");
	//가상경로 사용
	fm.action = "<%=request.getContextPath()%>/board2/iqyReplyAction.do2";
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

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->

<!-- 관리자만 접근 가능하게 만들기 -->
	<h1>1:1문의 답변 작성페이지</h1>
	<br>
	<form name="frm">
	<input type="hidden" name="iidx" value="<%=iv.getIidx() %>"> 
	<input type="hidden" name="originiidx" value="<%=iv.getOriginiidx() %>">
	<input type="hidden" name="depth" value="<%=iv.getDepth() %>">
	<input type="hidden" name="level_" value="<%=iv.getLevel_() %>">
	
	
		<table border=1>
			<tr>
				<td style="width: 90px; height: 40px;">제목</td>
				<td style="padding-left: 10px;"><input type="text" name="subject" placeholder="제 목"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="padding: 10px;"><textarea name="content" placeholder="내 용"></textarea></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="padding-left:10px;"><input type="text" name="writer" value="<%=session.getAttribute("memberName") %>" readonly="readonly"></td>
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