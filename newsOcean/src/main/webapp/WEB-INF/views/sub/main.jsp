<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt" %>

<style type="text/css">
.body-container {
	max-width: 1500px;
	max-height: 1200px;
}

.area-title{
	border-top: 100px;
	font-size: 30px;
	text-align: center;
	margin-bottom: 50px;
	margin-top: 50px;
}

.area-footer {
	border-top: 100px;
	margin-bottom: 50px;
	margin-top: 50px;
}

.btn, btn:hover{
	background-color: #4FC4F7;
}

.div-select-container {
	width: 500px;
	text-align: center;
	display: flex;
    justify-content: flex-start;
	margin-bottom: 15px;
}

.div-sub1 {
	width: 200px;
	margin-left: 15px;
	font-size: 25px;
}

.div-sub2 {
	width: 60%;
}

.div-area {
	margin-bottom: 50px;
	display: flex;
    flex-direction: column;
}

.div-select-period {
	display: flex;
	justify-content: space-around;
}

.text-period {
	font-size: 30px;
}

.text-price {
	font-size: 20px;
}

.img-circle {
	
}

.form-label {
    margin-bottom: 0.5rem;
    font-size: 20px;
}

.div-area-sub2 {
	padding-bottom: 30px;
}

@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap");

.container-card {
  width: 100%;
  height: 100vh;
  justify-content: center;
  align-items: center;
  display: flex;
}

.card {
  width: 450px;
  height: 180px;
  border-radius: 5px;
  box-shadow: 0 4px 6px 0 rgba(0, 0, 0, 0.2);
  background-color: #4FC4F7;
  padding: 40px 30px;
  position: relative;
}

.main,
.copy-button {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.card::after {
  position: absolute;
  content: "";
  height: 40px;
  right: -20px;
  border-radius: 40px;
  z-index: 1;
  top: 70px;
  background-color: #fff;
  width: 40px;
}

.card::before {
  position: absolute;
  content: "";
  height: 40px;
  left: -20px;
  border-radius: 40px;
  z-index: 1;
  top: 70px;
  background-color: #fff;
  width: 40px;
}

.co-img img {
  width: 100px;
  height: 100px;
}
.vertical {
  border-left: 5px dotted black;
  height: 100px;
  position: absolute;
  left: 40%;
}

.content-card h1 {
  font-size: 30px;
  color: #565656;
  display: inline-block;
  
}

.content-card h1 span {
  font-size: 25px;
  padding-left: 10px;
}
.content-card h2 {
  font-size: 18px;
  color: #565656;
  text-transform: uppercase;
}

.content-card p {
  font-size: 16px;
  color: #696969;
}

.copy-button {
  margin: 12px 0 -5px 0;
  height: 45px;
  border-radius: 4px;
  padding: 0 5px;
  border: 1px solid #e1e1e1;
}

.copy-button input {
  width: 100%;
  height: 100%;
  border: none;
  outline: none;
  font-size: 15px;
}

.copy-button button {
  padding: 5px 20px;
  background-color: #dc143c;
  color: #fff;
  border: 1px solid transparent;
}

.buy{
 position: absolute;
  content: "";
  bottom: 20px;
  left:20px;
  background-color: #dc143c;
 }


</style>

<script type="text/javascript">
function paySubmit() {
	alert('결제 버튼 클릭')
}

// 선택한 구독권의 종류 가져오기
$(function() {
	$(".card").click(function() {
		s = $(this).attr("id");
		alert(s)
		$(this).css({background:"#fff"});
		$("input[name=selectSub]").attr('value',s);
	});
});

</script>


<div class="main-container">
	<div class="body-container">	
		<div class="area-title">
			뉴스오션 구독하기
		</div>

		<div class="body-main">
			<div class="row row-cols-2">
				
				<div class="col div-area">
					<!-- 구독권 선택  영역-->
					<div class="col row row-cols-2 div-area1">
						<div class="col div-sub1">
							<div>구독권 선택</div>
							<div id="selectSub"></div>
							<input type="hidden" name="selectSub" value="">
						</div>
						<div class="col div-sub2">
							<div class="col div-select-container">
								<div class="card btn" id="monthSub">
									<div class="main">
										<div class="co-img">
											<img class="img-circle" src="${pageContext.request.contextPath}/resources/images/logo_circle_gray.png"
												alt="" />
										</div>
										<div class="vertical"></div>
										<div class="content-card ">
											<h2>월 구독권</h2>
											<h1>
												1개월<span>3,000원</span>
											</h1>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col div-select-container">
								<div class="col">
									<div class="card btn" id="yearSub">
										<div class="main">
											<div class="co-img">
												<img class="img-circle" src="${pageContext.request.contextPath}/resources/images/logo_circle.png"
													alt="" />
											</div>
											<div class="vertical"></div>
											<div class="content-card">
												<h2>년 구독권</h2>
												<h1>
													12개월<span>월 2,000원</span>
												</h1>
											</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
					<!-- 구독기간 영역 -->
					<div class="row row-cols-2">
						<div class="col div-sub1">
							<div class="">구독기간</div>
						</div>
						<div class="col div-sub2">
							<div class="col row">
								<label for="exampleFormControlInput1" class="form-label">구독 시작일</label>
								<input class="form-control form-control-lg" type="text" name="dateSubStart" id="dateSubStart"
									 class="orm-control" readonly="readonly" value="2022.12.23">
							</div>
							
							<div class="col row">
								<label for="exampleFormControlInput1" class="form-label">구독 종료일</label>
								<input class="form-control form-control-lg" type="text" name="dateSubEnd" id="dateSubEnd"
									 readonly="readonly" value="2023.01.22">
							</div>
							
							<div class="col row">
								<label for="exampleFormControlInput1" class="form-label">첫 메일 발송일</label>
								<input class="form-control form-control-lg" type="text" name="dateFirstMail" id="dateFirstMail"
									readonly="readonly" value="2022.12.26">
							</div>
						</div>
					</div>
				</div>

				<!-- 결제금액 영역 -->
				<div class="col div-area">
					<div class="col div-sub2 div-area-sub2">
						<div class="col row">
							<label for="exampleFormControlInput1" class="form-label">상품 금액</label> 
							<input class="form-control form-control-lg" type="text" name="price" id="price"
								class="orm-control" readonly="readonly" value="24,000원">
						</div>

						<div class="col row">
							<label for="exampleFormControlInput1" class="form-label">최종 결제 금액</label> 
							<input class="form-control form-control-lg" type="text" name="totalPrice" id="totalPrice"
								readonly="readonly" value="24,000원">
						</div>

						<div class="col row">
							<label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
							<div class="col-sm-8" style="padding-top: 5px;">
								<input type="checkbox" id="agree" name="agree"
									class="form-check-input"
									
									style="margin-left: 0;"
									onchange="form.sendButton.disabled = !checked">
								<label class="form-check-label">
									<a href="#" class="text-decoration-none">결제 규정</a>에 동의합니다.
								</label>
							</div>
						</div>
						<div>
							 <button type="button" name="btnPay" class="btn btn-primary" onclick="paySubmit();"> 결제하기 <i class="bi bi-check2"></i></button>
			            
						</div>
						
					</div>
				</div>
			</div>
		</div>
		
		<div class="area-footer">
	
		</div>

	</div>
</div>



</body>
</html>