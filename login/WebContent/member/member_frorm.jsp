<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="">
<title>Insert title here</title>
</head>
<body>

<h2>SIGN_UP</h2>
<hr>
<form action="regist.member" method="post">
<fieldset>
	<input type="hidden" name="command" value="confirm" /> 
	<br>
	&nbsp; &nbsp; I D &nbsp; &nbsp; &nbsp; &nbsp;: <input type="text" name="id" style="text-align:center;" placeholder="Allow up to 12 digit" autocomplete="off"  required/><br>
	<br>
	&nbsp; Password: <input type="text" name="password"  style="text-align:center; width:160px;" placeholder="Allow up to 12 digit" autocomplete="off" required/><br>
	<br>
	YourName: <input type="text" name="name" placeholder="Use Eng or Kor" style="text-align:center" autocomplete="off" required/><br>
	<br>
	&nbsp; E - mail@: <input type="email" name="email" placeholder="E-mail to be exact" style="text-align:center" autocomplete="off" required/><br>
	<br>
	<input type="submit" value="register"/> &nbsp; &nbsp; &nbsp;<a href="http://localhost:8080/PProject/main.jsp">EXIT</a>
</form>
</fieldset>
<small>Your information won't be revealed.</small>


</body>
</html>