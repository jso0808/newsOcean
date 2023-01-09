<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-member.css" type="text/css">




<div class="body-title">
	<div class="col" style="display: flex; justify-content: space-between;">

		<div class="p-1" >
				<button type="button" class="member_list_btn1 shadow-sm" onclick="location.href='${pageContext.request.contextPath}/admin/member/main';" id="list_btn1">전체 회원 목록</button>
		</div>
		<div class="p-1">
			<div >
				<button type="button" class="reload_btn shadow-sm" onclick="location.href='${pageContext.request.contextPath}/admin/member/article?memberNo=${dto.memberNo}';"><i class="fa-solid fa-repeat"></i>&nbsp;&nbsp;새로고침</button>
			</div>
		</div>
	</div>
</div>


<div class="title__member__det"> ${dto.name} 님의 회원정보 🌊 </div>

<div class="row">
	<div class="body-container__arti">
		<table class="table-mypage text-center info__st shadow-sm">
			<tbody>	
					<tr style="margin-bottom: -20px;">
						<td>
							<c:if test="${dto.gender=='F'}">
								<img class="profile__size__member " src="${pageContext.request.contextPath}/resources/images/member_img.png">	
							</c:if>
							<c:if test="${dto.gender=='M'}">
								<img class="profile__size__member " src="${pageContext.request.contextPath}/resources/images/member_img2.png">	
							</c:if>
						</td>
					</tr>
					<tr class="email__design">
						<td><span class="info__title">이메일 |</span> ${dto.email} </td>
					</tr>
					<tr>
						<td><span class="info__title">가입일 | </span>${dto.joindate}</td>
					</tr>
					<tr>
						<td><span class="info__title">구독 |</span>
							<c:if test="${dto.subtype == '12'}">
								<span style="font-family: 'line_font_b'; color: red;">&nbsp;1년권 구독중&nbsp;</span>
							</c:if>	
							<c:if test="${dto.subtype == '1'}">
								<span style="font-family: 'line_font_b'; color: red;">&nbsp;1개월 구독중&nbsp;</span>
							</c:if>	
							<c:if test="${dto.subtype == '0'}">
								<span style="font-family: 'line_font_b';">구독 없음</span>
							</c:if>
						 
						 </td>
					</tr>
					<tr>
						<td>
							<span class="btn-mypage" onclick="updateEnabled('${dto.memberNo}', '${dto.enabled}');" style="cursor: pointer;">계정 상태 변경</span>
					<input type="hidden" value="${dto.enabled}" name="enabled" id="enabled">
						</td>
					</tr>
		
			</tbody>
		
		</table>
	</div>
	<div class="body-container2__arti" >
		<table class="table__con shadow-sm tt_bold"  >
			<tr class="">
				<td class="ps-3 text-center">회원번호</td>
				<td class="ps-5 member__no">${dto.memberNo}</td>
				<td class=" text-center " >아이디</td>
				<td class=" ps-5">${dto.email}</td>
			</tr>
			<tr>
				<td class="ps-3 text-center ">이 름</td>
				<td class="ps-5">${dto.name}</td>
				<td class="text-center ">생년월일</td>
				<td class="ps-5">${dto.birth}</td>
			</tr>
			<tr>
				<td class="ps-3 text-center ">닉네임</td>
				<td class="ps-5">${dto.nickname}</td>
				<td class="text-center ">성별</td>
				<td class="ps-5">${dto.gender}</td>
			</tr>
			<tr>
				<td class="ps-3 text-center ">회원가입일</td>
				<td class="ps-5">${dto.joindate}</td>
				<td class="text-center ">최근로그인</td>
				<td class="ps-5">${dto.recentdate}</td>
			</tr>
			
			<tr >
				<td class="ps-3 text-center ">계정상태</td>
				<td class="ps-5">
					${dto.enabled==1? "<span class='state__en__yes';>활성화</span>":"<span class='state__en__no';>계정 잠금</span>"}
				</td>
				<td class="text-center ">계정신고 이력</td>
				<td class="ps-5">
					<span class="btn btn-update" onclick="complainModal()" style="cursor: pointer;">⛔ &nbsp;&nbsp; 신고 이력 조회</span>
					<input type="hidden" value="${dto.enabled}" name="enabled" id="enabled">
				</td>
			</tr>
		</table>
		
		<div  class="sub__location" style="margin-top: 20px;">
			<div class="title__member__second" style="margin-top: 20px;"> 구독 내역 </div>
				<form id="deteailedMemberForm" name="deteailedMemberForm" method="post">
					<div class="row">
					
						<c:forEach var="dto" items="${sublist}" varStatus="status">
							<table class="sub__card  " style="margin-left: 15px;">
								<tr>
									<td rowspan='3' class="icon__money"><i class="fa-solid fa-circle-dollar-to-slot"></i></td>
								</tr>
								<tr class="td__padd">
									<td class=" text-center ">구독권 정보</td>
									<td class="">
										<c:if test="${dto.subtype=='12'}"><span>1년 구독권 (12개월)</span></c:if>
										<c:if test="${dto.subtype=='1'}"><span>1개월 구독권 </span></c:if>
									</td>
								</tr>
								<tr class="td__padd">
									<td class=" text-center ">구독권 기간</td>
									<td class="">
										<c:if test="${dto.substart=='2999-01-01'}"><span></span></c:if>
										<c:if test="${dto.subtype=='1'}"><span>${dto.substart} ~ ${dto.subend } </span></c:if>
										<c:if test="${dto.subtype=='12'}"><span>${dto.substart} ~ ${dto.subend } </span></c:if>
									</td>
								</tr>
							</table>
						</c:forEach>
					</div>
					<div class="no__sub">
						<div class="pt-3">
							${dataCount == 0 ? "조회된 구독내역이 없습니다!" : paging}
						</div>
					</div>
				</form>
			</div>
		
	</div>
</div>


<div class="row ">
	<div class="title__member__second" style="margin-left: 20px; margin-top: -30px;"> 회원 활동 내역 </div> 
		<div class="body-container_list1 shadow ">
			<div class="content-frame-qna "></div>
		</div>
		<div class="body-container_list2 shadow ">
			<div class="content-frame-reply "></div>
		</div>
</div>





<!-- 신고 내역 조회 모달!! -->
<div class="modal" tabindex="-1" id="complainModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" style="font-family: 'line_font_b';">⛔ 회원 신고내역 조회 </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="table text-center">
        	<thead >
        		<tr class="modal_table_title">
        			<th>신고번호</th>
        			<th>댓글내용</th>
                	<th>신고일자</th>
        		</tr>
        	</thead>
        	<tbody>
        		<c:forEach items="${complainlist}" var="com">
	        		<tr class="modal__hover">
	        			<td>${com.complainNo}</td>
	        			<td><a href="#">${com.content}</a></td>
	        			<td>${com.complaindate}</td>
	        		</tr>
        		</c:forEach>
        	</tbody>
        </table>
        <div class="updateForm">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>






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


$(function(){
	articlesub(1);
	listReply(1);
	listQna(1);

});



//1.계정 상태 변경
//1. 계정 상태 변경
function updateEnabled(memberNo, enabled) {

	if(! confirm("계정 상태를 변경하시겠습니까?")){
		return false;
	}
	
	if(enabled == '1'){
		let url = "${pageContext.request.contextPath}/admin/member/update_en";
		let query = "memberNo="+memberNo+"&enabled=0";
	
		const fn = function(data){
			let state = data.state;
	        if(state === "false") {
	            alert("계정 상태 변경에 실패했습니다. ");
	            return false;
	        }
	        
	        articleMember(memberNo);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	} else {
		let url = "${pageContext.request.contextPath}/admin/member/update_en";
		let query = "memberNo="+memberNo+"&enabled=1";
	
		const fn = function(data){
			let state = data.state;
	        if(state === "false") {
	            alert("계정 상태 변경에 실패했습니다. ");
	            return false;
	        }
	        
	        articleMember(memberNo);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	};
	
}


//모달 
function complainModal() {
	$("#complainModal").modal('show');
	
}


//2. 구독 내역 가져오기
//상세보기 페이지- 구독내역 
function articlesub(page) {
	
	let selector = ".sub__location";
	
	let url = "${pageContext.request.contextPath}/admin/member/sublist";
	let query = "pageNo="+page+"&memberNo=${dto.memberNo}";
	
	const fn = function(data){
		$(selector).html(data);
		
	};
	
	ajaxFun(url, "get", query, "html", fn);
	
}


// 회원 활동 리스트
//상세보기 페이지 - qna 답변 리스트
function listQna(page) {
	let url = "${pageContext.request.contextPath}/admin/member/myqna";
	let query = "pageNo="+page+"&memberNo=${dto.memberNo}";
	let selector = ".content-frame-qna";

	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);
}

//상세보기 페이지 - reply 답변 리스트
function listReply(page) {
	let url = "${pageContext.request.contextPath}/admin/member/myreply";
	let query = "pageNo="+page+"&memberNo=${dto.memberNo}";
	let selector = ".content-frame-reply";

	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);
}


</script>









