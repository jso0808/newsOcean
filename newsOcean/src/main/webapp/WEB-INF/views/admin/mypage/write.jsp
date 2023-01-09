<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 본문 -->
<form name="mypageForm" method="post">
		<div class="update__form__design">계정 정보 수정하기</div>
	<table class="table-mypage  ">
		<tbody>					
			<tr>
				<td class="info__bold">BIRTH 변경</td>
				<td><input type="DATE" class="myp__input" name="birth" value="${dto.birth}" ></td>
			</tr>
			<tr>
				<td class="info__bold">NICKNAME 변경</td>
				<td><input type="text" class="myp__input_name" name="nickName" style="margin-right: -20px;" value="${dto.nickName}"></td>
				<td><button type="button" class="btn" onclick="findNickname()">중복확인</button></td>
			</tr>
		</tbody>
	</table>
		
		<div class="findNickname" style="margin-left: 30px; margin-top: 10px; color: red; font-family: 'line_font_b';">* 사용 불가한 닉네임 입니다.</div>
		<div class="nofindNickname" style="margin-left: 30px; margin-top: 10px; color: blue; font-family: 'line_font_b';">* 사용 가능한 닉네임 입니다.</div>
		<input type="hidden" id="NicknameOk">

	
	<button type="button" class="btn-update-1 btn shadow-sm" style="margin-left: 104px;" onclick="sendOk();">수정하기</button>
	<button type="button" class="btn-update-1 btn shadow-sm" onclick="sendCancel();">수정취소</button>
 </form>