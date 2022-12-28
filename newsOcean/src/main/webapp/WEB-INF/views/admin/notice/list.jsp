<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- 본문 -->
<table class="table ">
	<thead class="notice__table__title text-center">
		<tr>
			<th class="">번호</th>
			<th>제목</th>
			<th class="">작성자</th>
			<th class="">작성일</th>
			<th class="">조회수</th>
			<th class="">파일</th>
		</tr>
	</thead>
	
	<tbody class="hover__st">
		<c:forEach var="dto" items="${noticeList}">
			<tr class="notice__content__style">
				<td class="text-center" style="margin-top: 7px;"><span class="notice__tag "><i class="fa-solid fa-circle-exclamation"></i></span></td>
				<td class="left">
					<a href="javascript:articleBoard('${dto.companyNo}', '${pageNo}');" class="text-reset" style="font-family: 'line_font_b';">${dto.companySubject}</a>
				</td>
				<td class="text-center">${dto.name} </td>
				<td class="text-center">${dto.companyDate}</td>
				<td class="text-center">${dto.companyHitcount}</td>
				<td class="text-center">
					<c:if test="${dto.fileCount != 0}">
						<a href="${pageContext.request.contextPath}/admin/notice/zipdownload?companyNo=${dto.companyNo}" class="text-reset"><i class="fa-solid fa-folder-open" style="color: #FFCC33;"></i></a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
							
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr>
				<td class="text-center">${dataCount - (page-1) * size - status.index}&nbsp;&nbsp;</td>
				<td class="left">
					<a href="javascript:articleBoard('${dto.companyNo}', '${pageNo}');" class="text-reset">${dto.companySubject}<span class="new__tag"> &nbsp; ${dto.gap <= 3 ? "<span class='new__t'>New</span>": ""}</span></a>
				</td>
				<td class="text-center">${dto.name} </td>
				<td class="text-center">${dto.companyDate}</td>
				<td class="text-center">${dto.companyHitcount}</td>
				<td class="text-center">
					<c:if test="${dto.fileCount != 0}">
						<a href="${pageContext.request.contextPath}/admin/notice/zipdownload?companyNo=${dto.companyNo}" class="text-reset"><i class="fa-solid fa-folder-open" style="color: #FFCC33;"></i></a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="page-navigation">
	${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>
