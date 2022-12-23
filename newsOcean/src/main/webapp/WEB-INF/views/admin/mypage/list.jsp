<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- 본문 -->
<div class="title-area shadow">
	<div class="title-area-text">
		관리자 계정 정보
	</div>
</div>

<table class="table-mypage text-center">
	<tbody>	
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr>
				<td>
				<c:if test="${dto.gender=='W'}">
					<img class="profile__size " src="${pageContext.request.contextPath}/resources/images/admin_img.png">
				</c:if>			
				<c:if test="${dto.gender=='M'}">
					<img class="profile__size " src="${pageContext.request.contextPath}/resources/images/admin_img2.png">
				</c:if>	
				</td>
			</tr>
			<tr class="email__design">
				<td>📧 ${dto.email} </td>
			</tr>
			<tr>
				<td>${dto.name} ( ${dto.nickName} )</td>
			</tr>
			<tr>
				<td>${dto.joindate}</td>
			</tr>
			<input type="hidden" value="${dto.memberNo}">
		
		<tr>
			<td>
				<button class="btn-mypage" onclick="updateForm('${dto.memberNo}');">관리자 정보 변경</button>
			</td>
		</tr>
		<tr>
			<td>
				<button class="btn-mypage2">비밀번호 변경하기</button>
			</td>
		</tr>
		</c:forEach>
	</tbody>
	
	
</table>
 