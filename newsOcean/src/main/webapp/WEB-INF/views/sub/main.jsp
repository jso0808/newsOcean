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

.btn-card, btn-card:hover, btn:hover{
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
  background-color: #fff;
  padding: 40px 30px;
  position: relative;
  border: 1px solid gray;
}

.main {
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
  border-left: 1px solid gray;
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
  border-right: 1px solid gray;
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



</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">


/*
	$("#check_module").click(function () {
		var IMP = window.IMP; 
		let selectSub = $("input[name=selectSub]").val(); // 구독권
		let totalPrice = $("input[name=totalPrice]").val(); // 결제 금액
		let buyer_name = $("input[name=name]").val(); // 구매자 이름
		let buyer_email = $("input[name=email]").val(); // 구매자 이메일
		
		
		IMP.init('imp72401774'); 
		IMP.request_pay({
			pg: 'kakao',
			pay_method: 'card',
			merchant_uid: 'merchant_' + new Date().getTime(),
			name: '상품명 : ' + selectSub,
			amount: totalPrice,
			buyer_name: buyer_name,
			buyer_email: buyer_email,
			}, function (rsp) {
				console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '결제 금액 : ' + rsp.paid_amount;
				// success.submit();
				// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
				// 자세한 설명은 구글링으로 보시는게 좋습니다.
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(msg);
		});
	});
*/


function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
	    	if(jqXHR.status === 403) {
	    		login();
	    		return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}


// 구독 기간 날짜 계산하기
function selectSubDate(selectSub) {
	let today = new Date();
	let endDate; 
	
	// 구독 시작일을 오늘 날짜로 
	startDate = new Date(today).toISOString().substring(0, 10);
	$("input[name=dateSubStart]").attr("value", startDate); 
	
	// 구독 종료일 구하기
	if(selectSub === 'monthSub') { // 1개월 구독권
		// 1개월 후 날짜 
		endDate = new Date(today.setMonth(today.getMonth() + 1)).toISOString().substring(0, 10);
		$("input[name=dateSubEnd]").attr("value", endDate);
		$("input[name=price]").attr("value", 3000);
		$("input[name=totalPrice]").attr("value", 3000);
	} else if(selectSub === 'yearSub') { // 12개월 구독권
		// 12개월 후 날짜
		endDate = new Date(today.setMonth(today.getMonth() + 12)).toISOString().substring(0, 10);
		$("input[name=dateSubEnd]").attr("value", endDate);
		$("input[name=price]").attr("value", 24000);
		$("input[name=totalPrice]").attr("value", 24000);
	}
	
	// 첫 메일 발송일 (오는 화요일 날짜) 구하기
	let thisDate = new Date();
	let dayToday = thisDate.getDay(); // 오늘 요일 구하기
	let firstMailDate; // 첫 메일 발송일 
	
	if(dayToday === 2) { // 오늘이 화요일이면
		let calcDate = thisDate.getDate() + 7; 
		firstMailDate = new Date(thisDate.setDate(calcDate)).toISOString().substring(0, 10);
	} else {
		let calcDate = thisDate.getDate() - dayToday + ((dayToday == 0 ? 2 : 9) + 0); 
		firstMailDate = new Date(thisDate.setDate(calcDate)).toISOString().substring(0, 10);
	}
	
	$("input[name=dateFirstMail]").attr("value", firstMailDate);
}

// 선택한 구독권 데이터 가져오기
$(function() {
	$(".card").click(function() {
		// 선택한 구독권 객체의 아이디를 변수에 저장
		s = $(this).attr("id");
		
		// 이전에 눌렀던 구독권 색 전부 초기화
		$(".card").css({background:"#fff"});
		
		// 선택한 구독권 색 변경
		$(this).css({background:"#4FC4F7"});
		// 선택한 구독권 값 저장
		$("input[name=selectSub]").attr('value',s);
		
		// 구독기간 가져오기
		selectSubDate(s);
		
	});
});

function requestPay() {
	alert('결제 버튼 클릭 : 유효성 검사 추가해야댐!');
	var IMP = window.IMP;
	IMP.init("imp72401774");
	
	let selectSub = $("input[name=selectSub]").val(); // 구독권 
	let email = $("input[name=email]").val();
	let memberShip = $("input[name=memberShip]").val();
	let price = $("input[name=totalPrice]").val();
	let selectNum;
	
	console.log(selectSub + email + name + price);
	
	var today = new Date();
	var h = today.getHours().toString();
	var min = today.getMinutes().toString();
	var s = today.getSeconds().toString();
	var m = today.getMilliseconds().toString();
	var makeMerchanUid = h + min + s + m;
	
	console.log("고유번호 시간으로 조합: "+makeMerchanUid);
	
	if(selectSub === "") {
		$(".selectSub").focus();
	}
	if(price === "") {
		$(".price").focus();
	}
	
	if(selectSub === "monthSub"){
		selectSub = "1개월 구독권";
		selectNum = "1";
	} else if(selectSub === "yearSub") {
		selectSub = "12개월 구독권";
		selectNum = "12";
	}
	
	console.log(selectNum+makeMerchanUid);
	console.log(selectSub);
	console.log(price);
	console.log(email);

	IMP.request_pay({
	    pg : 'kakaopay',
	    pay_method : 'card', 
	    merchant_uid: selectNum+makeMerchanUid, // 고유 주문번호
	    name : selectSub,
	    item_name: selectSub,
	    amount : price,
	    buyer_email : email
	}, function(rsp) { // callback 로직 뿡~~
		if(rsp.success) {
			alert("success");
			console.log(rsp);
			console.log(rsp.imp_uid);	
			
			console.log(rsp.imp_uid);
			console.log(rsp.merchant_uid);
			
			$("input[name=imp_uid]").attr("value", rsp.imp_uid);
			$("input[name=merchant_uid]").attr("value", rsp.merchant_uid);
			$("input[name=paid_amount]").attr("value", rsp.paid_amount);
			$("input[name=paid_at]").attr("value", rsp.paid_at);	
			$("input[name=pg_tid]").attr("value", rsp.pg_tid);
			
			requestPaySuccess();
		} else {
			alert("fail");
			console.log(rsp);
		}
	});
	
}

function requestPaySuccess() {
	let memberShip = $("input[name=memberShip]").val();
	
	let selectSub = $("input[name=selectSub]").val(); // 구독권 
	let email = $("input[name=email]").val();
	let price = $("input[name=totalPrice]").val();
	let imp_uid = $("input[name=imp_uid]").val();
	let merchant_uid = $("input[name=merchant_uid]").val();
	let paid_amount = $("input[name=paid_amount]").val();
	let paid_at = $("input[name=paid_at]").val();
	let pg_tid = $("input[name=pg_tid]").val();
	let dateSubStart = $("input[name=dateSubStart]").val();
	let dateSubEnd = $("input[name=dateSubEnd]").val();
	let dateFirstMail = $("input[name=dateFirstMail]").val();
	console.log("requestPaySuccess 내부여요");
	
	console.log(selectSub); 
	console.log(email);
	console.log(price);
	console.log(imp_uid); 
	console.log(merchant_uid);  // x
	console.log(paid_amount); 
	console.log(paid_at);
	console.log(dateSubStart);
	console.log(dateSubEnd);
	console.log(dateFirstMail);
	console.log(pg_tid); 
	
	let url = "${pageContext.request.contextPath}/sub/paySuccess";
	let query= "email="+email+"&imp_uid="+imp_uid+"&merchant="+merchant+"&selectSub="+selectSub+
		"&paid_amount="+paid_amount+"&paid_at="+paid_at+"&pg_tid="+pg_tid+"&dateSubStart="+dateSubStart+
		"&dateSubEnd="+dateSubEnd+"&dateFirstMail="+dateFirstMail;
	
	ajaxFun(url, "post", query, "html", fn);

	/*
	$.ajax({
		type: "post",
		url: url,
		data: query,
		success: function(data) {
			let msg = data.msg;
			if(msg==="true"){
				alert(msg);
			} else {
				alert("ajax 실패 "+msg);
			}
		}
	});
	*/
}



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
						</div>
						<div class="col div-sub2">
							<div class="col div-select-container">
								<div class="card btn btn-card" id="monthSub">
									<div class="main">
										<div class="co-img">
											<img class="img-circle" src="${pageContext.request.contextPath}/resources/images/logo_circle_gray.png"
												alt="" />
										</div>
										<div class="vertical"></div>
										<div class="content-card">
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
									<div class="card btn btn-card" id="yearSub">
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
									 readonly="readonly" value="" placeholder="구독권 선택">
							</div>
							
							<div class="col row">
								<label for="exampleFormControlInput1" class="form-label">첫 메일 발송일</label>
								<input class="form-control form-control-lg" type="text" name="dateFirstMail" id="dateFirstMail"
									readonly="readonly" value="" placeholder="구독권 선택">
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
								class="orm-control" readonly="readonly" value="">
						</div>

						<div class="col row">
							<label for="exampleFormControlInput1" class="form-label">최종 결제 금액</label> 
							<input class="form-control form-control-lg" type="text" name="totalPrice" id="totalPrice"
								readonly="readonly" value="">
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
							<button name="btnPay" id="btnPay" class="btn btn-primary btnPay" onclick="requestPay()"> 결제하기 <i class="bi bi-check2"></i></button>
							<input type="hidden" name="selectSub" value=""> 
			            	<input type="hidden" name="memberNo" value="${sessionScope.member.memberNo}">
			            	<input type="hidden" name="email" value="${sessionScope.member.email}">
			            	<input type="hidden" name="name" value="${sessionScope.member.name}">
			            	<input type="hidden" name="authority" value="${sessionScope.member.authority}">
			            	<input type="hidden" name="imp_uid" value="">
			            	<input type="hidden" name="merchant_uid" value="">
			            	<input type="hidden" name="paid_amount" value="">
			            	<input type="hidden" name="paid_at" value="">
			            	<input type="hidden" name="pg_tid" value="">
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