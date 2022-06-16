<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.google.gson.Gson, com.google.gson.JsonObject" %>
<%@ page import="single.domain.*" %>
<%@ page import="single.service.*" %>
<%@ page import="single.dbconn.*" %>
<%@ page import="java.util.*" %>
<%
	MemberVo mv = (MemberVo)request.getAttribute("mv");
%>

<%
	//Gson을 이용한 JSON 데이터 처리
	//https://mvnrepository.com/artifact/com.google.code.gson/gson에서 
	//jar파일 다운로드 및 WEB-INF/lib폴더에 추가
	
	request.setCharacterEncoding("UTF-8");
	String receivedId = (String)request.getParameter("userid");
	
	Gson gson = new Gson();		//Gson 객체 생성
	JsonObject obj = new JsonObject();	//Json 객체 생성
	
	if("admin".equals(receivedId)){
		
		obj.addProperty("flag", "Y");
	}else{
		
		obj.addProperty("flag", "N");
	}
	out.println(gson.toJson(obj));
	
	
%>