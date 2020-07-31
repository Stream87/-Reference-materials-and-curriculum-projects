<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>
table {
	text-align: center;
}

.seq {
	font-size: 20px;
	color: red;
}

.title {
	text-align: left;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>

</head>
<body>

	<table border="1">
		<c:if test="${articlePage.totalPageCount > 0 }">
			<tr>
				<td colspan="8">${articlePage.startRow} - ${articlePage.endRow}
					[${articlePage.requestPage}/${articlePage.totalPageCount}]</td>
			</tr>
		</c:if>

		<tr>
			<td>글번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
			<td>groupNum</td>
			<td>seqNum</td>
			<td>GroupLevel</td>
		</tr>
		<c:choose>
			<c:when test="${articlePage.hasArticle == false }">

				<tr>
					<td colspan="8">게시글이 없습니다.</td>
				</tr>
			</c:when>

			<c:otherwise>

				<c:forEach var="article" items="${articlePage.articleList}">
					<tr>
						<td>${article.id}</td>
						<td class="title"><c:if test="${article.lv > 0 }">
								<c:forEach begin="1" end="${article.lv}">-</c:forEach>&gt;
							</c:if> 
								
									<c:set var="query"
										value="articleId=${article.id}&page=${articlePage.requestPage}" />
									<a href="<c:url value="/read.jsp?${query}"/>">
										${article.title } </a>
								
								
								<!--
								<c:choose> 
								<c:when test="${article.deleted==false}"> 
								</c:when>
								
								<c:otherwise>
									원본글이 삭제되었습니다. 
								</c:otherwise>
								</c:choose>
								-->
								
							</td>
						<td>${article.writerName}</td>
						<td>${article.postingDate}</td>
						<td>${article.readCount}</td>

						<td>${article.grp}
						<td class="seq"><b>${article.seq}</b></td>
						<td><b>${ article.lv} </b></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="8"><c:if test="${articlePage.beginPage > 10 }">
							<a
								href="<c:url value="/list.jsp?page=${articlePage.beginPage-1}" />">이전</a>
						</c:if> <c:forEach var="pno" begin="${articlePage.beginPage}"
							end="${articlePage.endPage}">
							<a href="<c:url value="/list.jsp?page=${pno}" />">[${pno}]</a>
						</c:forEach> <c:if test="${articlePage.endPage < articlePage.totalPageCount}">
							<a
								href="<c:url value="/list.jsp?page=${articlePage.endPage+1}" />">다음</a>
						</c:if></td>
				</tr>
			</c:otherwise>
		</c:choose>
		<tr>
			<td colspan="8"><a href="writeForm.jsp">글쓰기</a> , begin페이지
				${articlePage.beginPage}엔드페이지 ${articlePage.endPage} 다음 페이지
				${articlePage.totalPageCount }</td>
		</tr>
	</table>
</body>
</html>