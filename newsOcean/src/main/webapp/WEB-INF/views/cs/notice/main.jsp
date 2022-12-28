<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-clipboard"></i> 공지사항 </h3>
		</div>
		
		<div class="body-main content-frame">
		</div>
	</div>
</div>

<form name="searchForm" action="" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>

<script type="text/javascript">
function login() {
	location.href = "${pageContext.request.contextPath}/member/login";
}

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
});

// 글리스트
function listPage(page) {
	let url = "${pageContext.request.contextPath}/cs/notice/list";
	let query = "pageNo="+page;
	let search = $('form[name=searchForm]').serialize();
	query = query+"&"+search;
	let selector = ".content-frame";
	
	const fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 새로고침
function reloadBoard() {
	const f = document.searchForm;
	f.condition.value = "all";
	f.keyword.value = "";
	
	listPage(1);
}

function searchList() {
	const f = document.searchForm;
	
	f.condition.value = $("#condition").val();
	f.keyword.value = $.trim($("#keyword").val());
	listPage(1);
}

// 게시글 보기
function articleBoard(num, page) {
	let url = "${pageContext.request.contextPath}/cs/notice/article";
	let query = "noticeNo="+noticeNo;
	let search = $('form[name=searchForm]').serialize();
	query = query+"&pageNo="+page+"&"+search;
	let selector = ".content-frame";
	
	const fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

<c:if test="${sessionScope.member.membership>50}">
	// 글쓰기 폼
	function insertForm() {
		let url = "${pageContext.request.contextPath}/cs/notice/write";
		let query = "tmp="+new Date().getTime();
		let selector = ".content-frame";
		
		const fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}

	// 글 수정폼
	function updateForm(num, page) {
		let url = "${pageContext.request.contextPath}/cs/notice/update";
		let query = "noticeNo="+noticeNo+"&pageNo="+page;

		let selector = ".content-frame";
		const fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}

	// 등록 완료, 수정 완료
	function sendOk(mode, page) {
	    const f = document.noticeForm;
	    let str;
	    
		str = f.noticeSubject.value;
	    if(!str) {
	        alert("제목을 입력하세요. ");
	        f.noticeSubject.focus();
	        return;
	    }
	
		str = f.noticeContent.value;
	    if(!str) {
	        alert("내용을 입력하세요. ");
	        f.noticeContent.focus();
	        return;
	    }
	    
	    let url ="${pageContext.request.contextPath}/cs/notice/"+mode;
	    let query = new FormData(f); // IE는 10이상에서만 가능
	    
		const fn = function(data){
			let state = data.state;
	        if(state === "false") {
	            alert("게시물을 추가(수정)하지 못했습니다. !!!");
	            return false;
	        }
	        
	    	if(! page) {
	    		page = "1";
	    	}
	    	
	    	if(mode === "write") {
	    		reloadBoard()
	    	} else {
	    		listPage(page);
	    	}
		};
		
		ajaxFileFun(url, "post", query, "json", fn);
	}
	
	// 글쓰기 취소, 수정 취소
	function sendCancel(page) {
		if( ! page ) {
			page = "1";
		}
		
		listPage(page);
	}
	
	// 글 삭제
	function deleteOk(noticeNo, page) {
		let url = "${pageContext.request.contextPath}/cs/notice/delete";
		let query = "noticeNo="+noticeNo;
		
		if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
			  return;
		}
		
		const fn = function(data){
			listPage(page);
		};
		ajaxFun(url, "post", query, "json", fn);
	}
</c:if>
</script>

