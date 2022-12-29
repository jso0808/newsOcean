<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.info__st {
	background: #fff;
	border-radius: 15px;
	width: 300px;
}
</style>

<!-- 본문 -->

<div class="title__member__det"> ${dto.name} 님의 회원정보 🙋‍♀️ </div>

<table class="table-mypage text-center info__st shadow-sm">
	<tbody>	
			<tr style="margin-bottom: -20px;">
				<td>
					<img class="profile__size__member " src="${pageContext.request.contextPath}/resources/images/admin_img.png">	
				</td>
			</tr>
			<tr class="email__design">
				<td><span class="info__title">이메일 |</span> ${dto.email} </td>
			</tr>
			<tr>
				<td><span class="info__title">가입일 | </span>${dto.joindate}</td>
			</tr>
			<tr>
				<td><span class="info__title">구독권 |</span> ${dto.subtype}</td>
			</tr>
			<tr>
				<td>
					<span class="btn-mypage" onclick="updateEnabled('${dto.memberNo}', '${dto.enabled}');" style="cursor: pointer;">계정 상태 변경</span>
			<input type="hidden" value="${dto.enabled}" name="enabled" id="enabled">
				</td>
			</tr>

	</tbody>
	
	
</table>
 