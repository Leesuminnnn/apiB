<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// 자바영역에서 세션에 URI를 저장해서 로그인 시 다시 돌아오게 함 
session.setAttribute("saveUrl", request.getRequestURI()); %>

<c:if test="${sessionScope.midx eq null }">
	<script type="text/javascript">
		alert("잘못된 접근입니다. 로그인을 해주세요");location.href="${pageContext.request.contextPath}/member2/Login.do2"
	</script>
</c:if>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="text/css" rel="stylesheet" href="boardcss.css">
	<TITLE>견적신청</TITLE>
	<style>

	table{
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;		
	vertical-align: middle; /*글자 중앙정렬*/	
	}
	
	tr{
	border-bottom: 1px solid #aaaaaa;
	height: 50px;
	vertical-align: middle;
	}
		
	tr:last-child{
	border-bottom: none;
	}
		
	</style>
	<script>
	function check(){
//		alert("테스트");
		var fm = document.frm;
		
		if(fm.writer.value ==""){
			alert("이름을 입력하세요");
			fm.writer.focus();
			return;
		}else if(fm.memberphone.value ==""){
			alert("연락처를 입력하세요");
			fm.memberphone.focus();
			return;
		}else if(fm.place.value ==""){
			alert("지역을 선택하세요");
			fm.place.focus();
			return;
		}else if(fm.esdays.value ==""){
			alert("희망 공사일을 선택해주세요");
			fm.esdays.focus();
			return;			
		}
		
		
		alert("전송합니다.");
		//가상경로 사용
		fm.action = "${pageContext.request.contextPath}/board2/estimatewriteAction.do2";
		fm.enctype = "multipart/form-data";
		fm.method = "post";
		fm.submit();
		
		return;
		
	}
	//돌아가기를 누르면
	/*
	function fg(){
		var fm = document.frm;
		
		alert("메인화면으로 돌아갑니다.");
		fm.action = "../mainindex.jsp";
		fm.method = "post";
		fm.submit();
		
		return;
	}
	*/
	function fg(){						
		var fm = document.frm;
		if (confirm("메인화면으로 돌아갑니다.") == true){    //확인

	    document.frm.submit();

		}else{   //취소
			
	    	return;		
		}
		fm.action = "${pageContext.request.contextPath}/board2/index2.do2";
		fm.method = "post";
		fm.submit();
		return;	
	}
	</script>
	</HEAD>

	<BODY>
<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
		<h1>견적신청하기</h1>
		<br>
		<form name="frm">
			<table style="text-align:left; width:400px; height:300px">
				<tr>
					<td>이름</td>
					<td><input type="text" name="writer" value="${sessionScope.memberName}" readonly="readonly"></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="text" name="memberphone" value="${sessionScope.memberPhone}"></td>
				</tr>
					<!-- ul li로 지역 선택할 수 있게 만들기 -->	
				<tr>
					<td>지역</td>
					<td>
						<select name="place">
							<option value="">선택하세요</option>
							<option value="전주">전주</option>
							<option value="익산">익산</option>
							<option value="군산">군산</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>희망 공사일</td>
					<td>
						<select name="esdays" style="width:100px; height:25px">
							<option value="">희망 공사일</option>
							<option value="1개월 내">1개월 내</option>
							<option value="2~3개월 내">2~3개월 내</option>
							<option value="4개월 내">4개월 내</option>
							<option value="5개월 이후">5개월 이후</option>
							<option value="미정">미정</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="button" class="btn" value="확인" onclick="check();"> 					
						<input type="button" class="btn" value="돌아가기" onclick="fg();">
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
