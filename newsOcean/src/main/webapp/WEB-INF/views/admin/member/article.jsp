<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
.table__con {
	width: 97%;
	border-radius: 20px;
	height: 300px;
}

.title__member__det{
    margin-left: 3px;
    color: #595959;
    font-size: 17px;
    font-family: line_font_b;
    font-weight: 600;
    margin-bottom: 10px;
}

</style>

<div class="title__member__det"> Member infomation 🙋‍♀️ </div>

<table class="table__con td-border ">
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
	<div class="title__member__det" style="margin-top: 20px;"> Membership list </div>
	
	<table class="table__con td-border ">
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
	
	
	<div class="title__member__det" style="margin-top: 20px;"> Member activity </div>
	
	<table class="table__con td-border ">
		<tr>
			<td class="wp-15 text-center bg-light">구독권 정보</td>
			<td class="ps-5">${dto.subtype=='12' ? "1년 구독권" : "1개월 구독권" }</td>
		</tr>
		<tr>
			<td class="wp-15 text-center bg-light">구독권 기간</td>
			<td class="ps-5"></td>
		</tr>
	</table>
</form>



