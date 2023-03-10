<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- 본문 -->

<table class="table-mypage ">
	<tbody>					
			<tr>
				<td class="admin__list__title">계정 </td>
				<td class="admin__list__title">이름</td>
				<td class="admin__list__title">최근 접속일</td>
				<td class="admin__list__title">정보 수정일</td>
				<td class="admin__list__title">계정 상태</td>
			</tr>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr>
				<td class="admin__list__content_email" onclick="loginchange()">${dto.email} </td>
				<td class="admin__list__content">${dto.name} </td>
				<td class="admin__list__content2">${dto.recentdate}</td>
				<td class="admin__list__content2">${dto.modifydate}</td>
				<input type="hidden" id="admin_memberNo" value="${dto.memberNo}">
				<td class="admin__list__content__state " onclick="updateAdmin();" style="cursor: pointer;">관리자 삭제</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
 