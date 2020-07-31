<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 삭제 암호 묻는 페이지</title>
</head>
<body>
	<form action="delete.jsp" method="post">
		<input type="hidden" name="articleId" value="${param.articleId }">
		글 암호 :<input type="password" name="password"><Br>
		 <input type="submit" value="삭제">
	
	</form>
</body>
</html>