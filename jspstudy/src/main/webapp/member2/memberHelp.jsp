<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>ID / PW 찾기</TITLE>
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
	</script>
	</HEAD>

	<BODY>
		<center><h1>ID/PW찾기</h1></center>
		<br>
		<form name="frm">
			<table style="text-align:left; width:400px; height:300px">
				<tr style="text-align:center;">
					<td><input type="radio" name="lgn-hp" value="idhp" checked>ID찾기</td>
					<td><input type="radio" name="lgn-hp" value="pwhp">PW찾기</td>
				</tr>
				<tr>
					<td colspan=2>가입할때 등록했던 이름과 휴대폰번호를 입력해주세요</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text"></td>
				</tr>
				<tr>
					<td>휴대폰번호</td>
					<td><input type="text"></td>
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
