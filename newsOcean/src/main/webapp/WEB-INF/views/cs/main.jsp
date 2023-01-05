<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
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

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3> 고객센터 </h3>
		</div>
		
		<div class="body-main">
			<div class="col p-2">
				<a href="${pageContext.request.contextPath}/cs/notice/list" title="공지사항 게시판">공지사항</a>
			</div>
			<div class="col p-2">
				<a href="${pageContext.request.contextPath}/cs/qna/list" title="QNA 게시판">QNA</a>
			</div>
			<div class="col p-2">
				<a href="${pageContext.request.contextPath}/cs/faq/main" title="FAQ 게시판">FAQ</a>
			</div>
		</div>
	</div>
</div>