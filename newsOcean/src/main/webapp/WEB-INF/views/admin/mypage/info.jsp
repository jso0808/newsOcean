<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- 본문 -->
<div class="title-area-large shadow">
	<div class="title-area-text">
		상세 정보 
	</div>
</div>

<table class="table-mypage text-center">
	<tbody>					
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr class="">
				<td> ${dto.email} </td>
			</tr>
			<tr>
				<td>${dto.birth} </td>
			</tr>
			<tr>
				<td>${dto.name} ( ${dto.nickName} )</td>
			</tr>
			<tr>
				<td>${dto.joindate}</td>
			</tr>
			<tr>
				<td>${dto.gender=='M' ? "남성" : "여성"}</td>
			</tr>
			
			
		</c:forEach>
	</tbody>
	
	
</table>
 