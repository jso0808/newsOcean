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
	 height: 350px;
	 margin-top:10px;
}

.banner_img_div {
	width: 500px;
	display: flex;
	justify-content: flex-end;
}

.wordCloud_img{
	display: flex;
    justify-content: center;
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
	min-height:40px;
    display: flex;
    justify-content: center;
    margin: 0 1rem;
    box-sizing: border-box;
}
.category_link span{
	display: flex;
    justify-content: center;
    align-items:center;
    color: #004b81;
    font-size: 1.125rem;
    cursor: pointer;
}

.search_icon{
	display:flex;
	 justify-content: center;
    align-items:center;
    color: #004b81;
    font-size: 1.125rem;
    cursor: pointer;
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
	justify-content: center;
}
.card{
	min-height: 150px;
	min-width:300px;
	max-width:350px;
	display:block;
	border:none;
	box-sizing:border-box;
	position:relative;
	cursor:pointer;
	font-size:18px;
	padding:15px;
	border-radius: 5px;
	box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
	margin:5px;
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
	font-size: 40px;
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
	margin-top: 25px;
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

.main_title_intro {
	font-family: 'line_font_b';
	font-size: 27px;
	width: 330px;
	margin-left: 300px;
	padding-right: 20px;
	margin-bottom: 10px;
	margin-top: 20px;
}

.main__line_first {
	font-family: 'line_font_b';
	font-size: 50px;
	color: #eee;
	margin: auto;
}

.main__line {
	font-family: 'line_font_b';
	font-size: 50px;
	color: #eee;
	margin-left: 300px;
	margin-top: -15px;
}

.pick_news_container {
	width: 1000px;
	margin: auto;
	padding-left: 40px;
	border-radius: 5px;
}

.pick_news_span:hover {
	cursor: pointer;
	background: #eee;
	transition: .5s;
}

.pick_news_span {
	height: 30px;
	padding-top: 5px;
	font-size: 13px;
	font-family: 'line_font_r';
}

.pick_news_a_tag:hover {
	text-decoration: none;
}


.keyword__list__container {
	font-family: 'line_font_b';
	font-size: 13px;
	width: 100%;
	margin-left: 347px;
	margin-bottom: 20px;
}

.keyword__list__st {
	display:inline-block;
	color: #fff;
	border-radius: 7px 7px 0px 0px;
	background: #004b81;
	width: 100px;
	height: 30px;
	text-align: center;
	padding-top: 7px;
	margin-right: 4px;
	margin-top: 7px;

}

.keyword__list__st__click{
	display:inline-block;
	color: #000;
	border-radius: 7px 7px 0px 0px;
	background: #eee;
	width: 100px;
	height: 30px;
	text-align: center;
	padding-top: 7px;
	margin-right: 4px;
	margin-top: 7px;
}


.keyword__list__st:hover {
	cursor: pointer;
	opacity: 90%;
	transition: .5s;
}

.pick_news_title {
	font-size: 14px;
	padding-top: 6px;
	padding-bottom: 6px;
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
					<span style="height: 30px; display:block;"><button class="text__area__newsocean3">NewsOcean 서핑하기 👀</button></span>
				</a>
    			
    		</div>
    		<div class="col img__area">
    			<img style="width: 360px; margin-top: 50px;" src="${pageContext.request.contextPath}/resources/images/main_img_type2.png">
    		</div>
    	</div>
    </div>
   <div class="main__line_first" style="margin-top: 70px;">────────────────────</div>
   
   
   <div class="news__pick__area">
   
   </div>	
</div>
    
    
    <div class="main_title_intro"><img style="width: 60px; " src="${pageContext.request.contextPath}/resources/images/man_swim.gif"> 뉴스 인기 키워드</div>
    
    <div class="wordCloud_img">
    	<img style="margin: auto;" src="${pageContext.request.contextPath}/resources/images/rating.png">
    </div>
    <div class="main_title_intro"><img style="width: 60px; " src="${pageContext.request.contextPath}/resources/images/man_swim.gif"> 뉴스 카테고리</div>
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
	<section class="main_section container">
		<div class="posts row">
			<c:forEach var="dto" items="${subCategoryNews}" varStatus="status">
				<a class="card col-md-3 col-lg-4"  href="${pageContext.request.contextPath}/news/article?crawlUrl=${dto.crawlUrl}">
					<span>${dto.crawlTitle}</span>
					<div style="opacity: 0.5;"><span style="font-size:14px;">${dto.crawlDate}</span>&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">${dto.crawlPress}</span></div>
				</a>
			</c:forEach>
		</div>
	</section>	
</div>
<div class="page-navigation">${paging}</div>
</html>



<script type="text/javascript">

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


$(function(){
	
	if(${sessionScope.member.memberNo} != null){
		news_pick(1);
	}

});

function news_pick(page){
	let url = "${pageContext.request.contextPath}/news_pick";
	let query = "pageNo="+page;
	let selector = ".news__pick__area";
	
	const fn = function(data){
		$(selector).html(data);
		
	};
	
	ajaxFun(url, "get", query, "html", fn);

}




</script>