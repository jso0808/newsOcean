<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
*{margin:0; padding:0;}
.body-container2{
	display: flex;
	flex-direction: column;
}
.banner_img{
	 min-width:98vw;
	 background-color: #fff;
	 height: 500px;
	 margin-top:40px;
}

.banner_img_div {
	width: 600px;
	display: flex;
	justify-content: flex-end;
}
.wordCloud_img{
	 min-width:1200px;
	 margin: auto;
	 height: 340px;
	 margin-bottom: 30px;
	 margin-top: 50px;
}

.wordCloud_img:hover {
	transform: scale(1.04);
	transition: .5s;
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
	margin-bottom: 100px;
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

.img__area {
	margin-left:-10px;
	margin-top: -40px;
	margin-right: 220px;
}

.img__area:hover {
	transform: scale(1.03);
	transition: .5s;
}

.text__area {
	font-size: 46px;
	margin-left: 340px;
	margin-top:-10px;
	padding-top: 25px;
	width: 400px;
}

.text__area:hover {
	transform: scale(1.03);
	transition: .5s;
}

.text__area__newsocean {
	font-size: 16px;
	margin-top: 30px;
	padding-top: 25px;
	width: 400px;
	color: #595959;	
	font-family: 'line_font_r';
}

.text__area__newsocean2 {
	font-size: 16px;
	width: 400px;
	color: #595959;	
	font-family: 'line_font_r';
}

/*버튼*/
.text__area__newsocean3 {
	width: 270px;
	background: #004b81;
	border-radius: 12px;
	font-size: 14px;
	border: none;
	color: #fff;
	height: 40px;
}

.wordCloud_intro {
	font-family: 'line_font_b';
	font-size: 27px;
	width: 330px;
	margin: auto;
	text-align: center;
	padding-right: 20px;
	margin-bottom: -20px;
	margin-top: 110px;
}

.main__line {
	font-family: 'line_font_b';
	font-size: 50px;
	color: #eee;
	margin: auto;
}

</style>
<div class="body-container2">
    <div class="banner_img">
    	<div class="row">
    		<div class="col text__area">
    			<div>거친 파도를</div>
    			<div>유연하게 헤엄치는</div>
    			<div style="color: #004b81">서퍼처럼 🌊</div>
    			<div class="text__area__newsocean">세상을 유연하게.</div>
    			<div class="text__area__newsocean2">세상에 꼭 필요한 뉴스만 주는 플랫폼</div>
    			<a href="${pageContext.request.contextPath}/cs/notice/list">
					<div style="height: 30px;"><button class="text__area__newsocean3">NewsOcean 서핑하기 👀</button></div>
				</a>
    			
    			
    			
    			
    		</div>
    		<div class="col img__area">
    			<img style="width: 500px;" src="${pageContext.request.contextPath}/resources/images/main_img_type2.png">
    		</div>
    	</div>
    </div>
   
    
    <div class="wordCloud_intro"><img style="width: 60px; " src="${pageContext.request.contextPath}/resources/images/man_swim.gif"> 뉴스 인기 키워드</div>
    <div class="main__line">──────</div>
    
    <div class="wordCloud_img">
    	<img src="${pageContext.request.contextPath}/resources/images/rating.png">
    </div>
    <div class="wordCloud_intro"><img style="width: 60px; " src="${pageContext.request.contextPath}/resources/images/man_swim.gif"> 뉴스 카테고리</div>
    <div class="main__line">──────</div>
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
	<section class="main_section container">
		<div class="posts row">
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/">정치</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/">경제</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/">IT/과학</a>
			<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/">IT/과학</a>
		</div>
		
	</section>
	
</div>
</html>