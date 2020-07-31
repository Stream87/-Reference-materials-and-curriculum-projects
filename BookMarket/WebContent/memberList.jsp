<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<title>회원 목록</title>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">회원 목록</h1>
		</div>
	</div>
	<div class="container">		
		<sql:setDataSource var="dataSource" url="jdbc:mysql://localhost:3306/BookMarketDB"
				driver="com.mysql.jdbc.Driver" user="root" password="1234" />
		<sql:query var="resultSet" dataSource="${dataSource}">
				select * from member
		</sql:query>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>메일</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>가입일</th>
					<th>비고</th>
				</tr>				
				<c:forEach var="row" items="${resultSet.rows}">
				<tr>				
				<td> <c:out value="${row.id}" /></td>
				<td> <c:out value="${row.name}" /></td>
				<td> <c:out value="${row.mail}" /></td>
				<td> <c:out value="${row.phone}" /></td>
				<td> <c:out value="${row.address}" /></td>
				<td> <c:out value="${row.regist_day}" /></td>
				<td><a href="./detailMember.jsp?id=<c:out value="${row.id}" />" class="btn btn-secondary btn-sm">상세보기</a> 
				</td>						
				</tr>				
				</c:forEach>
			</table>	
		</div>
		<hr>
	</div>
	<jsp:include page="/footer.jsp" />
</body>
</html>