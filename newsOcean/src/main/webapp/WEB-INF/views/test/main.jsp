<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paginate-boot.js"></script>

</head>
<div></div>
<body>
	<div class="container-fluid bg-light header-top">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="p-2">
						<i class="bi bi-telephone-inbound-fill"></i> +82-1234-1234
					</div>
				</div>
				<div class="col">
					<div class="d-flex justify-content-end">
						<c:choose>
							<c:when test="${empty sessionScope.member}">
								<div class="p-2">
									<a href="javascript:dialogLogin();" title="로그인"><i
										class="bi bi-lock"></i></a>
								</div>
								<div class="p-2">
									<a href="${pageContext.request.contextPath}/member/member"
										title="회원가입"><i class="bi bi-person-plus"></i></a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="p-2">
									<a href="${pageContext.request.contextPath}/member/logout"
										title="로그아웃"><i class="bi bi-unlock"></i></a>
								</div>
								<div class="p-2">
									<a href="#" title="알림"><i class="bi bi-bell"></i></a>
								</div>
								<c:if test="${sessionScope.member.membership>50}">
									<div class="p-2">
										<a href="${pageContext.request.contextPath}/admin" title="관리자"><i
											class="bi bi-gear"></i></a>
									</div>
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>

				</div>
			</div>
		</div>
	</div>

	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/"><i
				class="bi bi-app-indicator"></i></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto flex-nowrap">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="${pageContext.request.contextPath}/">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="#">가볼만한곳</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							커뮤니티 </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">방명록</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/bbs/list">게시판</a></li>
							<li><a class="dropdown-item" href="#">답변형 게시판</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/photo/list">포토갤러리</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/chat/main">채팅</a></li>
						</ul></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							스터디룸 </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">프로그래밍</a></li>
							<li><a class="dropdown-item" href="#">데이터베이스</a></li>
							<li><a class="dropdown-item" href="#">웹프로그래밍</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">질문과 답변</a></li>
						</ul></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							고객센터 </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">자주하는질문</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
							<li><a class="dropdown-item" href="#">1:1문의</a></li>
							<li><a class="dropdown-item" href="#">질문과답변</a></li>
						</ul></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							마이페이지 </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">일정관리</a></li>
							<li><a class="dropdown-item" href="#">사진첩</a></li>
							<li><a class="dropdown-item" href="#">쪽지함</a></li>
							<li><a class="dropdown-item" href="#">친구관리</a></li>
							<li><a class="dropdown-item" href="#">메일</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/member/pwd">정보수정</a></li>
						</ul></li>

				</ul>
			</div>

		</div>
	</nav>



	<h3>뿡삥이</h3>
</body>
</html>