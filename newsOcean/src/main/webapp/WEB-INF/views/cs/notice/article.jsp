<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript">
<c:if test="${sessionScope.member.memberShip>50}">
	function deleteOk() {
	    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    let query = "noticeNo=${dto.noticeNo}&${query}";
		    let url = "${pageContext.request.contextPath}/cs/notice/delete?" + query;
	    	location.href = url;
	    }
	}
</c:if>
</script>

<div class="">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-clipboard"></i> 공지사항 </h3>
		</div>
		
		<div class="body-main">

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
								<c:when test="${sessionScope.member.memberShip > 50 }">${dto.nickName}</c:when>
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
								<a href="${pageContext.request.contextPath}/cs/notice/article?${query}&noticeNo=${preReadDto.noticeNo}">${preReadDto.noticeSubject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							다음글 :
							<c:if test="${not empty nextReadDto}">
								<a href="${pageContext.request.contextPath}/cs/notice/article?${query}&noticeNo=${nextReadDto.noticeNo}">${nextReadDto.noticeSubject}</a>
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
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/notice/update?noticeNo=${dto.noticeNo}&page=${page}';">수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-light" disabled="disabled">수정</button>
							</c:otherwise>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.memberNo==dto.memberNo || sessionScope.member.memberShip>50}">
				    			<button type="button" class="btn btn-light" onclick="deleteOk();">삭제</button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
				    		</c:otherwise>
				    	</c:choose>
					</td>
					<td class="text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/notice/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>

		</div>
	</div>
</div>