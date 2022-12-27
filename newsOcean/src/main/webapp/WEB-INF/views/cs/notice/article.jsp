<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table mb-0">
	<thead>
		<tr>
			<td colspan="2" align="center">
				${dto.noticeSubject}
			</td>
		</tr>
	</thead>
	
	<tbody>
		<tr>
			<td width="50%">
				이름 :
				<c:choose>
					<c:when test="${sessionScope.member.membership > 50 }">${dto.nickName}</c:when>
					<c:otherwise>관리자</c:otherwise>
				</c:choose>							
			</td>
			<td align="right">
				${dto.noticeRegdate}
			</td>
		</tr>
		
		<tr>
			<td colspan="2" valign="top" height="200">
				${dto.noticeContent}
			</td>
		</tr>

		<tr>
			<td colspan="2">
				이전글 :
				<c:if test="${not empty preReadDto}">
					<a href="javascript:articleBoard('${preReadDto.noticeNo}', '${pageNo}');">${preReadDto.noticeSubject}</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				다음글 :
				<c:if test="${not empty nextReadDto}">
					<a href="javascript:articleBoard('${nextReadDto.noticeNo}', '${pageNo}');">${nextReadDto.noticeSubject}</a>
				</c:if>
			</td>
		</tr>
	</tbody>
</table>

<table class="table table-borderless">
	<tr>
		<td width="50%">
			<c:choose>
				<c:when test="${sessionScope.member.memberNo==dto.memberNo}">
					<button type="button" class="btn btn-light" onclick="updateForm('${dto.noticeNo}', '${pageNo}');">수정</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-light" disabled="disabled">수정</button>
				</c:otherwise>
			</c:choose>
	    	
			<c:choose>
	    		<c:when test="${sessionScope.member.membership>50}">
	    			<button type="button" class="btn btn-light" onclick="deleteOk('${dto.noticeNo}', '${pageNo}');">삭제</button>
	    		</c:when>
	    		<c:otherwise>
	    			<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
	    		</c:otherwise>
	    	</c:choose>
		</td>
		<td class="text-end">
			<button type="button" class="btn btn-light" onclick="listPage('${pageNo}');">리스트</button>
		</td>
	</tr>
</table>
