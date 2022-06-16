<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.CtnVo" %>
<% CtnVo cv =  (CtnVo)request.getAttribute("cv"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글삭제하기</title>
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
		
		fm.action = "<%=request.getContextPath()%>/board2/ctndeleteAction.do2";
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
	<input type="hidden" name="cidx" value="<%=cv.getCidx() %>">
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