<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-member.css" type="text/css">


<style type="text/css">

</style>

<div class="body-title">
	<div class="col" style="display: flex; justify-content: space-between;">

		<div class="p-1" >
				<button type="button" class="member_list_btn1 shadow-sm" onclick="listPage(1)" id="list_btn1">전체 회원 목록</button>
				<button type="button" class="member_list_btn1 shadow-sm" onclick="listSubpage(1)" id="list_btn2">유료 구독 회원 목록</button>
				<button type="button" class="member_list_btn1 shadow-sm" onclick="listEnpage(1)" id="list_btn3">계정 비활성화 회원</button>
		</div>
		<div class="p-1">
			<div >
				<button type="button" class="reload_btn shadow-sm" onclick="reload();">새로고침</button>
			</div>
		</div>
	</div>
</div>




<div class="row">
	<div class="main__left">
		<div class="content-frame-list "></div>
	</div>
</div>


<div class="row mt-3">
	<div class="body-container_list1 shadow ">
		<div class="content-frame-qna "></div>
	</div>
	<div class="body-container_list2 shadow ">
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
	$("#list_btn1").addClass("member_list_btn1__click");
	
});

//회원 리스트 
function listPage(page) {
	let url = "${pageContext.request.contextPath}/admin/member/list";
	let query = "pageNo="+page;
	let selector = ".content-frame-list";
	
	$("#list_btn1").addClass("member_list_btn1__click");
	$("#list_btn2").removeClass("member_list_btn1__click");
	$("#list_btn3").removeClass("member_list_btn1__click");
	
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}


//유료 회원 리스트 
function listSubpage(page) {
	let url = "${pageContext.request.contextPath}/admin/member/listSub";
	let query = "pageNo="+page;
	let selector = ".content-frame-list";
	
	$("#list_btn2").addClass("member_list_btn1__click");
	$("#list_btn1").removeClass("member_list_btn1__click");
	$("#list_btn3").removeClass("member_list_btn1__click");
	
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}


//계정 비활성화 회원 리스트 
function listEnpage(page) {
	let url = "${pageContext.request.contextPath}/admin/member/listEn";
	let query = "pageNo="+page;
	let selector = ".content-frame-list";
	
	$("#list_btn3").addClass("member_list_btn1__click");
	$("#list_btn1").removeClass("member_list_btn1__click");
	$("#list_btn2").removeClass("member_list_btn1__click");
	
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}


//리로드
function reload() {
	listPage(1);
	$("#list_btn1").addClass("member_list_btn1__click");

}

//상세보기 페이지 
function articleMember(memberNo) {
	let url = "${pageContext.request.contextPath}/admin/member/article";
	let query = "memberNo="+memberNo;
	let selector = ".content-frame-list";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);
	
}

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







</script>