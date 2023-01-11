<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
*{margin:0; padding:0;}
.body-container{
	margin:0 auto;
}
.banner_img{
	 min-width:98vw;
	 background-color: #80b5ff;
	 height: 250px;
	 margin:10px 0px;
	 opacity:0.3;
}
.category{
	min-height: 70px;
	display:flex;
    justify-content: center;
    align-items: center;
}
.category_inner{
display:flex;
}
.category_link{
	display: flex;
	width:100px;
	min-height:70px;
    display: flex;
    justify-content: center;
    margin: 0 1rem;
    box-sizing: border-box;
    font-size: 1.125rem;
    color: #051619;
    cursor: pointer;
}
.category_link span{
	display: flex;
	width:100px;
	min-height:70px;
    justify-content: center;
    align-items:center;
}

.search_icon{
	display:flex;
	justify-content: center;
	align-items:center;
	font-size: 30px;
}
.main_section{
	display:flex;
	min-width: 90%;
	margin:0 auto;
	padding: 0px 5%;
}
.posts{
	display:flex;
	position:relative;
	flex-wrap:wrap;
}
.card{
	min-height: 300px;
	min-width:300px;
	display:block;
	border:1px solid black;
	box-sizing:border-box;
	position:relative;
	cursor:pointer;
}
.search_content{
 margin:5px auto;
}

.categoryBox{
	display: block;
    min-height: 1px;
	position: relative;
    top: 1px;
    clear: both;
    float: left;
    width: 100%;
    height: 27px;
    margin: 25px 0 0 0;
    z-index: 50;
}
.smallCategory{
	float: left;
    height: 20px;
    padding: 0 9px 0 12px;
}
li{
	list-style: none;
	float: left;
    height: 20px;
    padding: 0 9px 0 12px;
}
</style>
<script>
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