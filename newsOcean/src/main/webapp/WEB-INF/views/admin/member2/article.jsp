<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table__con shadow-sm tt_bold" >
	<tr class="">
		<td class="text-center">회원번호</td>
		<td class="wp-35 ps-5 member__no">${dto.memberNo}</td>
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

<div>
	<input type="hidden" name="m" class="m" value="${dto.memberNo}">
</div>





