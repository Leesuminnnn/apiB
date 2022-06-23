<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.midx eq null}">
	<script>
		alert("잘못된 접근입니다. 로그인을 해주세요");location.href="${pageContext.request.contextPath}/member2/Login.do2"
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>Qna 수정하기</title>
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
	if (confirm("수정끝?") == true){    //확인

	    document.frm.submit();

		}else{   //취소
			
	    	return;		
		}
	//가상경로 사용
	fm.action = "${pageContext.request.contextPath}/board2/qnaModifyAction.do2";
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
	<h1>Qna 수정하기</h1>
	<br>
	<form name="frm">
	<input type="hidden" name="qidx" value="${qv.qidx}">
		<table border=1>
			<tr>
				<td style="width: 90px; height: 40px;">제목</td>
				<td style="padding-left: 10px; width: 510px;"><input type="text" name="subject" value="${qv.subject}"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="padding: 10px;"><textarea name="content" placeholder="내 용">${qv.content}</textarea></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="padding-left:10px;"><input type="text" name="writer" placeholder="작성자" value="${sessionScope.memberName}" readonly="readonly"></td>
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