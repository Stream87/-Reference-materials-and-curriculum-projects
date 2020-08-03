<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>답변 작성 실패</title>
</head>
<body>

${exception.getMessasge()}<br><br>
<a href="list.jsp">목록보기</a>
</body>
</html>