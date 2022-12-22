<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container">
	<div class="body-container">	
		<div class="body-main">

			<table class="table mb-0">
				<thead>
					<tr>
						<td colspan="2" align="center">
							${dto.companySubject}
						</td>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td width="50%">
							이름 :${dto.name}
						</td>
						<td align="right">
							${dto.companyDate} | 조회 ${dto.companyHitcount}
						</td>
					</tr>
					
					<tr>
						<td colspan="2" valign="top" height="200">
							${dto.companyContent}
						</td>
					</tr>
					
					<c:forEach var="vo" items="${listFile}">
						<tr>
							<td colspan="2">
								파&nbsp;&nbsp;일 :
								<a href="${pageContext.request.contextPath}/admin/notice/download?fileNo=${vo.fileNo}">${vo.originalFilename}</a>
								(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KB)
							</td>
						</tr>
					</c:forEach>
					
					<tr>
						<td colspan="2">
							이전글 :
							<c:if test="${not empty preReadDto}">
								<a href="${pageContext.request.contextPath}/notice/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							다음글 :
							<c:if test="${not empty nextReadDto}">
								<a href="${pageContext.request.contextPath}/notice/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
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
								<button type="button" class="btn btn-light" onclick="updateForm('${dto.companyNo}', '${pageNo}');">수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-light" disabled="disabled">수정</button>
							</c:otherwise>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.memberNo==dto.memberNo}">
				    			<button type="button" class="btn btn-light" onclick="deleteOk('${dto.companyNo}');">삭제</button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
				    		</c:otherwise>
				    	</c:choose>
					</td>
					<td class="text-end">
						
					</td>
				</tr>
			</table>

		</div>
	</div>
</div>