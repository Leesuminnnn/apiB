<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// 자바영역에서 세션에 URI를 저장해서 로그인 시 다시 돌아오게 함 
session.setAttribute("saveUrl", request.getRequestURI()); %>

<c:if test="${sessionScope.midx eq null}">
	<script>
		alert("유효하지 않은 경로입니다. 로그인을 해주세요.");location.href='${pageContext.request.contextPath}/member2/memberLogin.do2'
	</script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 수정하기</title>
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
		fm.write.focus();
		return;
	}else if(fm.star.value==""){
		alert("별점을 선택해주세요.")
		fm.star.focus();
		return;
	}
	if (confirm("수정끝?") == true){    //확인

	    document.frm.submit();

		}else{   //취소
			
	    	return;		
		}
	//가상경로 사용
	fm.action = "${pageContext.request.contextPath}/board2/rvModifyAction.do2";
	fm.method = "post";
	fm.submit();
	
	
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
	<h1>리뷰 수정하기</h1>
	<br>
		<form name="frm">
		<input type="hidden" name="ridx" value="${rv.ridx}"/>
		<table border=1 class="content">
			<tr>
				<td style="width: 180px; height: 40px;">제목</td>
				<td style="padding-left: 10px;"><input type="text" name="subject" value="${rv.subject}"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="padding: 10px;"><textarea name="content" placeholder="내 용">${rv.content}</textarea></td>
			</tr>
			<tr>
				<td style="width: 70px; height: 40px;">작성자</td>
				<td style="padding-left:10px;"><input type="text" name="writer" placeholder="작성자" value="${sessionScope.memberName}" readonly="readonly"></td>
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