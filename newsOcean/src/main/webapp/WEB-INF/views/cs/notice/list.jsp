<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.body-container {
	margin:0 auto;
	max-width: 1000px;
	display: flex;
	flex-direction: column;
}
.noticebanner_div {
	width: 600px;
	display: flex;
	justify-content: flex-end;
}

</style>

<style>
@font-face {
  font-family: 'line_font_b';
  font-style: normal;
  font-weight: 800;
  src: url("${pageContext.request.contextPath}/resources/css/LINESeedKR-Bd.ttf") format('truetype');
}

@font-face {
  font-family: 'line_font_r';
  font-style: normal;
  font-weight: 800;
  src: url("${pageContext.request.contextPath}/resources/css/LINESeedKR-Rg.ttf") format('truetype');
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<div class="">
	<div class="body-container">	
		<div class="noticebanner">
	    	<div class="row">
		    		<div class="col text__area">
		    			<h3>공지사항</h3>
		    			<div>뉴스오션 소식을 전해드리는 공간이에요.</div>
		    			<div>뉴스오션 공지사항을 이곳에 모아 두었어요.</div>
		    		</div>
	    	</div>
		</div>
		
		<div class="body-title">
		</div>
		
		<div class="body-main">
			
 			<div class="row board-list-header">
	            <div class="col-auto me-auto dataCount">
	            </div>
	            <c:if test="${sessionScope.member.memberShip>50}">
	           	 	<div class="col text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/notice/write';">작성하기</button>
					</div>
				</c:if>
	            <div class="col-auto">&nbsp;</div>
	        </div>
			
			<table class="table table-hover board-list">
				<thead class="table-light">
					<tr>
						<th class="bw-60">번호</th>
						<th>제목</th>
						<th class="bw-100">작성자</th>
						<th class="bw-100">작성일</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${noticeList}">
						<tr>
							<td><span class="badge bg-primary">공지</span></td>
							<td class="left">
								<a href="${articleUrl}&noticeNo=${dto.noticeNo}" class="text-reset">${dto.noticeSubject}</a>
							</td>
							<td>관리자</td>
							<td>${dto.noticeRegdate}</td>
						</tr>
					</c:forEach>
									
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<td>${dataCount - (page-1) * size - status.index}</td>
							<td class="left">
								<a href="${articleUrl}&noticeNo=${dto.noticeNo}" class="text-reset">${dto.noticeSubject}</a>
							</td>
							<td>관리자</td>
							<td>${dto.noticeRegdate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="page-navigation">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
		</div>
	</div>
</div>