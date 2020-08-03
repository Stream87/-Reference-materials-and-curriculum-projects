<%@page import="bean.Article"%>
<%@page import="service.ArticleReadService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
 	 <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />	
		
		
<script type="text/javascript">
function check(){

var str = document.getElementById('check');

 if( str.value == '' || str.value == null ){
    alert( '작성자를 입력해주세요' );
    return false;
}

var blank_pattern = /^\s+|\s+$/g;
if( str.value.replace( blank_pattern, '' ) == "" ){
    alert('공백만 입력되었습니다 ');
    return false;
}

 

//공백 금지
//var blank_pattern = /^\s+|\s+$/g;(/\s/g
var blank_pattern = /[\s]/g;
if( blank_pattern.test( str.value) == true){
    alert(' 공백은 사용할 수 없습니다. ');
    return false;
}


var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;

if( special_pattern.test(str.value) == true ){
    alert('특수문자는 사용할 수 없습니다.');
    return false;
}

alert( '최종 : ' + str.value );

/*
if( str.value.search(/\W|\s/g) > -1 ){
    alert( '특수문자 또는 공백을 입력할 수 없습니다.' );
    str.focus();
    return false;
}*/

}
</script>

</head>
<body>
<%
	int parentId= Integer.parseInt(request.getParameter("parentId"));
	ArticleReadService service = ArticleReadService.getInstance();
	Article parent = service.readArticle(parentId, false);
%>

		<div class="jumbotron jumbotron-fluid">
  <div class="container">
    <h1 class="display-3" align="center">Reply</h1>
</div>
</div>
		
	<div class="write-form">
		<nav class="navbar navbar-light bg-light">
<c:set var="parent" value="<%=parent%>" />
	
<form align="center" id="check" action="reply.jsp" method="post" >
		<input type="hidden" name="parentId" value="${param.parentId}" >
		<input type="hidden" name="page" value="${param.page}">
		
		제목  &nbsp; &nbsp; <input class="form-control mr-sm-2" type="text" name="title" size="20" value="re:${parent.title}">
		작성자  <input class="form-control mr-sm-2" type="text" name="writerName" onsubmit="return check()" required="required">
		글암호  <input class="form-control mr-sm-2" type="password" name="password" onsubmit="return check()" required="required">
		글 내용 
		<textarea class="form-control mr-sm-2" rows="5" cols="40" name="content" placeholder="내용을 기입하세요">
		&#13;&#13;RE:=================&#13;${parent.content} </textarea>
		<br><input class="btn btn-success" type="submit" value="전송">
	</form>
		</nav>
	<div>
		<div class="jumbotron jumbotron-fluid">
  <div class="container">
    <h1 class="display-3" align="center">답변을 입력해주세요.</h1>
</div>
</div>
</body>
</html>