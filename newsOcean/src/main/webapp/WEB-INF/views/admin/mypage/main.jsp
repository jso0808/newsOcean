<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-mypage.css" type="text/css">


<div class="body-title">
	<div class="col" style="display: flex; justify-content: space-between;">

		<div class="pb-1">
			<button type="button" class="reload_btn shadow-sm" onclick="reload();">새로고침</button>
		</div>
	</div>
</div>
<div class="my__admin__title">👨‍💻 Admin account update <span class="my__admin__title2"> Detail Infomation </span> <span class="my__admin__title3"> Admin account list </span> </div> 



<div class="row">
	<div class=" body-container shadow ">
		<div class="tti__design">로그인 계정 정보 </div>
		<div class="content-frame-list "></div>
	</div>
	<div class="body-container2 shadow ">
		<div class="tti__design__detail">계정 상세 정보</div>
		<div class="content-frame-second "></div>
		<div class="content-frame-three "></div>
	</div>
	<!-- 세번째 영역 ....다른 관리자 정보 리스트  -->
	<div class=" body-container3 shadow ">
		<div class="tti__design__admin">다른 관리자 계정</div>
		<div class="content-frame-admin-list "></div>
	</div>
</div>


<!--  게시판 리스트  -->
<div class="my__board__list">📝 My Board List </div> 
<div class="row mt-3" style="margin-bottom: 50px;">
	<div class="body-container_list1 shadow ">
		<div class="tti__design__board">QnA</div>
		<div class="content-frame-qna "></div>
	</div>

	<div class="body-container_list2 shadow ">
		<div class="tti__design__board">FAQ</div>
		<div class="content-frame-faq "></div>
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

function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false,  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		contentType: false,  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
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
	listPage(1);
	listInfo(1);
	listQna(1);
	listFaq(1);
	listad(1);
	
});

//글 리스트 
function listPage(page) {
	let url = "${pageContext.request.contextPath}/admin/mypage/list";
	let query = "pageNo="+page;
	let selector = ".content-frame-list";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}

//info
function listInfo(page) {
	let url = "${pageContext.request.contextPath}/admin/mypage/info";
	let query = "pageNo="+page;
	let selector = ".content-frame-second";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}


//admin_list
function listad(page) {
	let url = "${pageContext.request.contextPath}/admin/mypage/listad";
	let query = "pageNo="+page;
	let selector = ".content-frame-admin-list";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}



//qna 답변 리스트
function listQna(page) {
	let url = "${pageContext.request.contextPath}/admin/mypage/myqna";
	let query = "pageNo="+page;
	let selector = ".content-frame-qna";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);
}


//faq 리스트
function listFaq(page) {
	let url = "${pageContext.request.contextPath}/admin/mypage/myfaq";
	let query = "pageNo="+page;
	let selector = ".content-frame-faq";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);
}



//정보 수정 폼
function updateForm(memberNo){
	let url = "${pageContext.request.contextPath}/admin/mypage/update";
	let query = "memberNo="+memberNo;
	let selector = ".content-frame-three";
	
	const fn = function(data) {
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);
	
}

//리로드
function reload() {
	listPage(1);
	listInfo(1);
	let selector = ".content-frame-three";
	
	$(selector).html("");
}

//수정 취소
function sendCancel(){
	listInfo(1);
	let selector = ".content-frame-three";
	
	$(selector).html("");
}

//정보 수정
function sendOk(){
	const f = document.mypageForm;
	let str;
	
	let url ="${pageContext.request.contextPath}/admin/mypage/update";
	let query = new FormData(f); // IE는 10이상에서만 가능
	

	const fn = function(data){
		let state = data.state;
        if(state === "false") {
            alert("개인정보 수정에 실패했습니다. ");
            return false;
        }
        
    	listPage(1);
    	listInfo(1);
    	
	};
	
	ajaxFileFun(url, "post", query, "json", fn);
	
}

function loginchange(){
	if(! confirm("로그아웃 후 해당 계정으로 로그인하시겠습니까? ")){
		return false;
	}
	
	location.href="${pageContext.request.contextPath}/member/logout";
	location.href="${pageContext.request.contextPath}/member/logout";
	
}


</script>