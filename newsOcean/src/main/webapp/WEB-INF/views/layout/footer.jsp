<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

h5 {
	color: #004B81;
	font-family: "line_font_b";
}

footer {
	font-family: "line_font_r";
	background: #eee;
}

.footer__logo {
	width: 270px;
	float: right;
	justify-content: flex-end;
	margin-left: 290px;
	margin-top: -20px;
	
}

.btn__size {
	width: 330px;
}

.service__info {
	font-size: 12px;
}


</style>

<div class="container container_font">
  <footer class="py-5">
    <div class="row">
      <div class="col-6 col-md-3 mb-3">
        <h5 class="font__b"> Notice</h5>
        <ul class="nav flex-column mt-3">
          <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">[공지사항] 'NewsOcean' 을 소개합니다. </a></li>
        </ul>
      </div>

      <div class="col-6 col-md-3 mb-3">
        <h5>Contact us</h5>
        <ul class="nav flex-column mt-3">
          <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">
          <span>합리적인 비용의 제휴 서비스를 찾으시나요 ? 
          NewsOcean에서 협업 제안드립니다!</span></a></li>
        </ul>
      </div>
      
      <div class="col-md-5 offset-md-1 mb-3">
        <form>
          <h5>매주 간편하게 NewsOcean 받아보기 🌊 </h5>
          <p> ✨ 1년 정기 구독시 10% 추가 할인과 에디터 컬럼 제공! </p>
          <div class="d-flex flex-column flex-sm-row w-100 gap-2 mt-3">
            <button class="btn btn-primary btn__size" style="background-color: #004B81; border: none;" type="button">뉴스오션 'suffer' 되기 🙋‍♂</button>
          </div>
        </form>
      </div>
    </div>
      
     <div class="row">
     	<div class="col-6 col-md-3 mb-3">
        <h5>FAQ</h5>
        <ul class="nav flex-column mt-3">
          <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">궁금하신 부분은 한 번에 해결하세요.</a></li>
        </ul>
      </div>
      
      <div class="col-6 col-md-3 mb-3">
        <h5>Advertising</h5>
        <ul class="nav flex-column mt-3">
          <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">제휴 및 광고문의하기</a></li>
        </ul>
      </div>
     </div>
     
     

    <div class="d-flex flex-column flex-sm-row py-4 border-top mt-4">
      <div class="service__info">사업자정보 | 개인정보처리방침 | 이용약관 | 저작권 정책 | 청소년보호정책 ⓒ NEWSOCEAN ALL RIGHTS RESERVED </div>
      <div><img class="footer__logo " src="${pageContext.request.contextPath}/resources/images/logo_gray.png"></div>
    </div>
  </footer>
</div>