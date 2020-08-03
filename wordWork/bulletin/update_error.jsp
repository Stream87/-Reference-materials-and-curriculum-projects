<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정실패</title>
</head>
<body>

	<c:set var="excep" value="${exception.getClass().simpleName}" />
	<c:choose>
		<c:when test="${excep == 'ArticleNotFoundException'}">
	수정할 게시글이 존재하지 않습니다.
	</c:when>
		<c:when test="${excep == 'InvalidPasswordException'}">
		 암호를 잘못 입력하셨습니다.
		 </c:when>
	</c:choose>

</body>
</html>

