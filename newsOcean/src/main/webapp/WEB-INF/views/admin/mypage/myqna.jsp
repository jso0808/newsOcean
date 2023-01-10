<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="row board-list-header">
    <div class="col-auto">&nbsp;</div>
</div>

<!-- 본문 -->
<table class="table table-hover board-list">
	<thead class="">
		<tr class="admin__tr__design">
			<th class="bw-60">번호</th>
			<th>제목</th>
			<th class="bw-100">작성자</th>
			<th class="bw-100">작성일</th>
		</tr>
	</thead>
	
	<tbody>	
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr>
				<td>${dto.qnaNo}</td>
				<td class="left">
					<a href="${pageContext.request.contextPath}/cs/qna/article?qnaNo=${dto.qnaNo}&page=1">${dto.qnaacontent}</a>
				</td>
				<td>${dto.name} </td>
				<td>${dto.qnaaregdate}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="page-navigation">
	${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>
