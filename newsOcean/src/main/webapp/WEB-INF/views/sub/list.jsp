<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt" %>

<style type="text/css">
.body-container {
	max-width: 800px;
	max-height: 1200px;
}

.body-main {
	padding-top: 30px;
}

.area-title{
	border-top: 100px;
	font-size: 30px;
	text-align: center;
	margin-bottom: 50px;
	margin-top: 50px;
}

.container-card {
  width: 100%;
  height: 100vh;
  justify-content: center;
  align-items: center;
  display: flex;
}

.div-subList {
	height: 100%;
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

.card:hover {
	background: #4FC4F7
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
    align-items: flex-start;
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

.div-area1 {
	margin-bottom: 50px;
}

.subType {
	font-size: 20px;
	padding-bottom: 8px;
}

.btn-card {
	margin-bottom: 50px;
}

.div-subIng {

}

.div-subEnd {

}

			
.modal-merchant_uid, .modal-paid_at, .modal-subType, .modal-subStart, 
	.modal-subEnd, .modal-firstMail {
	font-size: 17px;
	border-bottom: 10px;
}

#subPayInfoModalContent {
	font-size: 17px;
}					

.modal-paid_amount {
	font-size: 25px;
}

.btnSearch {
	border-color: gray;
}

.div-dataCount {
	font-size: 20px;
}

.modal-body {
	margin: 15px;
}

.modal-footer {
	display: flex;
    flex-direction: column;
    align-content: flex-end;
    align-items: flex-end;
}

.dataCount {
	font-size: 27px;
	color: #033EAB;
}

.div-content-list {
	padding-bottom: 7px;
}

.modal-btnRefund {
	display: flex;
    justify-content: flex-end;
}

.div-subRefund {
	
}

</style>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.2.0/css/all.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/paginate-boot.js"></script>

<script type="text/javascript">
window.addEventListener("load", function(){
	let page = ${page};
	let pageSize = ${size};
	let dataCount = ${dataCount};
	let url = "${listUrl}"; 
	
	let total_page = pageCount(dataCount, pageSize);
	let paging = pagingUrl(page, total_page, url);

	document.querySelector(".page-navigation").innerHTML = 
		dataCount === 0 ? "????????? ???????????? ????????????." : paging;
});

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("?????? ????????? ??????????????????.");
				return false;
			}
			
			console.log(jqXHR.responseText);
		}
	});
}

// ????????? ?????? ???????????? ?????? ?????? subInfoModal
$(function() {
	
	$(".card").on("click", function() {
		
		let subNo = $(this).find("input[name=subNo]").val(); 
		let merchant_uid = $(this).find("input[name=merchant_uid]").val(); // ????????????
		let imp_uid = $(this).find("input[name=imp_uid]").val(); // ????????????
		let refundOrNot = $(this).find("input[name=refundOrNot]").val(); // ??????
	
		// ????????? ?????? ?????? ?????? ajax??? ????????????
		let url = "${pageContext.request.contextPath}/sub/subPayInfo";
 		let query= "imp_uid="+imp_uid+"&subNo="+subNo;
 			
 		const fn = function(info) {
 			
 			info.paid_amount = (info.paid_amount).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
 			
 			var html_content = '';
 			html_content += '<div class="modal-paid_at div-content-list">?????????: '+info.paid_at+'</div>';
 			html_content += '<div class="modal-merchant_uid div-content-list merchant_uid">?????? ??????: '+info.merchant_uid+'</div>';

 			html_content += '<div class="modal-subType div-content-list">????????? ??????: '+info.subType+'?????? ?????????</div>';
 			html_content += '<div class="modal-subStart div-content-list">?????? ?????????: '+info.subStart+'</div>';
 			html_content += '<div class="modal-subEnd div-content-list">?????? ?????????: '+info.subEnd+'</div>';
 			html_content += '<div class="modal-firstMail div-content-list">??? ?????? ?????????: '+info.firstMail+'</div>';
 			html_content += '<input type="hidden" class="modal-input-subNo" value="'+info.subNo+'">';
 			html_content += '<input type="hidden" class="modal-input-paid_amount" value="'+info.paid_amount+'">';
 		     
	 	    var html_amount = '';
	 	    html_amount += '<div class="modal-paid_amount div-content-list" value="'+info.paid_amount+'"> ?????? ?????? ??????: '+info.paid_amount+'???</div>';
	 	    
	 		// ??????????????? ??? ?????? ????????? ???????????? ?????? ??????
	 	    $(".modal-btnRefund").empty();
	 	    if(info.firstMailOrNot === 1 && info.refundOrNot === 0) {
	 	    	let html_btnRefund = '';
	 	    	html_btnRefund += '<button type="button" class="btn btn-secondary btnRefund" name="btnRefund" id="btnRefund" data-bs-dismiss="modal">????????????</button>';
	 	    
		 	    $(".modal-btnRefund").append(html_btnRefund);
	 	    }
	 		
	 	   	$("#subPayInfoModalContent").empty();
	 	    $("#subPayInfoModalContent").append(html_content);
	 	    
	 	    $(".modal-paid_amount").empty();
	 	    $(".modal-paid_amount").append(html_amount);
	 	    
		 	// ????????? ??????
		 	$("#subInfoModal").modal("show");	
 	    		
 	    }
 	        ajaxFun(url, "post", query, "json", fn);
	});
});


// ?????? ?????? ????????? ????????? input ??? ??????
$(function() {
	$("#selectSub").click(function() {
		let selectSub = $("#selectSub").find("option:selected").val();
		$("input[name=selectSubType]").attr("value", selectSub);
		let test = $("input[name=selectSubType]").val();
	});
});

// ?????? ?????? ?????? ?????? ??????
function searchList() {
	const f = document.searchForm;
	f.submit();
}

// ?????? ?????? ?????? btnRefund
$(function() {
	$(document).on("click", ".btnRefund", function() {
		// insertSubRefund
		
		if(! confirm('????????? ???????????? ???????????????????????? ? ')) {
		return;
		}
		
		let subNo = $(".modal-input-subNo").val(); // ????????????
		let paid_amount = $(".modal-input-paid_amount").val();
		paid_amount = paid_amount.replace(",","");
		
		console.log(subNo);
		console.log(paid_amount);
		
		// ????????? ?????? ?????? ?????? ajax??? ????????????
		let url = "${pageContext.request.contextPath}/sub/insertSubRefund";
 		let query= "subNo="+subNo+"&paid_amount="+paid_amount;
 			
 		const fn = function(data) {
 			
 			if(data.state === "true") {
 				let listUrl = "${pageContext.request.contextPath}/sub/list";
 	    		location.replace(listUrl);
 			} else {
 				alert("?????? ????????? ??????????????????.");
 			}
 	    		
 	    }
 	    ajaxFun(url, "post", query, "json", fn);
		
	});
	
})

</script>


<div class="main-container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="fa-solid fa-basket-shopping"></i> ????????? ?????? </h3>
		</div>
		
		<div class="body-main">
			<!-- ????????? ?????????, ????????? ?????? -->
			<div class="row div-area1">
				<div class="col-8">
					<div class="div-dataCount">?????? ?????? ???:<span class="dataCount">&nbsp;&nbsp;${dataCount}&nbsp;</span> ???</div>
				</div>
				<div class="col-3">
					<form class="row" name="searchForm" action="${pageContext.request.contextPath}/sub/list" method="post">
						<div>
							<select class="form-select" id="selectSub" name="selectSub">
								<option selected="selected" value="0">??????</option>
								<option value="1">1?????????</option>
								<option value="12">12?????????</option>
							</select>
						</div>
						<input type="hidden" name="selectSubType" id="selectSubType" value="">
						<input type="hidden" name="memberNo" id="memberNo" value="${sessionScope.member.memberNo}">
					</form>
				</div>
				<div class="col-1">
					<button type="button" class="btn btnSearch" onclick="searchList()"><i class="fa-solid fa-magnifying-glass"></i></button>
				</div>
			</div>
			
			<!-- ????????? ????????? -->
			<div class="row div-area2">
				<div class="div-subList">
					<c:forEach var="dto" items="${list}">
						<div class="card btn btn-card">
							<div class="main">
								<div class="co-img">
									<c:if test="${dto.subType == 1}">
										<img class="img-circle"
											src="${pageContext.request.contextPath}/resources/images/logo_circle_gray.png"
											alt="" />
									</c:if>
									<c:if test="${dto.subType == 12}">
										<img class="img-circle"
											src="${pageContext.request.contextPath}/resources/images/logo_circle.png"
											alt="" />
									</c:if>
								</div>
								<div class="vertical"></div>
								<div class="content-card">
									<div class="subType">${dto.subType}?????? ?????????</div>
									<div class="merchant_uid">????????????: ${dto.merchant_uid}</div>
									<div class="subDate">
										${dto.subStart} ~ ${dto.subEnd}
									</div>
									<c:if test="${dto.refundOrNot == 1}">
										<div class="div-subRefund">??????</div>
									</c:if>
									<c:if test="${dto.endOrNot == 1 && dto.refundOrNot == 0}">
										<div class="div-subIng">?????? ???</div>
									</c:if>
									<c:if test="${dto.endOrNot == -1 && dto.refundOrNot == 0}">
										<div class="div-subEnd">?????? ??????</div>
									</c:if>
									<input type="hidden" name="subNo" value="${dto.subNo}">
									<input type="hidden" name="imp_uid" value="${dto.imp_uid}">
									<input type="hidden" name="merchant_uid" value="${dto.merchant_uid}">
									<input type="hidden" name="refundOrNot" value="${dto.refundOrNot}"> 
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				
			</div>
		</div>
		
		<div class="page-navigation"></div>
		
		<!-- ?????? ???????????? ????????? start -->
		<div class="modal" id="subInfoModal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">?????? ?????? ??????</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>

					<div class="modal-body">
						<div id="subPayInfoModalContent"></div>
						<div class="modal-paid_amount"></div>
						<div class="modal-btnRefund"></div>
					</div>
					
				</div>
				<div class="modal-footer">
				</div>
			</div>
		</div>
		<!-- ?????? ???????????? ????????? end -->
	
	</div>
</div>

