<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
// 메뉴 활성화
$(function(){
    var url = window.location.pathname;
    var urlRegExp = new RegExp(url.replace(/\/$/, '') + "$");
    
    try {
    	$('nav ul>li>a').each(function() {
    		if (urlRegExp.test(this.href.replace(/\/$/, ''))) {
    			$(this).addClass('active_menu');
    			return false;
    		}
    	});
    	if($('nav ul>li>a').hasClass("active_menu")) return false;
    	
    	$('nav ul>.menu--item__has_sub_menu').each(function() {
    		if (urlRegExp.test(this.href.replace(/\/$/, ''))) {
    			$(this).addClass('active_menu');
    			return false;
    		}
    	});
    }catch(e) {
    }
});

$(function(){
	$('nav ul>.menu--item__has_sub_menu ul>li>a').each(function() {
		if($(this).hasClass('active_menu')) {
			$(this).closest(".menu--item__has_sub_menu").addClass('menu--subitens__opened');
			$(".header--title").text($(this).text());
			return false;
		}
	});
});



</script>

<header class="header clearfix">
	<button type="button" id="toggleMenu" class="toggle_menu">
		<i class="fa-solid fa-bars"></i>
	</button>
	
	<div class="header-container">
		<div class="header-container2">
			<span class="header-left">
					<a href="${pageContext.request.contextPath}/admin">
						<img class="logo__size" src="${pageContext.request.contextPath}/resources/images/logo_white.png">
					</a>
			</span>
			<a class="header--title" style="color: #fff; ">관리자 페이지 </a>
		</div>
		
		<div class="header-right ">
			<span class="img" style="background-image: url('${pageContext.request.contextPath}/resources/images/admin_logo.png');"></span>
			<span class="roll-user ">
				<label class="roll" style="color: #fff;">관리자</label>
				<label class="user" style="color: #fff;">
					<span class="name" style="color: #fff;">${sessionScope.member.name}님, 환영합니다. </span>
					<a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-arrow-right-from-bracket" style="color: #fff;"></i></a>
				</label>
			</span>
		</div>
	</div>

</header>

<nav class="vertical_nav">
	<ul id="js-menu" class="menu">
	
		<li class="menu--item">
			<a href="${pageContext.request.contextPath}/admin" class="menu--link" title="Home">
				<i class="menu--icon  fa-fw fa-solid fa-house"></i>
				<span class="menu--label">Home</span>
			</a>
		</li>

		<li class="menu--item menu--item__has_sub_menu">
			<label class="menu--link" title="통계관리">
				<i class="menu--icon  fa-fw fa-solid fa-chart-line"></i>
				<span class="menu--label">실적관리</span>
			</label>
			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/perform/main" class="sub_menu--link">사이트 전체 통계</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">매출 통계</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">실시간 검색어</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">통계 자료 다운로드</a>
				</li>
			</ul>
		</li>
		<li class="menu--item menu--item__has_sub_menu">
			<label class="menu--link" title="회원관리">
				<i class="menu--icon  fa-fw fa-solid fa-person-circle-question"></i>
				<span class="menu--label">회원관리</span>
			</label>

			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/member/main" class="sub_menu--link">회원 조회</a>
					<a href="${pageContext.request.contextPath}/admin/member/article" class="sub_menu--link" style="display: none;" >회원 상세 조회</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">신고 회원 관리</a>
				</li>
			</ul>
		</li>
		
		<!--  중간 구분줄 -->
		<li class="">
			<span class=""></span>
		</li>
		
		<li class="menu--item menu--item__has_sub_menu">
			<label class="menu--link" title="사내게시판">
				<i class="menu--icon  fa-fw fa-solid fa-chalkboard-user"></i>
				<span class="menu--label">사내게시판</span>
			</label>

			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="${pageContext.request.contextPath}/admin/notice/main" class="sub_menu--link">공지사항</a>
				</li>
			</ul>
		</li>

		<li class="menu--item">
			<a href="${pageContext.request.contextPath}/admin/mypage/main" class="menu--link" title="관리자 정보 수정">
				<i class="menu--icon  fa-fw fa-solid fa-gear"></i>
				<span class="menu--label">관리자 정보 수정</span>
			</a>
		</li>

		<li class="menu--item logout__menu">
			<a href="${pageContext.request.contextPath}/member/logout" class="menu--link" title="Logout">
				<i class="menu--icon fa-fw fa-solid fa-lock-open" style="color: #707070;"></i>
				<span class="menu--label logout__label">Logout</span>
			</a>
		</li>
	</ul>

	<button id="collapse_menu" class="collapse_menu">
		<i class="collapse_menu--icon fa fa-fw"></i>
		<span class="menu--label"> close menu  </span>
	</button>

</nav>
