<%@page import="bean.Article"%>
<%@page import="service.ArticleReadService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int parentId= Integer.parseInt(request.getParameter("parentId"));
	ArticleReadService service = ArticleReadService.getInstance();
	Article parent = service.readArticle(parentId, false);
%>
<c:set var="parent" value="<%=parent%>" />
<form action="reply.jsp" method="post">
		<input type="hidden" name="parentId" value="${param.parentId}" >
		<input type="hidden" name="page" value="${param.page}">
		
		제목 : <input type="text" name="title" size="20" value="re:${parent.title}"><br>
		작성자 : <input type="text" name="writerName" value="최강용"><br>
		글암호 : <input type="password" name="password" value="1234"> <br>
		글 내용 : <br>
		<textarea rows="5" cols="40" name="content">
		&#13;&#13;RE:=================&#13;${parent.content} </textarea>
		<br><input type="submit" value="전송">
	
	</form>
</body>
</html>