<%@page import="service.ArticleWriteService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="article" class="bean.Article"/>
<jsp:setProperty property="*" name="article"/>
<%
	ArticleWriteService service = ArticleWriteService.getInstance();
	int articleId = service.write(article);
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성 완료</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/writeform.css" />

</head>
<body>

<div class="jumbotron" >
  <h1 class="display-3">게시글을 등록하였습니다</h1>
  <p class="lead">등록된 글은 수정 가능합니다. 단 비밀번호를 잊지마세요.</p>
  <hr class="my-2">
  <p>목록 또는 게시글 읽기</p>
  <p class="lead">
    <a class="btn btn-outline-primary" href="list.jsp" role="button">[목록으로]</a>
    <a class="btn btn-outline-primary" href="read.jsp?articleId=<%=articleId%>" role="button">[게시글 읽기]</a>
  </p>
</div>

</body>
</html>