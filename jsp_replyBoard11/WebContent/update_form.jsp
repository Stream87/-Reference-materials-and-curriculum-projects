<%@page import="service.ArticleReadService"%>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	int articleId = Integer.parseInt(request.getParameter("articleId"));
    	Article article = ArticleReadService.getInstance().readArticle(articleId, false);
    	
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="update.jsp" method="post">
		<input type="hidden" name="articleId" value="<%=request.getParameter("articleId") %>">
		<input type="hidden" name="page" value="<%=request.getParameter("page") %>">
		
		제목 : <input type="text" name="title" size="20" value="<%=article.getTitle() %>" ><br>
		작성자 : <input type="text" name="writerName" ><br>
		글암호 : <input type="password" name="password"> <br>
		글 내용 : <br>
		<textarea rows="5" cols="40" name="content"> <%=article.getContent() %> </textarea>
		<br><input type="submit" value="전송">
	
	</form>
</body>
</html>