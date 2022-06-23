<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
<script type="text/javascript">

$(function(){
//	alert("test1");
	$("#frm").on('submit' , function(){
//		alert("test2");
		
		var tag = $("#tag").val();
		var subject = $("#subject").val();
		var content = $("#content").val();
		var writer = $("#writer").val();
		
		if(tag == ""){
			alert("태그를 선택해주세요");
			$("#tag").focus();
			return false;
		}else if(subject == ""){
			alert("제목을 입력해주세요");
			$("#subject").focus();
			return false;
		}else if(content == ""){
			alert("내용을 입력해주세요");
			$("#content").focus();
			return false;
		}else if(writer == ""){
			alert("작성자를 입력해주세요");
			$("#writer").focus();
			return false;
		}
	});

});
//자바스크립트 유효성 검사
/* 
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

	
	return;
	
} */

// ajax를 이용한 유효성 검사 실패

</script>
<body>

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->

<!-- 관리자만 접근 가능하게 만들기 -->
	<h1>시공사례 작성페이지</h1>
	<br>
	<form name="frm" id="frm" action="${pageContext.request.contextPath}/board2/ctnwriteAction.do2" enctype="multipart/form-data" method="post">
		<table border=1>
			<tr>
				<td>태그 선택</td>
				<td style="padding-left:10px;">
				<select name="tag" id="tag">
					<option value= "">선택</option>
					<option value="maru">마루</option>
					<option value="lighting">조명</option>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width: 90px; height: 40px;">제목</td>
				<td style="padding-left: 10px;"><input type="text" name="subject" id="subject" placeholder="제 목"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="padding: 10px;"><textarea name="content" id="content" placeholder="내 용"></textarea></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="padding-left:10px;"><input type="text" name="writer" id="writer" value="${sessionScope.memberName}" readonly="readonly"></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td style="padding-left:10px;"><input type="file" name="filename" id="file"></td>
			</tr>
			
			<tr style="text-align: center;" >
				<td colspan=2 style="padding-top:5px; padding-bottom:5px;">
					<input type="submit" value="확인" class="btn" id="ctnBtn" name="ctnBtn">
					<input type="button" value="취소" class="btn" onclick="history.back();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>