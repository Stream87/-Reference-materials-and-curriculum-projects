<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.GalleryBoardDTO"%>
<%@ page import="mvc.model.GalleryRippleDTO"%>
<%

	String sessionId = (String) session.getAttribute("sessionId");
	String sessionName = (String) session.getAttribute("sessionName");

	GalleryBoardDTO board = (GalleryBoardDTO) request.getAttribute("galleryboard");		
	List rippleList = (List) request.getAttribute("ripplelist");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int pageNum = ((Integer) request.getAttribute("page")).intValue();
%>
<html>
<head>
<title>GalleryBoard</title>
<script type="text/javascript">	
	 function View_Image(name)
	 {
		   window.open("c:/upload/" + name, name, "left=200,top=200,width=450,height=550,scrollbars=yes,resizable=yes");
		   
	 }
</script>
</head>
<body>
	<jsp:include page="../menu.jsp" />
	<div class="jumbotron">
		<div class="container" >
			<h1 class="display-4">갤러리</h1>
		</div>	
	</div>
			
	<div class="container">		

	<legend>등록글 확인</legend>		
		 <div class="alert alert-danger" role="alert">	
		 <table width="100%">
				<tr>
					<td align="left">제목 :  <%= board.getSubject() %> </td>
					<td align="right"> 성명 :   <%= board.getName() %> </td>		
						<c:if test='<%= board.getId().equals(sessionId) %>'> 
					 <td align="right"> <a href='./GalleryBoardDeleteAction.do?num=<%=num %>&pageNum=<%=pageNum %>' class="badge badge-danger"> 삭제 </a>
					 <a href='./GalleryBoardUpdateForm.do?num=<%=num %>&pageNum=<%=pageNum %>' class="badge badge-success"> 수정 </a> </td>
					 </c:if>						
				</tr>
				
			</table>	
			
         </div>	  
       <div class="row" >
           <div class="col-md-3" >
		      <div style="padding-left: 50px">
	             <c:if test="<%= board.getFilename()!=null %>" ><img src="c:/upload/<%=board.getFilename() %>" width="60%"></c:if>
	          </div>
         	</div>
          <div class="col-md-8" >
         	   	<c:if test="<%= board.getFilename()!=null%>" ><img src="<c:url value="/resources/images/file.gif"/>" border=0> 
	        		<a href="javascript:View_Image('<%= board.getFilename() %>');"><%=board.getFilename() %>(<%=board.getFilesize()%>)</a>
	        	</c:if>
	            <div style="padding-top: 20px">
				    <p><%= board.getContent() %></p>
				</div>
         </div>	   
       </div> 
     <div class="row" style="padding-top: 50px">	
			<table class="table table-hover">		
			 
			<%
			
			for (int j = 0; j < rippleList.size(); j++) {
				GalleryRippleDTO ripple = (GalleryRippleDTO) rippleList.get(j);
			%>
					   			 	 
	   		<tr >
			<td style="padding-left: 20px"><%= ripple.getName() %>  </td>							
			<td ><%= ripple.getContent() %> </td>					
			<td align="right"><%= ripple.getRegist_day() %>
				<c:if test='<%= ripple.getId().equals(sessionId) %>'> 
						<a href='./GalleryRippleDeleteAction.do?num=<%=num %>&pageNum=<%=pageNum %>&rippleNum=<%=ripple.getNum()%>' class="badge badge-danger"> 삭제 </a>
				</c:if>		 
			</td>
			</tr> 						
			<%
		 }
			%>
	
		</table>		
	   </div>
	</div>
	</div>
	
	<div class="container">
	  <div class="row">	
		<form  name="newWrite" class="form-horizontal"   action="./GalleryRippleWriteAction.do?num=<%=num %>&pageNum=<%=pageNum %>"  method="post">					
			<div class="form-group">
			<input type=hidden name="id" value="<%=sessionId %>">
			<input type=hidden name="name" value="<%=sessionName %>">
				<label class="col-sm-2 control-label" for="name">이름 : </label>				
					<%=board.getName() %>
							
				</div>							
			<div class="form-group">					
					<div class="col-sm-12">	
					<table>
					<tr>
					<td>
						<textarea id="content" name="content" cols="200" rows = "5" class="form-control" placeholder="content"></textarea>
					</td>	
					<c:if test="${not empty sessionId}">
          	 		<td> 
          				&nbsp;&nbsp;<input type=submit  class="btn btn-primary" value="등록">
					</td>
			 		</c:if>
			 			
				</tr>
				 </table>	
			</div>		
				</div>
		</form >			
	</div>
	</div>	
	
		  <div align=center>				
				<a href="./GalleryBoardListAction.do?pageNum=<%=pageNum%>" class="btn btn-primary"> 목록</a></p>	
			</div>
			
	 </div>	
</div>	



