<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// 자바영역에서 세션에 URI를 저장해서 로그인 시 다시 돌아오게 함 
session.setAttribute("saveUrl", request.getRequestURI()); %>

<c:if test="${sessionScope.midx eq null}">
	<script>
		alert("유효하지 않은 접근입니다. 로그인을 해주세요");location.href="${pageContext.request.contextPath}/member2/Login.do2"
	</script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>리뷰 작성페이지</title>
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
	
	if(fm.tag.value==""){
		alert("태그를 선택해주세요.")
		fm.tag.focus();
		return;
	}else if (fm.subject.value==""){
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
	}else if(fm.star.value==""){
		alert("별점을 선택해주세요.")
		fm.star.focus();
		return;
	}		
	
	alert("전송합니다.");
	//가상경로 사용
	fm.action = "${pageContext.request.contextPath}/board2/rvwriteAction.do2";
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

</script>
<body>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
<h1>리뷰 작성페이지</h1>
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
				<td style="padding-left:10px;"><input type="text" name="writer" value="${sessionScope.memberName}" readonly="readonly"></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td style="padding-left:10px;"><input type="file" name="filename"></td>
			</tr>
			<tr>
				<td>별점</td>
				<td style="padding-left:10px;">
				<select name="star">
					<option value="">선택해주세요</option>
					<option value="★★★★★">★★★★★</option>
					<option value="★★★★">★★★★</option>
					<option value="★★★">★★★</option>
					<option value="★★">★★</option>
					<option value="★">★</option>
				</select></td>
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