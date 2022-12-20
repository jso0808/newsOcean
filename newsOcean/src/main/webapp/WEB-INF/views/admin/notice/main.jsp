<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-notice.css" type="text/css">


<div class="body-title ">
	<div><i class="bi bi-clipboard"></i> 공지사항 </div>
</div>

<div class="row">
	<div class="col-6">
		<div class=" content-frame-list" style="border: 1px solid #000">
			리스트
		</div>
	</div>

	<div class="col-6">
		<div class="content-frame-second" style="border: 1px solid #000">
				글보기
		</div>
	</div>
</div>


<form name="searchForm" action="" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>

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
	listPage(1);
});

//글 리스트 

function listPage(page) {
	let url = "${pageContext.request.contextPath}/admin/notice/list";
	let query = "pageNo="+page;
	let search = $('form[name=searchForm]').serialize();
	query = query+"&"+search;
	let selector = ".content-frame-list";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}


//글쓰기폼
function insertForm() {
	let url = "${pageContext.request.contextPath}/admin/notice/write";
	let query = "tmp="+new Date().getTime();
	let selector = ".content-frame-second";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);
}


//등록, 수정완료
function sendOk(mode, page) {
	const f = document.noticeForm;
	let str;
	
	let url ="${pageContext.request.contextPath}/admin/notice/"+mode;
	let query = new FormData(f); // IE는 10이상에서만 가능
	
	const fn = function(data){
		let state = data.state;
        if(state === "false") {
            alert("게시물을 추가(수정)에 실패했습니다. ");
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




</script>