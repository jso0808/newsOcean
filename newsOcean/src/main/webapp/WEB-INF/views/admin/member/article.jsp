<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h3 style="font-size: 15px; padding-top: 10px;"><i class="fa-solid fa-angles-right"></i> 회원 정보</h3>

<table class="table td-border mx-auto my-10" style="width: 99%;">
	<tr>
		<td class="wp-15 text-center bg-light">회원번호</td>
		<td class="wp-35 ps-5">${dto.memberNo}</td>
		<td class="wp-15 text-center bg-light">아이디</td>
		<td class="wp-35 ps-5">${dto.email}</td>
	</tr>
	<tr>
		<td class="text-center bg-light">이 름</td>
		<td class="ps-5">${dto.name}</td>
		<td class="text-center bg-light">생년월일</td>
		<td class="ps-5">${dto.birth}</td>
	</tr>
	<tr>
		<td class="text-center bg-light">닉네임</td>
		<td class="ps-5">${dto.nickname}</td>
		<td class="text-center bg-light">성별</td>
		<td class="ps-5">${dto.gender}</td>
	</tr>
	<tr>
		<td class="text-center bg-light">회원가입일</td>
		<td class="ps-5">${dto.joindate}</td>
		<td class="text-center bg-light">최근로그인</td>
		<td class="ps-5">${dto.recentdate}</td>
	</tr>
	
	<tr>
		<td class="text-center bg-light">계정상태</td>
		<td colspan="3" class="ps-5">
			${dto.enabled==1?"활성":"잠금"}
			&nbsp;<span class="btn" onclick="updateEnabled('${dto.memberNo}', '${dto.enabled}');" style="cursor: pointer;">계정 상태 변경</span>
			<input type="hidden" value="${dto.enabled}" name="enabled" id="enabled">
		</td>
	</tr>
</table>

<form id="deteailedMemberForm" name="deteailedMemberForm" method="post">
	<h3 style="font-size: 15px; padding-top: 10px;"><i class="fa-solid fa-angles-right"></i>구독 정보</h3>
	
	<table class="table td-border mx-auto my-5">
		<tr>
			<td class="wp-15 text-center bg-light">구독권 정보</td>
			<td class="ps-5">${dto.subtype=='12' ? "1년 구독권" : "1개월 구독권" }</td>
		</tr>
		<tr>
			<td class="wp-15 text-center bg-light">구독권 기간</td>
			<td class="ps-5"></td>
		</tr>
	</table>
	
	<input type="hidden" name="memberNo" value="${dto.memberNo}">
	<input type="hidden" name="email" value="${dto.email}">
	<input type="hidden" name="registerId" value="${sessionScope.member.memberNo}">
</form>



<div id="memberStateDetaile" style="display: none;">
	<table class="table table-border mx-auto my-10">
		<thead>
			<tr class="bg-light">
				<th>내용</th>
				<th width="130">담당자</th>
				<th width="200">등록일</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="vo" items="${listState}">
				<tr>
					<td class="ps-5">${vo.memo} (${vo.stateCode})</td>
					<td class="text-center">${vo.registerId}</td>
					<td class="text-center">${vo.reg_date}</td>
				</tr>
			</c:forEach>
	  
			<c:if test="${listState.size()==0}">
				<tr align="center" style="border: none;">
					<td colspan="3">등록된 정보가 없습니다.</td>
				</tr>  
			</c:if>
		</tbody>
	</table>  
</div>
