<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- 본문 -->

<table class="table-mypage t__left__margin">
	<tbody>					
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr>
				<td class="info__bold"> EMAIL </td>
				<td class="info__second"> ${dto.email} </td>
			</tr>
			<tr>
				<td class="info__bold"> BIRTH </td>
				<td class="info__second">${dto.birth} </td>
			</tr>
			<tr>
				<td class="info__bold"> NAME (NICKNAME) </td>
				<td class="info__second">${dto.name} ( ${dto.nickName} )</td>
			</tr>
			<tr>
				<td class="info__bold"> JOIN DATE </td>
				<td class="info__second">${dto.joindate}</td>
			</tr>
			<tr>
				<td class="info__bold"> GENDER </td>
				<td class="info__second">${dto.gender=='M' ? "남성" : "여성"}</td>
			</tr>
			
			
		</c:forEach>
	</tbody>
	
	
</table>
 