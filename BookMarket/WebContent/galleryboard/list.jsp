<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%@ page import="mvc.model.GalleryBoardDTO"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	List boardList = (List) request.getAttribute("boardlist");
	int total_record = ((Integer) request.getAttribute("total_record")).intValue();
	int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<html>
<head>
<title>GalleryBoard</title>
<script type="text/javascript">
	function checkForm() {
	
		if (${sessionId==null}) {
			alert("로그인 해주세요.");
			return false;
		}

		location.href = "./GalleryBoardWriteForm.do?id=<%=sessionId%>";
	}
	 function View_Image(name)
	 {
		   window.open("c:/upload/" + name, name, "left=200,top=200,width=450,height=550,scrollbars=yes,resizable=yes");
		   
	 }
</script>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">갤러리</h1>
		</div>
	</div>
	<div class="container">
		<form action="<c:url value="./GalleryBoardListAction.do"/>" method="post">
			<div>
				<div class="text-right">
					<span class="badge badge-success">전체 <%=total_record%>건	</span>
				</div>
			</div>			
			<div class="row" align="center" style="padding-top: 50px">
			<%
				for (int j = 0; j < boardList.size(); j++) {
					GalleryBoardDTO board = (GalleryBoardDTO) boardList.get(j);
			%>
				<div class="col-md-3">
					<a href="javascript:View_Image('<%=board.getFilename() %>');"><img src="c:/upload/<%=board.getFilename() %>" style="width: 60%"></a><br>
					<a href="./GalleryBoardViewAction.do?num=<%=board.getNum()%>&pageNum=<%=pageNum%>"><%=board.getSubject()%></a>	
					<c:if test='<%= board.getRipple_count()!=0 %>'> 
						<font color=blue> [<%= board.getRipple_count() %>]</font>
					</c:if>	
				</div>
			<%
			}
			%>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%=pageNum%>" />
				<c:forEach var="i" begin="1" end="<%=total_page%>">
					<a href="<c:url value="./GalleryBoardListAction.do?pageNum=${i}" /> ">
						<c:choose>
							<c:when test="${pageNum==i}">
								<font color='4C5317'><b> [${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'> [${i}]</font>

							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>
			<div align="left">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp; 
						<select name="items" class="txt">
								<option value="subject">제목에서</option>
								<option value="content">본문에서</option>
								<option value="name">글쓴이에서</option>
						</select> <input name="text" type="text" /> <input type="submit"
							id="btnAdd" class="btn btn-primary " value="검색 " />
						</td>
						<td width="100%" align="right">
							<a href="#" onclick="checkForm(); return false;" class="btn btn-primary">&laquo;글쓰기</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>





