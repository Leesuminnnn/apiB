<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>    

<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>시공사례 작성페이지</title>
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
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	}else if(fm.tag.value==""){
		alert("태그를 선택해주세요.")
		fm.tag.focus();
		return;
	}		
	alert("전송합니다.");
	//가상경로 사용
	fm.action = "<%=request.getContextPath()%>/board2/ctnwriteAction.do2";
	fm.enctype = "multipart/form-data";
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

function readURL(input){
	if (input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
		$('#preview')
		.attr('src',e.target.result);
		};
		reader.readAsDateURL(input.files[0]);	
	}
}

</script>
<body>

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->

<!-- 관리자만 접근 가능하게 만들기 -->
	<h1>시공사례 작성페이지</h1>
	<br>
	<form name="frm">
		<table border=1>
			<tr>
				<td>태그 선택</td>
				<td style="padding-left:10px;">
				<select name="tag">
					<option value="">선택</option>
					<option value="maru">마루</option>
					<option value="lighting">조명</option>
				</select>
				</td>
			</tr>
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
			<tr>
				<td>첨부파일</td>
				<td style="padding-left:10px;"><input type="file" name="filename" onchange="readURL(this);"><img id="preview"></td>
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