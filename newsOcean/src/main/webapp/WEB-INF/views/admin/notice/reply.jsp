<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<div class='reply-info'>
	<span class='reply-count'>답글 ${dataCount}개</span>
	<span>[목록, ${pageNo}/${total_page} 페이지]</span>
</div>

<table class='table table-borderless'>
	
	
	<c:forEach var="vo" items="${listReply}">
		<tr class='border bg-light'>
			<td width='50%'>
				<div class='row reply-writer'>
					<div class='col-1'><i class='bi bi-person-circle text-muted icon'></i></div>
					<div class='col-auto align-self-center'>
						<div class='name'>${vo.name}</div>
						<div class='date'>${vo.comreplydate}</div>
					</div>
				</div>
			</td>
			<td width='50%' align='right' class='align-middle'>
				<span class='reply-dropdown'><i class='bi bi-three-dots-vertical'></i></span>
				<div class="reply-menu">
					<c:choose>
						<c:when test="${sessionScope.member.memberNo==vo.memberNo}">
							<div class='deleteReply reply-menu-item' data-replyNum='${vo.comreplyNo}' data-pageNo='${pageNo}'>삭제</div>
							<div class='hideReply reply-menu-item'>숨김</div>
						</c:when>
						<c:when test="${sessionScope.member.memberNo==vo.memberNo}">
							<div class='deleteReply reply-menu-item' data-replyNum='${vo.comreplyNo}' data-pageNo='${pageNo}'>삭제</div>
							<div class='blockReply reply-menu-item'>차단</div>
						</c:when>
						<c:otherwise>
							<div class='notifyReply reply-menu-item'>신고</div>
							<div class='blockReply reply-menu-item'>차단</div>
						</c:otherwise>
					</c:choose>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan='2' valign='top'>${vo.comreplycontent}</td>
		</tr>
	</c:forEach>
	
		
</table>

<div class='page-navigation'>
	${paging_re}
</div>	