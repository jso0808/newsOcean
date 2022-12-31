<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<div class="container">
	<div class="body-container">	
		<div class="body-main">

			<table class="table">
				<thead>
					<tr class="title__area">
						<td colspan="2" class="title__article__1">
							${dto.companySubject}
						</td>
						
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td width="50%">
							작성자 :${dto.name}
						</td>
						<td align="right">
							${dto.companyDate} | 조회수 ${dto.companyHitcount}
						</td>
					</tr>
					
					<tr class="con__area__end">
						<td colspan="2" valign="top" height="200">
							${dto.companyContent}
						</td>
					</tr>
					
					<c:forEach var="vo" items="${listFile}">
						<tr >
							<td colspan="2" class="shadow-sm">
								첨&nbsp;&nbsp;부&nbsp;&nbsp;파&nbsp;&nbsp;일 :&nbsp;
								<a href="${pageContext.request.contextPath}/admin/notice/download?fileNo=${vo.fileNo}"><i class="fa-solid fa-folder-open" style="color: #FFCC33;"></i>&nbsp;&nbsp;${vo.originalFilename}</a>
								(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KB)
							</td>
						</tr>
					</c:forEach>
					
					<tr>
						<td colspan="2" class="shadow-sm">
							이전글 :
							<c:if test="${not empty preReadDto}">
								<a href="javascript:articleBoard('${preReadDto.companyNo}', '${pageNo}');">${preReadDto.companySubject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="shadow-sm">
							다음글 :
							<c:if test="${not empty nextReadDto}">
								<a href="javascript:articleBoard('${nextReadDto.companyNo}', '${pageNo}');" >${nextReadDto.companySubject}</a>
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
								<button type="button" class="btn__article__design__up " onclick="updateForm('${dto.companyNo}', '${pageNo}');">수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn__article__design__up " disabled="disabled">수정</button>
							</c:otherwise>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.memberNo==dto.memberNo}">
				    			<button type="button" class="btn__article__design shadow-sm" onclick="deleteOk('${dto.companyNo}');">삭제</button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" class="btn__article__design shadow-sm" disabled="disabled">삭제</button>
				    		</c:otherwise>
				    	</c:choose>
					</td>
					<td class="text-end">
					</td>
				</tr>
				<tr>
					
				</tr>
			</table>
		</div>
		
		<div class="reply__container">
			<span class="reply__area shadow-sm"><input type="text" class="input__area shadow-sm" name="input__reply"></span>
			<span><button class="reply__btn btn" onclick="insertReply('${dto.companyNo}', '${pageNo}');">댓글 등록</button></span>
		</div>
	</div>
</div>




