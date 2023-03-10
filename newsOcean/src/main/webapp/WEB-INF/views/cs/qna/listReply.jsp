<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="vo" items="${listReply}">
	<div class='border-bottom m-1'>
		<div class='row p-1'>
			<div class='col-auto'>
				<div class='row reply-writer'>
					<div class='col-1'><i class='bi bi-person-circle text-muted icon'></i></div>
					<div class='col ms-2 align-self-center'>
						<div class='name'>${vo.nickName}</div>
						<div class='date'>${vo.qnaARegdate}</div>
					</div>
				</div>
			</div>
			<div class='col align-self-center text-end'>
				<span class='reply-dropdown'><i class='bi bi-three-dots-vertical'></i></span>
				<div class='reply-menu'>
					<c:choose>
						<c:when test="${sessionScope.member.memberNo==vo.memberNo}">
							<div class='deleteReply reply-menu-item' data-qnaAnswer='${vo.qnaAnswer}' data-qnaReply='${vo.qnaReply}'>삭제</div>
						</c:when>
						<c:when test="${sessionScope.member.memberShip > 50 }">
							<div class='deleteReply reply-menu-item' data-qnaAnswer='${vo.qnaAnswer}' data-qnaReply='${vo.qnaReply}'>삭제</div>
							<div class='blockReply reply-menu-item'>차단</div>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
		
		<div class='p-2 ${vo.showReply == 0 ? "text-primary text-opacity-50":""}'>
			${vo.qnaAContent}
		</div>
	</div>
</c:forEach>
