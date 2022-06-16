<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE> 회원가입 페이지 </TITLE>
	<style>
	*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	border-collapse: collapse;	
	box-sizing: border-box;
	}
	
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
	
	
	/* 마지막 tr에 border-bottom빼기
	
	tr:rast-child{
	border-bottom:none;
	}
	*/
		
	.btn{
	cursor: pointer;
	padding: 5px;
	}
	
	input, select{
	border-radius: 5px;
	border:1px solid;
	height: 30px;
	outline-color: #787878;
	}
	
	
	input:focus, select:focus{
	outline-color: #646464;
	}
	
	</style>
	<script>
	function check(){
//		alert("테스트입니다.")
		var fm = document.frm;
		
		if (fm.memberId.value==""){
			alert("아이디를 입력하세요.");
			fm.memberId.focus();
			return;
		}else if(fm.memberPwd.value==""){
			alert("비밀번호를 입력하세요.")
			fm.memberPwd.focus();
			return;
		}else if(fm.memberPwd2.value==""){
			alert("비밀번호 확인을 입력하세요.")
			fm.memberPwd2.focus();
			return;
		}else if(fm.memberPwd.value !==fm.memberPwd2.value){
			alert("비밀번호가 일치하지 않습니다.")
			fm.memberPwd2.value = "";
			fm.memberPwd2.focus();
			return;
		}else if(fm.memberName.value ==""){
			alert("이름을 입력하세요")
			fm.memberName.focus();
			return;
		}else if(fm.memberEmail.value ==""){
			alert("이메일을 입력하세요")
			fm.memberEmail.focus();
			return;
		}else if(fm.memberPhone.value ==""){
			alert("연락처를 입력하세요")
			fm.memberPhone.focus();
			return;
		}else if(fm.memberJumin.value ==""){
			alert("주민번호를 입력하세요")
			fm.memberJumin.focus();
			return;
		}else if(fm.memberAddr.value ==""){		//지역을 선택하지 않으면
			alert("지역을 선택해주세요")				
			fm.memberAddr.focus();
			return;			
		}else{					//취미(check box에 체크가 한개도 안되어있을때 지정)
			var flag = false;	//기본값 체크가 안된상태를 false로 지정
			
			for (var i = 0; i<fm.memberHobby.length; i++){	//배열을 반복해서
				if(fm.memberHobby[i].checked == true){		//각 배열 방에 값이 하나라도 있으면
					flag = true;
					break;									//break를 이용해 빠져나온다
				}
			}
			
			if(flag == false){								
				alert("취미를 한개 이상 선택해 주세요");
				return;
			}
			
			
		}
		
		
		
		alert("전송합니다.");
		//fm.action = "./memberjoinOk.jsp";
		//가상경로 사용
		fm.action = "<%=request.getContextPath()%>/member/memberJoinAction.do";
		fm.method = "post";
		fm.submit();
		
		return;
		
	}
	//다시작성을 누르면
	function rst(){						
		var fm = document.frm;
		if (confirm("다시 작성 하시겠습니까?") == true){    //확인

	    document.frm.submit();

		}else{   //취소
			
	    	return;		
		}
		fm.method = "post";
		fm.submit();
		return;	
	}
	//돌아가기를 누르면
	
	function fg(){
		var fm = document.frm;
		
		alert("메인화면으로 돌아갑니다.");
		fm.action = "../index.jsp";
		fm.method = "post";
		fm.submit();
		
		return;
	}
	
	</script>
	</HEAD>

	<BODY>
		<center><h1>회원가입</h1></center>
		<br>
		<form name="frm">
			<table style="text-align:left; width:400px; height:300px">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId" size="25" placeholder="아이디를 입력해주세요"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPwd" size="25" placeholder="비밀번호를 입력해주세요"></td>
				</tr>
				<tr>
					<td>비밀번호확인</td>
					<td><input type="password" name="memberPwd2" size="25" placeholder="비밀번호를 입력해주세요"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="memberName" size="25" placeholder="이름을 입력해주세요"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="memberEmail" size="25" placeholder="이메일을 입력해주세요"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<label><input type="radio" name ="memberGender" value="M" checked>남자</label>
						<label><input type="radio" name ="memberGender" value="F">여자</label>
					</td>
				</tr>
				<tr>
					<td>지역</td>
					<td>
						<select name="memberAddr" style="width:100px; height:25px">
							<option value="">지역선택</option>
							<option value="서울">서울</option>
							<option value="대전">대전</option>
							<option value="전주">전주</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
						<input type="text" name="memberPhone" size="25" maxlength="13" placeholder="010-0000-0000">
					</td>
				</tr>
				<tr>
					<td>주민번호</td>
					<td><input type="text" name="memberJumin" size="25" maxlength="14" placeholder="000000-0000000">	
					</td>
				</tr>
				
				<tr>
					<td>취미</td>
					<td>
						<label><input type="checkbox" name ="memberHobby" value="야구" checked>야구</label>
						<label><input type="checkbox" name ="memberHobby" value="축구">축구</label>
						<label><input type="checkbox" name ="memberHobby" value="농구">농구</label>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="button" class="btn" value="확인" onclick="check();"> 
						<input type="reset" class="btn" value="다시작성" onclick="rst();"> 						
						<input type="button" class="btn" value="돌아가기" onclick="fg();">
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
