<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.CtnVo" %>

<% CtnVo cv =  (CtnVo)request.getAttribute("cv"); %>
<%

if(session.getAttribute("midx") == null){
	out.println("<script>alert('로그인을 해주세요');location.href='"+request.getContextPath()+"/member2/Login.do2'</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>시공사례 수정하기</title>
</head>
<style>
	
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
	fm.action = "<%=request.getContextPath()%>/board2/ctnmodifyAction.do2";
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
	<h1>게시판 글수정하기</h1>
	<br>
	<form name="frm">
	<input type="hidden" name="cidx" value="<%=cv.getCidx() %>">
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
				<td style="padding-left: 10px; text-align:left;"><input type="text" name="subject" value="<%=cv.getSubject() %>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="padding: 10px; text-align:left;"><textarea name="content" placeholder="내 용"><%=cv.getContent() %></textarea></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="padding-left:10px; text-align:left;"><input type="text" name="writer" placeholder="작성자" value="<%=session.getAttribute("memberName") %>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td style="padding: 10px; text-align:left;"><input type="file" name="filetype"></td>
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