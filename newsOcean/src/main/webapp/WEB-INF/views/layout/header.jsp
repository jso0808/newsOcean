<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
* {
	font-family: 'line_font_b';
}

.img-logo {
	max-width: 500px;
	max-height: 250px;
	border-top: 20px;
}

.div-col-bar1 {
	left: 50%;
	top: 50%;
	display: flex;
	padding-top: 20px;
	justify-content: center;
}

.div-row-bar1 {
	height: 100%	
}

.bar1 {
	height: 150px;
	text-align: center;
}


.bar2 {
	height:	50px;
	text-align: center;
}

.btn-sub {
	border-radius: 20px; 
	width: 80x;
	color: #000;
	border-color: #000;
	padding-right: 20px;
	padding-left: 10px;
	
}

.div-text {
	position: relative;
	z-index: 100;
	
}

.container {
	display: inline-block;
}

.div-btn-sub {
	padding-top: 35px;
	padding-right: 40px;
}

.btn-sub { 
	height: 50px;
	color: #000; 
	border: 3px solid #fff; 
	padding: 10px 20px; 
	font-size: 22px; 
	border-radius: 100px; 
	transform: translate(0, -50%); 
	overflow: hidden; 
	transition: all 1s; 
} 

.btn-sub:before { 
	content: ""; 
	position: absolute; 
	width: 300px; 
	height: 250px; 
	border-radius: 100px; 
	background-color: #0097e6; 
	top: 45px; left: 50%; 
	transform: translate(-50%); 
	animation: wave 5s infinite linear; 
	transition: all 1s; } 
.btn-sub:hover:before { top: 10px; } 

span { position: relative; }

@keyframes wave {
  0% { transform: translate(-50%) rotate(-180deg); }
  100% { transform: translate(-50%) rotate(360deg); } 
} 

a { text-decoration: none; color: #000; }
a:hover, a:active{ text-decoration: underline; cursor: pointer; color: #004B81; }

.div-intro {
	font-size: 15px;
}

.div-menu a{
	font-size: 18px;
}

.div-menu-text {
	width: 100%
}

.div-menu-icon {
	display: flex;
	justify-content: flex-end;
}

/*로그인, 로그아웃*/
.div-menu-icon a {
	font-size: 14px;
	margin-right: 20px;
}

.div-menu-icon:hover {
	color: #004b81;
}


.div-div-menu {
	padding: 0;
}

.div-img-logo {
	max-width: 500px;
	max-height: 250px;
}

.bar-sub-btn {
	padding-top: 25px;
	background: #80B5FF;
	padding-right: 47px;
}
</style>

<style>
@font-face {
  font-family: 'line_font_b';
  font-style: normal;
  font-weight: 800;
  src: url("${pageContext.request.contextPath}/resources/css/LINESeedKR-Bd.ttf") format('truetype');
}

@font-face {
  font-family: 'line_font_r';
  font-style: normal;
  font-weight: 800;
  src: url("${pageContext.request.contextPath}/resources/css/LINESeedKR-Rg.ttf") format('truetype');
}
</style>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<div class="bar-sub-btn">
	<div class="col div-col-bar1">
		<button class="btn btn-sub"><div class="div-text">뉴스오션 구독하고 혜택받기 ✨</div></button>
    </div>
	
</div>

<div class="bar1">
	<div class="container">
		<div class="row div-row-bar1">
			<div class="col div-col-bar1 div-intro">
				"우리가 시간이 없지, 세상이 안 궁금하냐!"
			</div>
			<div class="col div-col-bar1 div-img-logo">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/">
					<img class="img-logo"
					src="${pageContext.request.contextPath}/resources/images/logo.png">
				</a>
			</div>
			<div class="col div-col-bar1 div-menu">
				<div class="row div-div-menu">
					<div class="row">
						<div class=" div-menu-icon">
							<c:if test="${sessionScope.member.memberShip==null}">
								<a href="${pageContext.request.contextPath}/member/login"><i class="fa-solid fa-user" style="margin-right: 7px;"></i>로그인/회원가입</a>
							</c:if>
							<c:if test="${sessionScope.member.memberShip > 0}">
								<span style="margin-right: 20px; color: #595959; font-size: 14px;">${sessionScope.member.name}님, 안녕하세요! 🌊</span>
								<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
							</c:if>
							
							<c:if test="${sessionScope.member.memberShip > 50}">
								<a href="${pageContext.request.contextPath}/admin" title="관리자" style="margin-right: 1px;"><i class="fa-solid fa-gear" style="margin-right: 7px;"></i>관리자</a>
							</c:if>
						</div>
					</div>
					<div class="row div-menu-text">
						<div class="col p-2">
							<a href="#" title="뉴스">최신뉴스</a>
						</div>
						<div class="col p-2">
							<a href="${pageContext.request.contextPath}/sub/main" title="구독">구독</a>
						</div>
						<div class="col p-2" style="width: 180px;">
							<a href="${pageContext.request.contextPath}/mypage/main" title="마이페이지">마이페이지</a>
						</div>
						<div class="col p-2">
							<a href="${pageContext.request.contextPath}/cs/qna/list" title="고객센터">고객센터</a>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>





