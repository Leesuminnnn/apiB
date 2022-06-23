<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.CtnVo" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// 자바영역에서 세션에 URI를 저장해서 로그인 시 다시 돌아오게 함 
session.setAttribute("saveUrl", request.getRequestURI()); %>
<c:if test="${sessionScope.midx eq null}">
	<script>alert("로그인을 해주세요.");javascript:history.back();</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>시공사례 수정하기</title>
</head>
<style>
	
</style>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
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
	if (confirm("수정끝?") == true){    //확인

	    document.frm.submit();

		}else{   //취소
			
	    	return;		
		}
	//가상경로 사용
 	fm.action = "${pageContext.request.contextPath}/board2/ctnmodifyAction.do2";
	fm.enctype = "multipart/form-data";
	fm.method = "post";
	fm.submit();
	
	return;
} */
// ajax를 이용한 유효성 검사
$("#frm").on('submit' , function(){
	
	var subject = $("#subject").val();
	var content = $("#content").val();
	var writer = $("#writer").val();
	var tag = $("#tag").val();
	
	if(subject == ''){
		alert("제목을 입력해주세요");
		$("#subject").focus();
		return false;
	}else if(content == ''){
		alert("내용을 입력해주세요");
		$("#content").focus();
		return false;
	}else if(writer == ''){
		alert("작성자를 확인해주세요");
		$("writer").focus();
		return false;
	}else if(tag == ''){
		alert("태그를 선택해주세요");
		$("tag").focus();
		return false;
	}
	
});



</script>
<body>

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
	<h1>게시판 글수정하기</h1>
	<br>
	<form name="frm" action="${pageContext.request.contextPath}/board2/ctnmodifyAction.do2" method="post" enctype="multipart/form-data">
	<input type="hidden" name="cidx" value="${cv.cidx }">
		<table border=1 class="content">
			<tr>
				<td>태그 선택</td>
				<td style="padding-left:10px; text-align:left;">
				<select name="tag">
					<option value="">선택</option>
					<option value="maru">마루</option>
					<option value="lighting">조명</option>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width: 180px; height: 40px;">제목</td>
				<td style="padding-left: 10px; text-align:left;"><input type="text" name="subject" id="subject" value="${cv.subject }"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="padding: 10px; text-align:left;"><textarea name="content" id="content" placeholder="내 용">${cv.content }</textarea></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="padding-left:10px; text-align:left;"><input type="text" name="writer" id="writer" placeholder="작성자" value="${sessionScope.memberName }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td style="padding: 10px; text-align:left;"><input type="file" name="filetype" id="filetype"></td>
			</tr>
			<tr style="text-align: center;" >
				<td colspan=2 style="padding-top:5px; padding-bottom:5px;">
					<input type="submit" id="check" name="check" value="확인" onclick="check();">
					<input type="button" value="취소" onclick="history.back();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>