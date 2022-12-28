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
							<div class='deleteReplyAnswer reply-menu-item' data-qnaAnswer='${vo.qnaAnswer}' data-answer='${vo.answer}'>삭제</div>
						</c:when>
						<c:when test="${sessionScope.member.memberShip > 50 }">
							<div class='deleteReplyAnswer reply-menu-item' data-qnaAnswer='${vo.qnaAnswer}' data-answer='${vo.answer}'>삭제</div>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>

		<div class='p-2 ${vo.showReply == 0 ? "text-primary text-opacity-50":""}'>
			${vo.qnaAnswer}
		</div>
	</div>
</c:forEach>
