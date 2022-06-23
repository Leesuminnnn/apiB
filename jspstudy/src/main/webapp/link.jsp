<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="single.dbconn.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--  로그인 탭 -->
<div class="user_wrap" style="display:flex;">
	<strong style="font-size:1.5rem;">
		<a href="${pageContext.request.contextPath}/board2/index2.do2">logo</a>
	</strong>
	
	<!-- 탭메뉴 -->
	<div class="title" style="text-align: left; margin-bottom: 20px;">
		<div style="display: inline-block;">
			<div><a href="${pageContext.request.contextPath}/board2/ctn.do2">시공사례</a></div>ㅣ
			<div><a href="${pageContext.request.contextPath}/board2/rvList.do2">고객후기</a></div>ㅣ
			<div><a href="${pageContext.request.contextPath}/board2/estimatewrite.do2">견적신청</a></div>ㅣ
			<div><a href="${pageContext.request.contextPath}/board2/help.do2">고객센터</a></div>
		</div>	
	</div>
	<!-- 탭메뉴 끝 -->
	<div class="user" style="margin-right: 10px;text-align: right;">	
	<c:choose>
		<c:when test="${sessionScope.midx ne null}">
			${sessionScope.memberName}(${sessionScope.memberId})님 안녕하세요<br>
			<a href="${pageContext.request.contextPath}/member2/Logout.do2">로그아웃</a>
			<!-- 만약 이름이 관리자 이면 관리자 계정으로 로그인한다 -->
				<c:choose>
					<c:when test="${sessionScope.memberName eq '관리자'}">
						<a href="${pageContext.request.contextPath}/board2/admin.do2">관리자페이지</a><br>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/member2/memberMyPage.do2?midx=${sessionScope.midx}">마이페이지</a><br>
					</c:otherwise>
				</c:choose>
		</c:when>
		<c:otherwise>
			<div><a href="${pageContext.request.contextPath}/member2/memberJoin.do2">회원가입</a>ㅣ<a href="${pageContext.request.contextPath}/member2/Login.do2">로그인</a></div>
			<div>로그인을 해주세요</div>
		</c:otherwise>
	</c:choose>
	 </div>
</div>
 <!-- 로그인 탭 끝 -->



