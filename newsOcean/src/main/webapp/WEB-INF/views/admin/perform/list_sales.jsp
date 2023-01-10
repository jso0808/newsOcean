<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<table class="table shadow-sm">
	<thead class=" text-center" style="background: #004b81;">
		<tr class="tb__font__title">
			<th class="" >일자</th>
			<th class="" >일별 매출 합계</th>
			<th class="" >월간 매출 합계</th>
			<th class="" >연간 매출 합계</th>
			<th class="" >연간 매출 목표</th>
			<th class="" >달성률</th>
		</tr>
	</thead>
	<tbody class="text-center">
		<c:forEach items="${list}" var="dto">
			<tr class="tb__font" >
				<td class="" style="font-family: 'line_font_b';">${dto.substart}</td>
				<td class="" ><fmt:formatNumber value="${dto.paid_amount}" pattern="#,##0" /></td>
				<td class="" ><fmt:formatNumber value="${dto.month}" pattern="#,##0" /></td>
				<td class="" ><fmt:formatNumber value="${dto.year}" pattern="#,##0" /></td>
				<td style="color: blue; font-family: 'line_font_b';"><fmt:formatNumber value="${year_target}" pattern="#,##0" />원</td>
				<td><fmt:formatNumber value="${100.0 - ((year_target - dto.year) / year_target) * 100.0 }" pattern=".0" />%</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
