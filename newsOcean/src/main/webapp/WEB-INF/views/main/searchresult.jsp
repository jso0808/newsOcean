 <%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>

</script>
<style type="text/css">
*{margin:0; padding:0;}
.body-container{
	margin:0;
}
.banner_img{
	 min-width:98vw;
	 background-color: #80b5ff;
	 height: 250px;
	 margin:10px 0px;
	 opacity:0.3;
}
.wordCloud_img{
	 min-width:98vw;
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
.search_content{
 margin:5px auto;
}
.search_searchName{
margin-left:2.5rem;
}
.searchName{

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
$(function(){
	let searchType = "${searchType}";
	let sType ="";
	if(searchType == "searchName"){
		sType = '키워드';
	}else if(searchType== "subject"){
		sType = '제목';
	}
	let searchName = '<span>'+sType+"로 검색한 "+'"${searchName}"'+"의 검색결과입니다"+'</span>';
	$(".search_searchName").html(searchName);
})
</script>
<div class="container body-container">
	<h3 class="search_searchName">
	</h3>
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
<!-- 태그 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">태그 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">선택</button>
      </div>
    </div>
  </div>
</div>