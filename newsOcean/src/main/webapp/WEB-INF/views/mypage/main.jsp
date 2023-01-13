	<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

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

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3> 마이페이지 </h3>
		</div>
		
		<div class="body-main">
			<div class="col p-2">
				<a href="${pageContext.request.contextPath}/mypage/keyword" title="키워드구독">키워드 구독 </a>
			</div>
			<div class="col p-2">
				<a href="${pageContext.request.contextPath}/mypage/info" title="회원정보수정">회원정보수정</a>
			</div>
			<div class="col p-2">
				<a href="${pageContext.request.contextPath}/mypage/activity" title="나의 댓글">나의 댓글</a>
			</div>
			<div class="col p-2">
				<a href="${pageContext.request.contextPath}/mypage/bookmark" title="북마크">북마크</a>
			</div>
		</div>
	</div>
</div>