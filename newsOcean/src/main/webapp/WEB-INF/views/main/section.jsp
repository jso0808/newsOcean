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
	<h1 class="search_keyword">
	</h1>
	<div class="search_result_count">
	</div>
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
	<div id="mediaSubnav" class="f_clear">
		<!-- 뉴스홈 > 정치 -->
		<h3 class="newsPolitic"><a href="${pageContext.request.contextPath}/section?categoryNo=200" onclick="sectionClick('200');">정치</a></h3>
		<ul class="mediaSubnavList">
			<li class="first"><a href="${pageContext.request.contextPath}/recent?mid=n0201" class="selected" onclick="recentClick('201');">최신뉴스</a></li>
			<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=202"  onclick="subsectionClick('202');">대통령실</a></li>
			<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=203"  onclick="subsectionClick('203');">국회/정당</a></li>
			<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=204"  onclick="subsectionClick('204');">외교/국방</a></li>
			<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=205"  onclick="subsectionClick('205');">북한</a></li>
			<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=206"  onclick="subsectionClick('206');">행정</a></li>
			<li><a href="${pageContext.request.contextPath}/subsection?categoryNo=207"  onclick="subsectionClick('207');">정치 일반</a></li>
		</ul>
	</div>
	<section class="main_section container">
		<div class="posts row">
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/section?categoryNo=500">정치</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/section?categoryNo=500">경제</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/section?categoryNo=500">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/section?categoryNo=500">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/section?categoryNo=500">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/section?categoryNo=500">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/section?categoryNo=500">IT/과학</a>
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