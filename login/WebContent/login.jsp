<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
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
	<SECTION class="login-form">
	<h1>LOGIN</h1>
	<hr>
	<form action="" class="">
	<fieldset>
		<div class="int-area">
			<input type="text" name="id" id="id" autocomplete="off" placeholder="id : Allow up to 12 digit" style="text-align:center;" required>
			<label for="id">USER NAME</label>
		</div>
	
		<hr>
	
		<div class="int-area">
			<input type="password" name="password" id="password" autocomplete="off" placeholder="pwd : Allow up to 12 digit" style="text-align:center; width: 160px;" required >
			<label for="passsword">USER PASSWORD</label>
		</div>
		<hr>
		<div class="btn-area">
			<button type="submit" onclick="main.jsp">LOGIN</button> &nbsp; &nbsp;<button type="submit" id="join_btn" onclick="location.href='member/member_frorm.jsp">JOIN</button>
		</div>
		</form>
		<div class="caption">
		<br>
			<a href="">Forgot Password?</a> &nbsp; &nbsp; &nbsp;<a href="main.jsp">ExiT?</a>
		</div>
		</fieldset>
		</SECTION>
	
</body>
</html>