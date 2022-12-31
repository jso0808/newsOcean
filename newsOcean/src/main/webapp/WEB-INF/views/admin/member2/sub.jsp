<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


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

<div class="no__sub">
	<div class="pt-3">
		${dataCount == 0 ? "조회된 구독내역이 없습니다!" : paging}
	</div>
</div>
</form>
