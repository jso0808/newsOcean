<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
*{margin:0; padding:0;}
.container{
	margin:0 auto;
}
.banner_img{
	 min-width:100vw;
	 background-color: #80b5ff;
	 height: 250px;
	 margin:10px 0px;
	 opacity:0.3;
}
.wordCloud_img{
	 min-width:100vw;
	 background-color: #80b542;
	 height: 350px;
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
</style>
<div class="container body-container">
	<div class="inner-page">
		메인 화면 입니다.
    </div>
    <div class="banner_img">
    	<img src="">
    	배너이미지 공간
    </div>
    <div class="wordCloud_img">
    	<img src="">
    	워드클라우드 공간
    </div>
	<nav class="category" role="category" aria-label="카테고리">
		<div class="category_inner">
			<a href="${pageContext.request.contextPath}/" class="category_link">
				<span>전체</span>
			</a>
			<a href="${pageContext.request.contextPath}/recent" class="category_link">
				<span>최신</span>
			</a>
			<a href="${pageContext.request.contextPath}/politics" class="category_link">
				<span>정치</span>
			</a>
			<a href="${pageContext.request.contextPath}/economy" class="category_link">
				<span>경제</span>
			</a>
			<a href="${pageContext.request.contextPath}/social" class="category_link">
				<span>사회</span>
			</a>
			<a href="${pageContext.request.contextPath}/world" class="category_link">
				<span>세계</span>
			</a>
			<a href="${pageContext.request.contextPath}/science" class="category_link">
				<span>IT/과학</span>
			</a>
			<a href="${pageContext.request.contextPath}/search" class="category_link">
				<span>
					<i class="bi bi-search search_icon"></i>
				</span>
			</a>
		</div>
	</nav>
	<section class="main_section container">
		<div class="posts row">
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/politics">정치</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/social">경제</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/science">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/science">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/science">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/science">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/science">IT/과학</a>
		</div>
		
	</section>
	
</div>
</html>