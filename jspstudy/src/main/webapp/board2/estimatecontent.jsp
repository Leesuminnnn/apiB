<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<% EstmVo ev =  (EstmVo)request.getAttribute("ev"); %>	<!-- 강제 형변환 -->

<% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="boardcss.css">
<title>내용보기</title>
<style>

</style>
<script>


function back(){
	var fm = document.frm;

	//alert("취소");
	fm.action = "<%=request.getContextPath() %>/board2/estimatelist.do2";
	fm.method = "post";
	fm.submit();
}
</script>
</head>
<body>
	<div class="wrap">
<%if(session.getAttribute("memberName")!=("관리자")){
		out.println("<script>alert(잘못된 접근입니다.);javascript:history.back() </script>");
		}
	 %>

<!-- 공통nav -->
<jsp:include page="/link.jsp"/>
<!-- 공통nav끝 -->
	<form name="frm">
	<h1>견적 내용 보기</h1>
	<br>
	<!-- 메뉴 -->
	<nav>
		<p>회원관리</p>
		<ul>
			<li><a href="userInfo.jsp">&nbsp;사용자</a></li>
			
		</ul>
		<p>컨텐츠관리</p>
		<ul>
			<li><a href="<%=request.getContextPath()%>/board2/iqylist.do2">&nbsp;문의내역</a></li>
			<li><a href="<%=request.getContextPath()%>/board2/estimatelist.do2">&nbsp;견적내역</a></li>
		</ul>
	</nav>
	
		<table border=1 class="content">
			<tr>
				<td style="width: 150px; height: 40px;">이름</td>
				<td style="width: 180px; height: 40px;"><%=ev.getWriter() %></td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">지역</td>
				<td><%=ev.getPlace() %></td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">휴대폰 번호</td>
				<td><%=ev.getMemberphone() %></td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">희망공사일</td>
				<td><%=ev.getEsdays() %></td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">작성일</td>
				<td><%=ev.getWriteday().substring(5,10) %></td>
			</tr>
			<tr>
				<td style="width: 150px; height: 40px;">상태</td>
				<td><%=ev.getChecked() %></td>
			</tr>
			<tr>
			<!-- 만약 처리된 상태라면 처리버튼 숨기기 -->
				<td colspan="2" style="padding-top:5px; padding-bottom:5px; text-align:center;">
					<% %><input type="button" name="select" value="처리" onclick="location.href='<%=request.getContextPath()%>/board2/estimatepm.do2?eidx=<%=ev.getEidx()%>'">
					<% %>
					<input type="button" name="prev" value="돌아가기" onclick="back();">
				</td>
			</tr>
		</table>	
	</form>
	</div>
</body>
</html>