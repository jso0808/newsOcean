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