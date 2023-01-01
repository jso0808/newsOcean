<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="vo" items="${listAllCategory}">
	<tr>
		<td class="p-0"> <input type="text" name="category" class="form-control" disabled="disabled" value="${vo.category}"> </td>
		<td class="p-0">
			<select name="enabled" class="form-select" disabled="disabled">
				<option value="1" ${vo.enabled==1?"selected=selected":"" }>활성</option>
				<option value="0" ${vo.enabled==0?"selected=selected":"" }>비활성</option>
			</select>
		</td>
		<td class="p-0"> <input type="text" name="orderNo" class="form-control" disabled="disabled" value="${vo.orderNo}"> </td>
		<td class="text-center p-0">
			<input type="hidden" name="categoryNum" value="${vo.categoryNum}">
			<button type="button" class="btn btn-sm btnCategoryUpdate px-0" title="수정"><i class="bi bi-pencil-square"></i></button>
			<button type="button" class="btn btn-sm btnCategoryDeleteOk px-0" title="삭제"><i class="bi bi-trash"></i></button>
			<button type="button" class="btn btn-sm btnCategoryUpdateOk px-0" title="수정완료" style="display: none;"><i class="bi bi-check2-square"></i></button>
			<button type="button" class="btn btn-sm btnCategoryUpdateCancel px-0" title="수정취소" style="display: none;"><i class="bi bi-arrow-clockwise"></i></button>
		</td>
	</tr>
</c:forEach>
