<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="row board-list-header">
	<div class="col-auto me-auto">
    	${dataCount}개(${pageNo}/${total_page} 페이지)
    </div>
    <div class="col-auto">&nbsp;</div>
</div>

<!-- 본문 -->
<table class="table table-hover board-list">
	<thead class="table-light">
		<tr>
			<th class="bw-60">번호</th>
			<th>제목</th>
			<th class="bw-100">작성자</th>
			<th class="bw-100">작성일</th>
			<th class="bw-70">조회수</th>
			<th class="bw-50">파일</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="dto" items="${noticeList}">
			<tr>
				<td><span class="badge bg-primary">공지</span></td>
				<td class="left">
					<a href="javascript:articleBoard('${dto.companyNo}', '${pageNo}');" class="text-reset">${dto.companySubject}</a>
				</td>
				<td>${dto.name} </td>
				<td>${dto.companyDate}</td>
				<td>${dto.companyHitcount}</td>
				<td>
					<c:if test="${dto.fileCount != 0}">
						<a href="${pageContext.request.contextPath}/notice/zipdownload?companyNo=${dto.companyNo}" class="text-reset">📥</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
							
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr>
				<td>${dataCount - (page-1) * size - status.index}</td>
				<td class="left">
					<a href="javascript:articleBoard('${dto.companyNo}', '${pageNo}');" class="text-reset">${dto.companySubject}<span class="new__tag"> &nbsp; ${dto.gap <= 3 ? "✨NEW✨": ""}</span></a>
				</td>
				<td>${dto.name} </td>
				<td>${dto.companyDate}</td>
				<td>${dto.companyHitcount}</td>
				<td>
					<c:if test="${dto.fileCount != 0}">
						<a href="${pageContext.request.contextPath}/admin/notice/zipdownload?companyNo=${dto.companyNo}" class="text-reset">📥</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="page-navigation">
	${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>
