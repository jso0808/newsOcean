<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 


<style type="text/css">
.body-container {
	max-width: 1500px;
	max-height: 1200px;
}

.body-main {
	padding-top: 60px;
}

.area-title {
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

.btn-card, btn-card:hover, btn:hover {
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

.content-card {
	display: flex;
	flex-direction: column;
}

.content-card-sub {
	font-size: 22px;
}

.content-card-date {
	font-size: 25px;
}

.content-card-price {
	color: #033EAB;
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

.div-input {
	padding-top: 20px;
}

.div-btnPay {
	padding-top: 10px;
}

</style>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">

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
	    		alert("????????? ????????????.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("?????? ????????? ?????? ????????????.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("????????? ??????????????????.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}


// ?????? ?????? ?????? ????????????
function selectSubDate(selectSub) {
	let today = new Date();
	let endDate; 
	let pay;
	
	// ?????? ???????????? ?????? ????????? 
	startDate = new Date(today).toISOString().substring(0, 10);
	$("input[name=dateSubStart]").attr("value", startDate); 
	
	// ?????? ????????? ?????????
	if(selectSub === 'monthSub') { // 1?????? ?????????
		// 1?????? ??? ?????? 
		endDate = new Date(today.setMonth(today.getMonth() + 1)).toISOString().substring(0, 10);
		pay = "3,000??? ";
	} else if(selectSub === 'yearSub') { // 12?????? ?????????
		// 12?????? ??? ??????
		endDate = new Date(today.setMonth(today.getMonth() + 12)).toISOString().substring(0, 10);
		pay = "24,000???";
	}
	$("input[name=dateSubEnd]").attr("value", endDate);
	$("input[name=price]").attr("value", pay);
	$("input[name=totalPrice]").attr("value", pay);
	
	// ??? ?????? ????????? (?????? ????????? ??????) ?????????
	let thisDate = new Date();
	let dayToday = thisDate.getDay(); // ?????? ?????? ?????????
	let firstMailDate; // ??? ?????? ????????? 
	
	if(dayToday === 2) { // ????????? ???????????????
		let calcDate = thisDate.getDate() + 7; 
		firstMailDate = new Date(thisDate.setDate(calcDate)).toISOString().substring(0, 10);
	} else {
		let calcDate = thisDate.getDate() - dayToday + ((dayToday == 0 ? 2 : 9) + 0); 
		firstMailDate = new Date(thisDate.setDate(calcDate)).toISOString().substring(0, 10);
	}
	
	$("input[name=dateFirstMail]").attr("value", firstMailDate);
}

// ????????? ????????? ????????? ????????????
$(function() {
	$(".card").click(function() {
		// ????????? ????????? ????????? ???????????? ????????? ??????
		s = $(this).attr("id");
		
		// ????????? ????????? ????????? ??? ?????? ?????????
		$(".card").css({background:"#fff"});
		
		// ????????? ????????? ??? ??????
		$(this).css({background:"#4FC4F7"});
		// ????????? ????????? ??? ??????
		$("input[name=selectSub]").attr('value',s);
		
		// ???????????? ????????????
		selectSubDate(s);
		
	});
});

// ???????????? ??????. ?????? ??? ????????? ?????? 
function requestPay() {
	if(! confirm('????????? ???????????? ???????????????????????? ? ')) {
		return;
	}
	
	if(! $("input[name=agree]").prop("checked") ){
		alert("?????? ????????? ??????????????????!");
		return;
	}
	
	if($("input[name=selectSub]").val() === "") {
		alert("???????????? ??????????????????!");
		return;
	}
	
	// ?????? ??????????????? ??????
	findBySubIng();
	
}

// ?????? ??????????????? ??????????????? ??????
function findBySubIng() {
	let url = "${pageContext.request.contextPath}/sub/findBySubIng";
	
	const fn = function(data){
		let state = data.state;
		if(state === "true") {
			if(data.ing === 0) {
				console.log(data.ing);
				// ??????????????? ?????? ??????
				execKakaoPay();
			} else {
				console.log(data.ing);
				alert("?????? ?????? ????????????. ??????????????? ?????? ??? ??????????????????.");
				// ?????? ?????? ???????????? ??????
 	    		let listUrl = "${pageContext.request.contextPath}/sub/list";
 	    		location.replace(listUrl);
			}
		} else {
			alert("?????? ?????? ????????? ??????????????????. ");
			return;
		} 
	};
	
	ajaxFun(url, "post", "", "json", fn);
	
}

// ??????????????? ?????? API ????????????
function execKakaoPay() {
	var IMP = window.IMP;
	IMP.init("imp67011510");
	
	let selectSub = $("input[name=selectSub]").val(); // ????????? 
	let email = $("input[name=email]").val();
	let name = $("input[name=name]").val();
	let totalPrice = $("input[name=totalPrice]").val();
	let memberNo = $("input[name=memberNo]").val();
	let dateSubStart = $("input[name=dateSubStart]").val();
	let dateSubEnd = $("input[name=dateSubEnd]").val();
	let dateFirstMail = $("input[name=dateFirstMail]").val();
	let selectNum; // subType
	
	var today = new Date();
	var h = today.getHours().toString();
	var min = today.getMinutes().toString();
	var s = today.getSeconds().toString();
	var m = today.getMilliseconds().toString();
	var makeMerchantUid = h + min + s + m;
	
	if(email === "") {
		$(".email").focus();
		return;
	}
	if(selectSub === "") {
		$(".selectSub").focus();
		return;
	}
	if(totalPrice === "") {
		$(".totalPrice").focus();
		return;
	}
	
	if(selectSub === "monthSub"){
		selectSub = "1???????????????";
		selectNum = "1";
	} else if(selectSub === "yearSub") {
		selectSub = "12???????????????";
		selectNum = "12";
	}
	
	console.log(totalPrice);
	// ?????? ?????? 
	totalPrice = totalPrice.replace(/[^0-9]/g, ""); 
	console.log(totalPrice);
	
	IMP.request_pay({
	    pg : 'kakaopay',
	    merchant_uid: selectNum + makeMerchantUid, 
        name : selectSub,
        item_name: selectSub,
        amount : totalPrice,
        buyer_email : email,
        buyer_name : name
	}, function(rsp) { // callback ?????? 
		console.log(rsp);
		if(rsp.success) {
			alert("success");
			console.log(rsp);
 			console.log(rsp.imp_uid);	
 			console.log(rsp.merchant_uid);  
 			console.log(rsp.buyer_email);
 			console.log(rsp.buyer_name);
 			console.log(rsp.paid_at);		
 			console.log(rsp.paid_amount);	
 			console.log(rsp.pg_tid);	
 			
 			let url = "${pageContext.request.contextPath}/sub/paySuccess";
 			let query= "memberNo="+memberNo+"&imp_uid="+rsp.imp_uid+"&merchant_uid="+rsp.merchant_uid+"&selectNum="+selectNum+
 				"&paid_amount="+rsp.paid_amount+"&paid_at="+rsp.paid_at+"&pg_tid="+rsp.pg_tid+"&subStart="+dateSubStart+
 				"&subEnd="+dateSubEnd+"&firstMail="+dateFirstMail;
 			
 			const fn = function(data) {
 	    		console.log(data.msg);
 	    		// ?????? ?????? ???????????? ??????
 	    		let listUrl = "${pageContext.request.contextPath}/sub/list";
 	    		location.replace(listUrl);
 	        }
 	        
 	        ajaxFun(url, "post", query, "json", fn);
 		
		} else {
			console.log(rsp);
			if(rsp.error_msg) {
				console.log(rsp.error_msg);
			}
			return;
		}
	});
}

</script>


<div class="main-container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="fa-regular fa-credit-card"></i> ????????? ???????????? </h3>
		</div>
		
		<div class="body-main">
			<div class="row row-cols-2">
				<div class="col div-area">
					<!-- ????????? ??????  ??????-->
					<div class="col row row-cols-2 div-area1">
						<div class="col div-sub1">
							<div>????????? ??????</div>
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
										<div class="vertical"></div>
											<div class="content-card">
												<div class="content-card-sub">??? ?????????</div>
												<div class="content-card-date">1??????&nbsp;&nbsp; <span class="content-card-price">3,000???</span></div>
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
												<div class="content-card-sub">??? ?????????</div>
												<div class="content-card-date">12??????&nbsp;&nbsp; <span class="content-card-price">??? 2,000???</span></div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
					<!-- ???????????? ?????? -->
					<div class="row row-cols-2">
						<div class="col div-sub1">
							<div class="">????????????</div>
						</div>
						<div class="col div-sub2">
							<div class="col row div-input">
								<label for="exampleFormControlInput1" class="form-label">?????? ?????????</label>
								<input class="form-control form-control-lg" type="text" name="dateSubStart" id="dateSubStart"
									 class="orm-control" readonly="readonly" value="2022.12.23">
							</div>
							
							<div class="col row div-input">
								<label for="exampleFormControlInput1" class="form-label">?????? ?????????</label>
								<input class="form-control form-control-lg" type="text" name="dateSubEnd" id="dateSubEnd"
									 readonly="readonly" value="" placeholder="????????? ??????">
							</div>
							
							<div class="col row div-input">
								<label for="exampleFormControlInput1" class="form-label">??? ?????? ?????????</label>
								<input class="form-control form-control-lg" type="text" name="dateFirstMail" id="dateFirstMail"
									readonly="readonly" value="" placeholder="????????? ??????">
							</div>
						</div>
					</div>
				</div>

				<!-- ???????????? ?????? -->
				<div class="col div-area">
					<div class="col div-sub2 div-area-sub2">
						<div class="col row div-input">
							<label for="exampleFormControlInput1" class="form-label">?????? ??????</label> 
							<input class="form-control form-control-lg" type="text" name="price" id="price"
								class="orm-control" readonly="readonly" value="">
						</div>

						<div class="col row div-input">
							<label for="exampleFormControlInput1" class="form-label">?????? ?????? ??????</label> 
							<input class="form-control form-control-lg" type="text" name="totalPrice" id="totalPrice"
								readonly="readonly" value="">
						</div>

						<div class="col row div-input">
							<label class="col-sm-2 col-form-label" for="agree">?????? ??????</label>
							<div class="col-sm-8" style="padding-top: 5px;">
								<input type="checkbox" id="agree" name="agree"
									class="form-check-input" style="margin-left: 0;">
								<label class="form-check-label">
									<a href="#" class="text-decoration-none">?????? ??????</a>??? ???????????????.
								</label>
							</div>
						</div>
						<div class="div-btnPay">
							<button name="btnPay" id="btnPay" class="btn btn-primary btnPay" onclick="requestPay()"> ???????????? <i class="bi bi-check2"></i></button>
							<input type="hidden" name="" value="">
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


