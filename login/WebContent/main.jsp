<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="">
<title>main</title>
<script>
window.onload = function(){
	var btn = document.getElementById("join_btn");
	btn.onclick = function(){
		location.replace("regist.member?command=member_form");
	};
};
</script>
</head>
<body>
		<hr>
	<h6>	메인화면이다요		</h6>
		<br>
		<div>
		<input type="button" style="WIDTH: 60pt; HEIGHT: 60pt" value="회원가입" id="join_btn" onclick="location.href='member/member_frorm.jsp'"/>
		</div>
	
		<div>
		<input type="button" style="WIDTH: 60pt; HEIGHT: 60pt" value="게시판" onclick="location.href ='main.jsp'"/>
	</div>	
		<div>
		<input type="button" style="WIDTH: 60pt; HEIGHT: 60pt" value="로그인" onclick="location.href ='login.jsp'"/>
</div>
		<div>
		<input type="button" style="WIDTH: 60pt; HEIGHT: 60pt" value="???" onclick="location.href ='login.jsp'"/>
</div>
</body>
</html>