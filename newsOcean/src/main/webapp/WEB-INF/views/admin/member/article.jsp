<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
.sub__card {
	width: 305px;
	background: #fff;
	margin-top: 25px;
	height: 80px;
	border-radius: 7px;
	font-size: 11px;
	padding-right:10px;
	
	box-shadow: 0 5px 10px -7px rgba(0,0,0,1);
	border-color: linear-gradient( to right, #004b81, #9999FF );
	
}

.sub__card:hover {
	transform: scale(1.005);
	transition: .2s;
}

.td__padd td {
	padding-left: 10px;
	font-family:'line_font_b';
	color: #595959;
}

.icon__money {
	font-size: 40px;
	color: #fff;
	padding-left: 25px;
	padding-top: 5px;
	background: #004b81;
	padding-right: 20px;
	border-radius: 10px 0px 0px 10px;
	
}
</style>



<table class="table__con shadow-sm tt_bold" >
	<tr class="">
		<td class="text-center">회원번호</td>
		<td class="wp-35 ps-5">${dto.memberNo}</td>
		<td class="wp-15 text-center ">아이디</td>
		<td class="wp-35 ps-5">${dto.email}</td>
	</tr>
	<tr>
		<td class="text-center ">이 름</td>
		<td class="ps-5">${dto.name}</td>
		<td class="text-center ">생년월일</td>
		<td class="ps-5">${dto.birth}</td>
	</tr>
	<tr>
		<td class="text-center ">닉네임</td>
		<td class="ps-5">${dto.nickname}</td>
		<td class="text-center ">성별</td>
		<td class="ps-5">${dto.gender}</td>
	</tr>
	<tr>
		<td class="text-center ">회원가입일</td>
		<td class="ps-5">${dto.joindate}</td>
		<td class="text-center ">최근로그인</td>
		<td class="ps-5">${dto.recentdate}</td>
	</tr>
	
	<tr >
		<td class="text-center ">계정상태</td>
		<td class="ps-5">
			${dto.enabled==1? "<span class='state__en__yes';>활성화</span>":"<span class='state__en__no';>계정 잠금</span>"}
		</td>
		<td class="text-center ">구독내역 출력</td>
		<td class="ps-5">
			<span class="btn btn-update" onclick="" style="cursor: pointer;"><i class="fa-solid fa-file-powerpoint"></i>&nbsp;&nbsp; PDF 다운로드</span>
			<input type="hidden" value="${dto.enabled}" name="enabled" id="enabled">
		</td>
	</tr>
	
</table>


<div class="title__member__second" style="margin-top: 20px;"> 구독 내역 </div>
<form id="deteailedMemberForm" name="deteailedMemberForm" method="post">
<div class="row">

	<c:forEach var="dto" items="${sublist}" varStatus="status">
		<table class="sub__card  " style="margin-left: 15px;">
			<tr>
				<td rowspan='3' class="icon__money"><i class="fa-solid fa-circle-dollar-to-slot"></i></td>
			</tr>
			<tr class="td__padd">
				<td class=" text-center ">구독권 정보</td>
				<td class="">
					<c:if test="${dto.subtype=='12'}"><span>1년 구독권 (12개월)</span></c:if>
					<c:if test="${dto.subtype=='1'}"><span>1개월 구독권 </span></c:if>
				</td>
			</tr>
			<tr class="td__padd">
				<td class=" text-center ">구독권 기간</td>
				<td class="">
					<c:if test="${dto.substart=='2999-01-01'}"><span></span></c:if>
					<c:if test="${dto.subtype=='1'}"><span>${dto.substart} ~ ${dto.subend } </span></c:if>
					<c:if test="${dto.subtype=='12'}"><span>${dto.substart} ~ ${dto.subend } </span></c:if>
				</td>
			</tr>
		</table>
	</c:forEach>
</div>
	
	<input type="hidden" name="memberNo" value="${dto.memberNo}">
	<input type="hidden" name="email" value="${dto.email}">
	<input type="hidden" name="registerId" value="${sessionScope.member.memberNo}">
</form>



