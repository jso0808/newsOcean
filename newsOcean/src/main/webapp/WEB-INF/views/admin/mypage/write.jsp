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
				<td class="info__bold">BIRTH</td>
				<td><input type="DATE" class="myp__input" name="birth" value="${dto.birth}" ></td>
			</tr>
			<tr>
				<td class="info__bold">Name / Nickname</td>
				<td><input type="text" class="myp__input" name="name" value="${dto.name}" ></td>
				<td><input type="text" class="myp__input_name" name="nickName" value="${dto.nickName}"></td>
			</tr>
		</tbody>
	</table>
	<button type="button" class="btn-update-1" style="margin-left: 104px;" onclick="sendOk();">수정하기</button>
	<button type="button" class="btn-update-1" onclick="sendCancel();">수정취소</button>
 </form>