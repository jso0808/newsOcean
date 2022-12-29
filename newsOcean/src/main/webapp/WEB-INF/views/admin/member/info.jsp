<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>

</style>

<!-- 본문 -->

<div class="title__member__det"> ${dto.name} 님의 회원정보 🌊 </div>

<table class="table-mypage text-center info__st shadow-sm">
	<tbody>	
			<tr style="margin-bottom: -20px;">
				<td>
					<c:if test="${dto.gender=='F'}">
						<img class="profile__size__member " src="${pageContext.request.contextPath}/resources/images/member_img.png">	
					</c:if>
					<c:if test="${dto.gender=='M'}">
						<img class="profile__size__member " src="${pageContext.request.contextPath}/resources/images/member_img2.png">	
					</c:if>
				</td>
			</tr>
			<tr class="email__design">
				<td><span class="info__title">이메일 |</span> ${dto.email} </td>
			</tr>
			<tr>
				<td><span class="info__title">가입일 | </span>${dto.joindate}</td>
			</tr>
			<tr>
				<td><span class="info__title">구독 |</span>
					<c:if test="${dto.subtype == '12'}">
						<span style="font-family: 'line_font_b'; color: red;">&nbsp;1년권 구독중&nbsp;</span>
					</c:if>	
					<c:if test="${dto.subtype == '1'}">
						<span style="font-family: 'line_font_b'; color: red;">&nbsp;1개월 구독중&nbsp;</span>
					</c:if>	
					<c:if test="${dto.subtype == '0'}">
						<span style="font-family: 'line_font_b';">구독 없음</span>
					</c:if>
				 
				 </td>
			</tr>
			<tr>
				<td>
					<span class="btn-mypage" onclick="updateEnabled('${dto.memberNo}', '${dto.enabled}');" style="cursor: pointer;">계정 상태 변경</span>
			<input type="hidden" value="${dto.enabled}" name="enabled" id="enabled">
				</td>
			</tr>

	</tbody>
	
	
</table>
 