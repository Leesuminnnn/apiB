<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>문의내역게시판</title>
<style>

*{
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	box-sizing: border-box;
	color: #000000;
	}
.wap{
	margin: 0 50px;
}
.container{
	text-align: center;
	margin: 0 auto;
	margin-top: 50px;
	position:relative;
	right: 350px;
}

.container div{
	display: inline-block;
}
.content{
	text-align:center;
	margin: 0 auto;
}

.contentlist{

}
.user{
	margin-right: 10px;
	text-align: right;
}

.dv{
	text-align: right;
	
}	
.dv div{
	display: inline-block;
}
.title div{
	display: inline-block;
}
.title{
	text-align: center;
	margin: 0 auto;
}
h1, .list{
	text-align:center;
}

.list{
	margin: 0 auto;
}

.sch{
	margin: 0 auto;
	width: 690px;
	margin-top: 20px;
}

tr{
	height: 40px;
}

a:hover{
	color: #a828a8;
}
.btn{
	cursor: pointer;
	padding: 5px;
}
p{
	text-align: left;
	font-weight: bold;
}
</style>
<script>
	
</script>
</head>
<body>
<div class="wap">
<div class="user">	
	<div>관리자페이지ㅣ로그아웃</div>
</div>
<h1>문의내역게시판</h1>
<hr>


<div class="container">
	<div>총 **개의 고객문의</div>
</div>
<nav>
<p>회원관리</p>
<ul>
	<li><a href="#">&nbsp;사용자</a></li>
	<li><a href="#">&nbsp;관리자</a></li>
	
</ul>
<p>컨텐츠관리</p>
<ul>
	<li><a href="#">&nbsp;문의내역</a></li>
	<li><a href="">&nbsp;견적내역</a></li>
</ul>
</nav>
<section>
<table border="1" class="content">
	<tbody>
		<tr>
			<td>고객고유번호</td>
			<td>제목</td>
			<td>작성일</td>
			<td>상태</td>
		</tr>
		<tr>
			<td>4</td>
			<td>답변해주세요</td>
			<td>22-05-11</td>
			<td>대기중</td>
		</tr>
		<tr>
			<td>3</td>
			<td>답변해주세요</td>
			<td>22-05-11</td>
			<td>답변완료</td>
		</tr>
	</tbody>
</table>


<table style="width:600px; height:25px; text-align:center; margin:0 auto;">
	<tr style="border-top:none; border-bottom: none;">
		<td>
		◀ <strong>[1]</strong> [2] [3] [4] [5] [6] [7] [8] [9] [10] ▶
		</td>
	</tr>
</table>
</section>
</div>

</body>
</html>