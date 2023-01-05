<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.card{
	height:200px;
	width: 16rem;
	float:left;
	font-size: 1.125rem;
	text-align: center;
	margin-bottom: 50px;
	margin-top: 50px;
}

.card-img-top {
  	width: 100px;
  	height: 100px;
  	text : center;
  	margin-bottom: 20px;
	margin-top: 20px;
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
		
		<div class="cardBox" class="clearfix">
			<div class="card">
				<div>
					<a href="${pageContext.request.contextPath}/cs/notice/list" class="card-body" title="공지사항">
					<img src="${pageContext.request.contextPath}/resources/images/logo_circle.png" class="card-img-top" alt="...">
					</a>
				</div>
				<div>
					공지사항
				</div>
			</div>
			
				<div class="card">
				<div>
					<a href="${pageContext.request.contextPath}/cs/qna/list" class="card-body" title="공지사항">
					<img src="${pageContext.request.contextPath}/resources/images/logo_circle.png" class="card-img-top" alt="...">
					</a>
				</div>
				<div>
					QNA
				</div>
			</div>
			
			<div class="card">
				<div>
					<a href="${pageContext.request.contextPath}/cs/faq/main" class="card-body" title="공지사항">
					<img src="${pageContext.request.contextPath}/resources/images/logo_circle.png" class="card-img-top" alt="...">
					</a>
				</div>
				<div>
					FAQ
				</div>
			</div>
		</div>
	</div>
</div>