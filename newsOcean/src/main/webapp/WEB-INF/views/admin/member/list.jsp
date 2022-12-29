<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="row">
	<div class="today__cnt__container shadow-sm row ">
		<div class="col">
			<div class="today__cnt__date">${sysdate}</div>
			<div class="today__cnt__title">오늘 가입자 수</div>
		</div>
		<div class="col">
			<div class="today__member__cnt">${todayCount}</div>
		</div>
	</div>
	
	<div class="today__cnt__container shadow-sm row side__by__side">
		<div class="col">
			<div class="today__cnt__date">${sysdate}</div>
			<div class="today__cnt__title">신규 유료 회원</div>
		</div>
		<div class="col">
			<div class="today__member__cnt">${todaySubCount}</div>
		</div>
	</div>
	
	<div class="today__cnt__container shadow-sm row side__by__left">
		<div class="col">
			<div class="today__cnt__date">${sysdate}</div>
			<div class="today__cnt__title">전체 회원 수</div>
		</div>
		<div class="col">
			<div class="today__member__cnt">${dataCount}</div>
		</div>
	</div>
	
</div>

<!-- 제목 -->
<div class="title__member">
	<span class="title-1">No</span>
	<span class="title-2">Basic info</span>
	<span class="title-3">MemberNo</span>
	<span class="title-4">Authority</span>
	<span class="title-5">JoinDate</span>
	<span class="title-6">Birth</span>
	
	<!-- 버튼 -->
	<span class="title-7">ENABLED</span>
	<span class="title-8">MEMBERSHIP</span>
</div>

<c:forEach var="dto" items="${list}" varStatus="status">
	<div class="list_member_design shadow-sm" onclick="articleMember('${dto.memberNo}');">
		<div class="number__design">${dataCount - (pageNo-1) * size - status.index}</div>
		<span class="">
				<c:if test="${dto.gender=='F'}">
					<img class="profile__loc " src="${pageContext.request.contextPath}/resources/images/member_img.png">
				</c:if>			
				<c:if test="${dto.gender=='M'}">
					<img class="profile__loc " src="${pageContext.request.contextPath}/resources/images/member_img2.png">
				</c:if>	
		</span>
		<span class="name__design">${dto.name}</span>
		<span class="member__design">${dto.memberNo}</span>
		<span class="au__design">${dto.authority}</span>
		<span class="jo__design">${dto.joindate}</span>
		<span class="jo__design">${dto.birth}</span>
		<span class="membership__btn"><button class="${dto.subtype=='1' or dto.subtype=='12' ? 'membership__btn__design' :'not__membership__btn__design' }">${dto.subtype=='1' or dto.subtype=='12' ? 'Subscript!' :'None' }</button></span>
		<span class="en__btn"><button type="button" onclick="changeEnalbed('${dto.memberNo}')" value="${dto.enabled}" data-en${dto.memberNo}='${dto.enabled}' class="${dto.enabled=='1' ? 'en__btn__design' : 'no_en__btn__design'}">${dto.enabled == '1' ? "활성화" : "비활성화"}</button></span>
	</div>
</c:forEach>


<div class="no__member">
	<div class="pt-3">
		${dataCount == 0 ? "조회된 회원이 없습니다!" : paging}
	</div>
</div>


