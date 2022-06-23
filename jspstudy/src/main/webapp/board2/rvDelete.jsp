<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// 자바영역에서 세션에 URI를 저장해서 로그인 시 다시 돌아오게 함 
session.setAttribute("saveUrl", request.getRequestURI()); %>

<c:if test="${sessionScope.midx eq null }">
	<script>
		alert("유효하지 않은 접근입니다. 로그인을 해주세요");location.href="${pageContext.request.contextPath}/member2/Login.do2"
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Rv 삭제하기</title>
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
	text-align: center;
	}
	
	table{
	border-collapse: collapse;
	margin: 0 auto;
	text-align: center;
	width: 300px;
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
		var fm = document.frm
		
		fm.action = "${pageContext.request.contextPath}/board2/rvDeleteAction.do2";
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
<h1>글 삭제 페이지</h1>
	<form name="frm">
	<input type="hidden" name="ridx" value="${rv.ridx}">
		<table>
			<tr style="height:200px">
				<td>삭제하시겠습니까?</td>
			</tr>
			<tr>
				<td>
				<input type="button" name="" value="확인" onclick="check();">
				<input type="button" name="" value="취소" onclick="prev();">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>