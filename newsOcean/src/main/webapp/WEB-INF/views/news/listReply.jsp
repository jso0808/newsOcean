<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class='reply-info'>
	<span class='reply-count'>댓글 ${replyCount}개</span>
	<span>[목록, ${pageNo}/${total_page} 페이지]</span>
</div>

<table class='table table-borderless'>
	<c:forEach var="vo" items="${listReply}">
	<c:if test="">  </c:if>
		<tr class='border bg-light'>
			<td width='50%'>
				<div class='row reply-writer'>
					<div class='col-1'><i class='bi bi-person-circle text-muted icon' id="replyUserIcon" data-memberNo="${vo.memberNo}"></i></div>
					
					<div class='col-auto align-self-center'>
						<div class='nickName'>${vo.nickName}</div>
						<div class='date'>${vo.regDate}</div>
					</div>
				</div>
			</td>
			<td width='50%' align='right' class='align-middle'>
				<span class='reply-dropdown'><i class='bi bi-three-dots-vertical'></i></span>
				<div class="reply-menu">
					<c:choose>
						<c:when test="${sessionScope.member.memberNo==vo.memberNo}">
							<div class='deleteReply reply-menu-item' data-replyNo='${vo.replyNo}' data-pageNo='${pageNo}'>삭제</div>
						</c:when>
						<c:when test="${sessionScope.member.memberShip > 50}">
							<div class='replyShowHide reply-menu-item' data-replyNo='${vo.replyNo}' data-showHide='${vo.showHide}' data-pageNo='${pageNo}'>${vo.showHide == 0 ? "숨김":"표시"}</div>
							<div class='deleteReply reply-menu-item reply-menu-item' data-replyNo='${vo.replyNo}' data-pageNo='${pageNo}'>삭제(관리자용)</div>
						</c:when>
						<c:otherwise>
							<div class='complainReply reply-menu-item' data-replyNo='${vo.replyNo}'>신고</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div align='right'>
					<div class="divReplyLikeCount">
						<button type='button' class='btn btn-light btnSendReplyLike' data-replyNo='${vo.replyNo}' data-replyLike='1' title="좋아요"><i class="${vo.userReplyLiked==1 ? 'fa-solid':'fa-regular'} fa-heart"></i> 
							<span id="likeCountReply">${vo.likeCount}</span>
						</button>
					</div>
				</div>
			</td>
		</tr>
		
		<tr>
			<td colspan='2' valign='top' class="td-content ${vo.showHide == -1 ? 'text-primary text-opacity-50':''}">${vo.content}</td>
		</tr>
	
	</c:forEach>
</table>

<div class="page-navigation">
	${paging}
</div>			
