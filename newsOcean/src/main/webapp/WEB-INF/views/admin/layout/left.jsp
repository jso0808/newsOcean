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
		<div class="header-left">
			<img class="logo__size" src="${pageContext.request.contextPath}/resources/images/logo_white.png">
		</div>
		<div class="header-right ">
			<span class="img" style="background-image: url('${pageContext.request.contextPath}/resources/images/admin_profile.png');"></span>
			<span class="roll-user">
				<label class="roll">관리자</label>
				<label class="user">
					<span class="name">관리자 님</span>
					<a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-arrow-right-from-bracket"></i></a>
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

		<li class="menu--item">
	        <a href="${pageContext.request.contextPath}/admin/memberManage/list" class="menu--link" title="회원 관리">
				<i class="menu--icon  fa-fw fa-solid fa-user-group"></i>
				<span class="menu--label">회원 관리</span>
			</a>
		</li>
	
		<li class="menu--item menu--item__has_sub_menu">
			<label class="menu--link" title="고객센터관리">
				<i class="menu--icon  fa-fw fa-solid fa-person-circle-question"></i>
				<span class="menu--label">고객센터관리</span>
			</label>

			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">자주하는 질문</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">공지사항</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">1:1문의</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">쪽지</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">신고</a>
				</li>
			</ul>
		</li>

		<li class="menu--item menu--item__has_sub_menu">
			<label class="menu--link" title="스터디관리">
				<i class="menu--icon  fa-fw fa-solid fa-graduation-cap"></i>
				<span class="menu--label">스터디관리</span>
			</label>

			<ul class="sub_menu">
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">카테고리 관리</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">강좌 관리</a>
				</li>
				<li class="sub_menu--item">
					<a href="#" class="sub_menu--link">질문과 답변</a>
				</li>
			</ul>
		</li>

		<li class="menu--item">
			<a href="#" class="menu--link" title="일정관리">
				<i class="menu--icon  fa-fw fa-regular fa-calendar"></i>
				<span class="menu--label">일정관리</span>
			</a>
		</li>
		
		<li class="menu--item">
			<a href="#" class="menu--link" title="지역명소관리">
				<i class="menu--icon  fa-fw fa-solid fa-location-dot"></i>
				<span class="menu--label">지역명소관리</span>
			</a>
		</li>

		<li class="menu--item">
			<a href="#" class="menu--link" title="메인화면 설정">
				<i class="menu--icon  fa-fw fa-solid fa-gear"></i>
				<span class="menu--label">메인화면 설정</span>
			</a>
		</li>

		<li class="menu--item">
			<a href="#" class="menu--link" title="GroupWare">
				<i class="menu--icon  fa-fw fa-solid fa-id-card"></i>
				<span class="menu--label">GroupWare</span>
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
		<span class="menu--label">NewsOcean 메인</span>
	</button>

</nav>
