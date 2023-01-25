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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paginate-boot.js"></script>

<c:url var="listUrl" value="/sub/mail/listSendMail">
	<c:if test="${not empty keyword}">
		<c:param name="condition" value="${condition}"/>
		<c:param name="keyword" value="${keyword}"/>
	</c:if>
</c:url>

<script type="text/javascript">
window.addEventListener("load", function(){
	let page = ${page};
	let pageSize = ${size};
	let dataCount = ${dataCount};
	let url = "${listUrl}"; 
	
	let total_page = pageCount(dataCount, pageSize);
	let paging = pagingUrl(page, total_page, url);
	
	document.querySelector(".dataCount").innerHTML = dataCount+"개 ("
			+page+"/"+total_page+"페이지)";

	document.querySelector(".page-navigation").innerHTML = 
		dataCount === 0 ? "등록된 게시물이 없습니다." : paging;
});

$(function(){
	$(".board-list tbody>tr").hover(function(){
		$(this).addClass("over");
	}, function(){ // 마우스가 벗어나면
		$(this).removeClass("over");
	});
	
	$(".board-list tbody>tr").click(function(){
		let num = $(this).attr("data-num");
		let url = "${articleUrl}&mailNo="+mailNo;
		location.href = url;
	});
});

function searchList() {
	const f = document.searchForm;
	f.submit();
}

</script>

<div class="">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="fa-solid fa-envelope-open-text"></i> 구독 메일 발신함 </h3>
		</div>
		
		<div class="body-main">
		
			<div class="row board-list-header">
	            <div class="col-auto me-auto dataCount">
	            </div>
	            <div class="col-auto">&nbsp;</div>
	        </div>	
			
			<div class="tab-content pt-2" id="nav-tabContent">
				<div class="tab-pane fade show active mt-3" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
				    
					<table class="table table-hover board-list">
						<thead class="table-light">
							<tr>
								<th class="bw-30">메일번호</th>
								<th class="bw-140">제목</th>
								<th class="bw-60">작성자</th>
								<th class="bw-60">작성일</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="dto" items="${list}" varStatus="status">
								<tr>
									<td>${dto.mailNo}</td>
									<td><a href="${articleUrl}&mailNo=${dto.mailNo}" class="text-reset">${dto.subject}</a></td>
									<td>${dto.senderName}</td>
									<td>${dto.sendDate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div class="page-navigation"></div>
		
					<div class="row board-list-footer">
						<div class="col">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sub/mail/listSendMail';">새로고침</button>
						</div>
						<div class="col-6 text-center">
							<form class="row" name="searchForm" action="${pageContext.request.contextPath}/sub/mail/listSendMail" method="post">
								<div class="col-auto p-1">
									<select name="condition" class="form-select">
										<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
										<option value="senderName" ${condition=="senderName"?"selected='selected'":""}>작성자</option>
										<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
										<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
									</select>
								</div>
								<div class="col-auto p-1">
									<input type="text" name="keyword" value="${keyword}" class="form-control">
								</div>
								<div class="col-auto p-1">
									<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
								</div>
							</form>
						</div>
						<div class="col text-end">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sub/mail/send';">메일 작성</button>
						</div>
					</div>
				    

				</div>
			</div>

		</div>
	</div>
</div>