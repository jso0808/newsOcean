<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${list.size() > 0}">
	<div class="accordion accordion-flush mt-2" id="accordionFlush">
		<c:forEach var="dto" items="${list}" varStatus="status">
			<div class="accordion-item" style="border: none;">
				<h2 class="accordion-header mb-1 border" id="flush-heading-${status.index}">
					<button class="accordion-button collapsed bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-${status.index}" aria-expanded="false" aria-controls="flush-collapse-${status.index}">
						${dto.faqSubject}
					</button>
				</h2>
				<div id="flush-collapse-${status.index}" class="accordion-collapse collapse" aria-labelledby="flush-heading-${status.index}" data-bs-parent="#accordionFlush">
					<div class="accordion-body">

						<div class="row border-bottom pb-1">분류 : ${dto.category}</div>
						<div class="row p-2">
							${dto.faqContent}
						</div>
						<c:if test="${sessionScope.member.memberShip>50}">
							<div class="row py-1">
								<div class="col text-end">
									<a href="#" onclick="javascript:location.href='${pageContext.request.contextPath}/cs/faq/update?faqNo=${dto.faqNo}&pageNo=${pageNo}';">수정</a>&nbsp;|
									<a href="#" onclick="deleteFaq('${dto.faqNo}', '${pageNo}');">삭제</a>
								</div>
							</div>
						</c:if>

					</div>
				</div>
			</div>		
		</c:forEach>
	</div>
</c:if>
 
<div class="page-navigation">
	${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>

<div class="row py-3">
	<div class="col">
		<button type="button" class="btn btn-light" onclick="reloadFaq();">새로고침</button>
	</div>
	<div class="col-6 text-center">
		<form class="row" name="searchForm" method="post">
			<div class="col-auto p-1">
				<select name="condition" id="condition" class="form-select">
					<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
					<option value="faqSubject" ${condition=="faqSubject"?"selected='selected'":""}>제목</option>
					<option value="faqContent" ${condition=="faqContent"?"selected='selected'":""}>내용</option>
				</select>
			</div>
			<div class="col-auto p-1">
				<input type="text" name="keyword" id="keyword" value="${keyword}" class="form-control">
			</div>
			<div class="col-auto p-1">
				<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
			</div>
		</form>
	</div>
	<div class="col text-end">
		<c:if test="${sessionScope.member.memberShip>50}">
			<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/faq/write';">글올리기</button>
		</c:if>
	</div>
</div>
