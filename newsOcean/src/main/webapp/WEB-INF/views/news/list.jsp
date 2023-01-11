<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.board-list tbody>tr.over {
	cursor: pointer;
}

.table .ellipsis {
	position: relative;
	min-width: 200px;
}

.table .ellipsis span {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	position: absolute;
	left: 9px;
	right: 9px;
	cursor: pointer;
}

.table .ellipsis:before {
	content: '';
	display: inline-block;
}


</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript">

$(function(){
	$(".board-list tbody>tr").hover(function(){
		$(this).addClass("over");
	}, function(){ // 마우스가 벗어나면
		$(this).removeClass("over");
	});
	

});


</script>

<div class="">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="fa-solid fa-envelope-open-text"></i> 구독 메일 발신함 </h3>
		</div>
		
		<div class="body-main">
			
			<div class="tab-content pt-2" id="nav-tabContent">
				<div class="tab-pane fade show active mt-3" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
				    
					<table class="table table-hover board-list">
						<thead class="table-light">
							<tr>
								<th class="bw-30">뉴스번호</th>
								<th class="bw-140">제목</th>
								<th class="bw-40">카테고리 번호</th>
								<th class="bw-50">조회수</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="dto" items="${list}" varStatus="status">	
								<tr>
									<td>${dto.newsNo}</td>
									<td><a href="${articleUrl}newsNo=${dto.newsNo}" class="text-reset">${dto.title}</a></td>
									<td>${dto.categoryNo}</td>
									<td>${dto.hitCount}</td>
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
	</div>
</div>