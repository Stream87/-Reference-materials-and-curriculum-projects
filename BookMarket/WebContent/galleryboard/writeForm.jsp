<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	String sessionName = (String) session.getAttribute("sessionName");
%>


<html>
<head>
<title>GalleryBoard</title>
</head>
<script type="text/javascript">
	function checkForm() {
		if (!document.newWrite.name.value) {
			alert("성명을 입력하세요.");
			return false;
		}
		if (!document.newWrite.subject.value) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (!document.newWrite.content.value) {
			alert("내용을 입력하세요.");
			return false;
		}		
	}
</script>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">갤러리</h1>
		</div>
	</div>

	<div class="container">

		<form name="newWrite" action="./GalleryBoardWriteAction.do"
			class="form-horizontal" method="post" onsubmit="return checkForm()"  enctype="multipart/form-data">
			<input name="id" type="hidden" class="form-control"
				value="${sessionId}">
			<div class="form-group row">
				<label class="col-sm-2 control-label" >성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" placeholder="name" readonly value="<%=sessionName %>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label" >제목</label>
				<div class="col-sm-5">

					<input name="subject" type="text" class="form-control"
						placeholder="subject">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label" >내용</label>
				<div class="col-sm-8">
					<textarea name="content" cols="50" rows="5" class="form-control"
						placeholder="content"></textarea>
				</div>
			</div>
			<div class="form-group row">
					<label class="col-sm-2 control-label" >첨부파일</label>
				<div class="col-sm-8">	
						<input type="file" name="fileImage" class="form-control" >
					</div>
			</div>
				
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
				 <input type="submit" class="btn btn-primary " value="등록 ">				
					 <input type="reset" class="btn btn-primary " value="취소 ">
				</div>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>



