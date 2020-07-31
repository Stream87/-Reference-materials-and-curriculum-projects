<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 입력화면</title>
</head>
<body>

	<form action="write.jsp" method="post">
		제목 : <input type="text" name="title" size="20" ><br>
		작성자 : <input type="text" name="writerName" value="강용"><br>
		글암호 : <input type="password" name="password" value="1234"> <br>
		글 내용 : <br>
		<textarea rows="5" cols="40" name="content"> 연습. 하하</textarea>
		<br><input type="submit" value="전송">
	
	</form>


</body>
</html>