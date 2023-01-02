<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>

</style>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-notice.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>


<div class="body-title" style="margin-bottom: 20px; border-bottom: none;" >
	<div class="col" style="display: flex; justify-content: space-between;">
		<div class="row">
			<div class="search--design1 ">
				<select name="condition" id="condition" class="form-select__search">
					<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
					<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
					<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
					<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
				</select>
			</div>
			<div class=" search--design2 ">
				<input type="text" name="keyword" id="keyword" value="${keyword}" placeholder="검색어를 입력하세요" class="form-control__search">
			</div>
			<div class="search--design2 ">
				<button type="button" class="search--design3" onclick="searchList()"><i class="fa-solid fa-magnifying-glass"></i> &nbsp;검색</button>
			</div>
		</div>
		<div class="">
			<button type="button" class="upload_btn shadow-sm" onclick="insertForm();"> + 글올리기</button>
			<button type="button" class="reload_btn shadow-sm" onclick="reloadBoard();"><i class="fa-solid fa-repeat"></i>&nbsp;&nbsp;새로고침</button>
		</div>
	</div>
</div>


<div class="notice__title"> Company Notice </div>


<!-- 게시글 본문 테이블  -->
<div class="row" >
	<div class="" style="margin-top: 10px;">
		<div class="content-frame-second shadow">
		</div>
		<div class="content-frame-reply shadow">
		</div>
	</div>
</div>


<div class="row" style="margin-top: 15px;">
	<div class="list_title">
		<div class="title__content__plus"></div>
		<div class="content-frame-list shadow"></div>
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
	clear();
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
	
	clear();
	
	ajaxFun(url, "get", query, "html", fn);

}

//새로고침
function reloadBoard() {
	const f = document.searchForm;
	f.condition.value = "all";
	f.keyword.value = "";
	listPage(1);
	
	clear();

}

function clear(){
	let selector = ".content-frame-second";
	let selector_title = ".title__content__plus";
	let selector_reply = ".content-frame-reply";
	
	$(selector).html("");
	$(selector_title).html("");
	$(selector_reply).html("");
}

//검색 리스트
function searchList() {
	const f = document.searchForm;
	
	f.condition.value = $("#condition").val();
	f.keyword.value = $.trim($("#keyword").val());
	listPage(1);	
	clear();
	
}

//글쓰기폼
function insertForm() {
	let url = "${pageContext.request.contextPath}/admin/notice/write";
	let query = "tmp="+new Date().getTime();
	let selector = ".content-frame-list";
	clear();
	
	const fn = function(data){
		$(selector).html(data);
		clear();
		
	};
	
	ajaxFun(url, "get", query, "html", fn);
}

//댓글 등록
function insertReply(companyNo) {

	let con = $("input[name='input__reply']").val();
	
	let url = "${pageContext.request.contextPath}/admin/notice/insertReply";
	let query = "companyNo="+companyNo+"&comreplycontent="+con;

	const fn = function(data){
		let state = data.state;
        if(state === "false") {
            alert("댓글 등록에 실패했습니다. ");
            return false;
        }
        
        articleBoard(companyNo, 1)
        
	};

	
	
	ajaxFun(url, "get", query, "json", fn);
}


//댓글 리스트 
function listReply(page, companyNo) {
	let url = "${pageContext.request.contextPath}/admin/notice/listReply";
	let query = "pageNo="+page+"&companyNo="+companyNo;
	
	let selector = ".content-frame-reply";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}

//댓글 삭제
function deleteReply(comreplyNo, companyNo) {
	let url = "${pageContext.request.contextPath}/admin/notice/deleteReply";
	let query = "comreplyNo="+comreplyNo;

	if( ! confirm("해당 댓글을 삭제하시겠습니까? ")) {
		return;
	}
	
	const fn = function(data) {
		articleBoard(companyNo, 1)

	};
	
	ajaxFun(url, "get", query, "json", fn);
}


//글 수정폼
function updateForm(companyNo, pageNo) {
	let url = "${pageContext.request.contextPath}/admin/notice/update";
	let query = "companyNo="+companyNo+"&pageNo="+pageNo;
	let selector = ".content-frame-list";
	clear();
	
	const fn = function(data) {
		$(selector).html(data);
		
	};
	
	ajaxFun(url, "get", query, "html", fn);
	
}


//등록, 수정완료
function sendOk(mode, pageNo) {
	const f = document.noticeForm;
	let str;
	
	str = f.companySubject.value;
	if(!str){
		alert("공지글 제목을 입력하세요.");
		f.companySubject.focus();
		return;
	}
	
	str = window.editor.getData().trim();
	if(!str){
		alert("내용을 입력하세요.");
		window.editor.focus();
		return;
	}
	
	f.companyContent.value = str;

	let url ="${pageContext.request.contextPath}/admin/notice/"+mode;
	let query = new FormData(f); // IE는 10이상에서만 가능
	
	
	const fn = function(data){
		let state = data.state;
        if(state === "false") {
            alert("게시물을 추가(수정)에 실패했습니다. ");
            return false;
        }
        
    	if(! pageNo) {
    		pageNo = "1";
    	}
    	
    	if(mode === "write") {
    		reloadBoard();
    	} else {
    		listPage(pageNo);
    	}
	};
	
	ajaxFileFun(url, "post", query, "json", fn);
}


//글 보기 ! article
function articleBoard(companyNo, page) {
	let url = "${pageContext.request.contextPath}/admin/notice/article";
	let query = "companyNo="+companyNo;
	let search = $('form[name=searchForm]').serialize();
	query = query + "&pageNo="+page + "&"+search;
	let selector = ".content-frame-second";
	let selector_title = ".title__content__plus";
	
	const fn = function(data) {
		$(selector).html(data);
		$(selector_title).html("<div class='notice__title2'>전체글 목록</div>");
		
	};
	
	listReply(1, companyNo);
	
	ajaxFun(url, "get", query, "html", fn);
}



//글 삭제
function deleteOk(companyNo) {
	let url = "${pageContext.request.contextPath}/admin/notice/delete";
	let query = "companyNo="+companyNo;
	let selector = ".content-frame-second";
	
	if( ! confirm("해당 게시글을 삭제하시겠습니까? ")) {
		return;
	}
	
	const fn = function(data) {
		reloadBoard();
		$(selector).html("");
	};
	
	ajaxFun(url, "post", query, "json", fn);
}


function deleteFile(fileNo) {
	let url = "${pageContext.request.contextPath}/admin/notice/deleteFile";
	
	$.post(url, {fileNo:fileNo}, function(data){
		$("#f"+fileNo).remove();
	}, "json");
}


//쓰기 취소, 수정 취소
function sendCancel() {
	let selector = ".content-frame-second";	
	listPage(1);
	
	$(selector).html("<p></p>");
	
}




</script>