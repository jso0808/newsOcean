<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- 본문 -->
<form name="mypageForm" method="post">
	<table class="table-mypage text-center ">
		<tbody>					
			<tr>
				<td><input type="DATE" name="birth" value="${dto.birth}" ></td>
			</tr>
			<tr>
				<td><input type="text" name="name" value="${dto.name}" ></td>
				<td><input type="text" name="nickName" value="${dto.nickName}"></td>
			</tr>
			<tr>
				<td>
					<button type="button" class="btn" onclick="sendOk();">수정하기</button>
					<button type="button" class="btn" onclick="sendCancel();">수정취소</button>
				<td>
			</tr>
		</tbody>
	</table>
 </form>