<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sections.css" type="text/css">

<style type="text/css">

</style>
<script>
$(function(){
	let keyword = '<span class="keyword">'+${keyword}+"</span>";
	keyword += '<span class="search_result_h1">'+"의 검색결과입니다"+'</span>';
	
	$(".search_keyword").html(keyword);
	
	//$(".search_result_count");
})
function subsectionClick(){
	
}
function recentClick(){
	
}
function sectionClick(){
	
}
</script>
<div class="container body-container">
	<nav class="category" role="category" aria-label="카테고리">
		<div class="category_inner">
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
			<!-- 100번대면 최신뉴스대카테고리, 201,301,401,501,601은 나머지 -->
		<c:forEach var="dto" items="${subsectionlist}" varStatus="status">
			<fmt:parseNumber value="${dto.categoryNo/100+99}" var="caNo" type="number" integerOnly="true"/>
			<li><a href="${pageContext.request.contextPath}/recent?categoryNo=${caNo}"   onclick="">${dto.categoryName}</a></li>
		</c:forEach>
	</ul>
	<section class="main_section container">
		<div class="posts row">
			<c:forEach var="dto" items="${subCategoryNews}" varStatus="status">
				<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/news/article?crawlUrl=${dto.crawlUrl}">
					<span>${dto.crawlTitle}</span>
					<div style="opacity: 0.5;">${dto.crawlDate}&nbsp;&nbsp;&nbsp;${dto.crawlPress}</div>
				</a>
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