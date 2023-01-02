<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<style>
.reply__logo {
	width: 80px;
	padding-top: -1px;
}

.reply__toggle__style {
	color: #004b81;
	font-size: 20px;
}

.reply__toggle__style:hover {
	cursor: pointer;
	
}

.reply__con__margin {
	padding-bottom: 100px;
}

</style>


<div class='reply-info'>
	<div class='reply-count'>답글 ${dataCount}개</div>
</div>

<table class='table table-borderless'>
	
	<c:forEach var="vo" items="${listReply}">
		<tr class='border bg-light shadow '>
			<td width='50%'>
				<div class='row reply-writer'>
					<div class='col-1' style="margin-left: 10px; margin-right: 40px; margin-bottom: 10px; margin-top: 0px;"><img class="reply__logo" src="${pageContext.request.contextPath}/resources/images/admin_img_3.png"></div>
					<div class='col-auto align-self-center'>
						<div class='name' style="font-family: 'line_font_b'; font-size: 17px;">${vo.name}</div>
						<div class='date'>${vo.comreplydate}</div>
					</div>
				</div>
			</td>
			<td width='50%' align='right' class='align-middle'>
				<div class='dropdown'>
					<i class="bi bi-three-dots-vertical reply__toggle__style" data-bs-toggle="dropdown" aria-expanded="false"></i>
					<c:if test="${sessionScope.member.memberNo==vo.memberNo}">
						<ul class="dropdown-menu">
							<li class="dropdown-item updaprofile__project__detailte__detail update__detail" data-pd_code="${vo.comreplyNo}" onclick="deleteReply('${vo.comreplyNo}', '${vo.companyNo}')">댓글 삭제</li>
						</ul>
					</c:if>
					
				</div>
			</td>
		</tr>
		<tr >
			<td colspan='2' valign='top' style="padding-top: 20px; padding-bottom: 50px;" >${vo.comreplycontent}</td>
		</tr>
	</c:forEach>
	
</table>

