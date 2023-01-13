<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sections.css" type="text/css">

<style type="text/css">
</style>
<script>
function subsectionClick(){
	
}
function recentClick(){
	
}
function sectionClick(){
	
}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paginate-boot.js"></script>
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
</script>
<div class="container body-container">
	<nav class="category" role="category" aria-label="카테고리">
		<div class="category_inner">
			<a href="${pageContext.request.contextPath}/" class="all category_link">
				<span>전체</span>
			</a>
			<a href="${pageContext.request.contextPath}/recent?categoryNo=100" class="recent category_link">
				<span>최신</span>
			</a>
			<a href="${pageContext.request.contextPath}/section?categoryNo=200" class="politics category_link">
				<span>정치</span>
			</a>
			<a href="${pageContext.request.contextPath}/section?categoryNo=300" class="economy category_link">
				<span>경제</span>
			</a>
			<a href="${pageContext.request.contextPath}/section?categoryNo=400" class="social category_link">
				<span>사회</span>
			</a>
			<a href="${pageContext.request.contextPath}/section?categoryNo=500" class="world category_link">
				<span>세계</span>
			</a>
			<a href="${pageContext.request.contextPath}/section?categoryNo=600" class="science category_link">
				<span>IT/과학</span>
			</a>
			<a href="${pageContext.request.contextPath}/search" class="search category_link">
				<span>
					<i class="bi bi-search search_icon"></i>
				</span>
			</a>
		</div>
	</nav>
	<ul class="categoryBox">
		<c:choose>
			<c:when test="${categoryNo eq 200}">
				<li><a href="${pageContext.request.contextPath}/recent?categoryNo=${status.count+200}"  onclick="">${dto.categoryName}</a></li>
				<c:forEach var="dto" items="${subsectionlist}" begin="1" varStatus="status">
				<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=${dto.categoryNo}"  onclick="">${dto.categoryName}</a></li>
				</c:forEach>
			</c:when>
			<c:when test="${categoryNo eq 300}">
				<li><a href="${pageContext.request.contextPath}/recent?categoryNo=${status.count+300}"  onclick="">${dto.categoryName}</a></li>
				<c:forEach var="dto" items="${subsectionlist}" begin="1" varStatus="status">
					<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=${dto.categoryNo}"  onclick="">${dto.categoryName}</a></li>
				</c:forEach>
			</c:when>
			<c:when test="${categoryNo eq 400}">
				<li><a href="${pageContext.request.contextPath}/recent?categoryNo=${status.count+400}"  onclick="">${dto.categoryName}</a></li>
				<c:forEach var="dto" items="${subsectionlist}" begin="1" varStatus="status">
				<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=${dto.categoryNo}"  onclick="">${dto.categoryName}</a></li>
				</c:forEach>
			</c:when>
			<c:when test="${categoryNo eq 500}">
			<li><a href="${pageContext.request.contextPath}/recent?categoryNo=${status.count+500}"  onclick="">${dto.categoryName}</a></li>
				<c:forEach var="dto" items="${subsectionlist}" begin="1" varStatus="status">
					<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=${dto.categoryNo}"  onclick="">${dto.categoryName}</a></li>
				</c:forEach>
			</c:when>
			<c:when test="${categoryNo eq 600}">
				<li><a href="${pageContext.request.contextPath}/recent?categoryNo=${status.count+600}"  onclick="">${dto.categoryName}</a></li>
				<c:forEach var="dto" items="${subsectionlist}" begin="1" varStatus="status">
					<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=${dto.categoryNo}"  onclick="">${dto.categoryName}</a></li>
				</c:forEach>
			</c:when>
			<c:otherwise>
			
			</c:otherwise>
		</c:choose>
	</ul>
	<section class="main_section container">
		<div class="posts row">
			<c:forEach var="dto" items="${subCategoryNews}" varStatus="status">
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/news/article?crawlUrl=${dto.crawlUrl}">${dto.crawlTitle}:${dto.crawlUrl}</a>
			</c:forEach>
		</div>
	</section>
</div>
<div class="page-navigation">${paging}</div>
<form action="${pageContext.request.contextPath}/section">
	<input type="hidden" name="categoryNo" value="${categoryNo}">
</form>
<script>
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
	    	if(jqXHR.status === 403) {
	    		login();
	    		return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false,  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		contentType: false,  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
</script>