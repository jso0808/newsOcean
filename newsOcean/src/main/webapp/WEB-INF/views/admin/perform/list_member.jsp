<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<table class="table shadow-sm">
	<thead class=" text-center" style="background: #004b81;">
		<tr class="tb__font__title">
			<th class="" >일자</th>
			<th class="" >가입자</th>
			<th class="" >월 가입자</th>
			<th class="" >월 KPI</th>
			<th class="" >KPI 달성률(월)</th>
			<th class="" >연 가입자</th>
			<th class="" >연 KPI</th>
			<th class="" >KPI 달성률(연)</th>
		</tr>
	</thead>
	<tbody class="text-center">
		<c:forEach items="${list}" var="dto">
			<tr class="tb__font" >
				<td class="" style="font-family: 'line_font_b';">${dto.joindate}</td>
				<td class="" style="font-family: 'line_font_b';"><fmt:formatNumber value="${dto.dataMember}" pattern="#,##0" /></td>
				<td class="" ><fmt:formatNumber value="${dto.month}" pattern="#,##0" /></td>
				<td>30</td>
				<td style="font-family: 'line_font_b'; color: red" ><fmt:formatNumber value="${100.0 - ((40.0 - dto.month) / 40.0) * 100.0 }" pattern=".0" />%</td>
				<td class="" ><fmt:formatNumber value="${dto.year}" pattern="#,##0" /></td>
				<td>200</td>
				<td style="font-family: 'line_font_b'; color: red" >77%</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

