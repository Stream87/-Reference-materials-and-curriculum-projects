<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<SECTION class="con-confrim">
<fieldset>

 <legend><h2>회원 가입 정보</h2></legend>
<p>I D: ${param.id }</p>
 <p>Pwd: ${param.password }</p>
 <p>Name: ${param.name }</p>     
 <p>Email: ${param.email }</p>  
 <hr>
 <p><h1>A u Sure?</h1></p> 
</fieldset>
 <form action="regist.member" method="post">
 <input type="hidden" name="command" value="regist" >
 	<input type="hidden" name="id" value="${param.id }"/>
 	 	<input type="hidden" name="password" value="${param.password }"/>
 	 	<input type="hidden" name="name" value="${param.name }"/>
 	 	<input type="hidden" name="email" value="${param.email }"/>
 	 	<br>
 	<input type="submit" value="Click Regist" onclick="location.href ='main.jsp'">
 </form> 
</SECTION >

</body>
</html>