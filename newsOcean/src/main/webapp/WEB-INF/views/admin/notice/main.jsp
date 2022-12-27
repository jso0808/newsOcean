<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-notice.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>


<div class="body-title">
	<div class="col" style="display: flex; justify-content: space-between;">
		<div class="row">
			<div class="search--design1 p-1">
				<select name="condition" id="condition" class="form-select">
					<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
					<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
					<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
					<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
				</select>
			</div>
			<div class=" search--design2 p-1">
				<input type="text" name="keyword" id="keyword" value="${keyword}" placeholder="검색어를 입력하세요" class="form-control">
			</div>
			<div class="col p-1">
				<button type="button" class="search--design3" onclick="searchList()">검색</button>
			</div>
		</div>
		<div class="">
			<button type="button" class="upload_btn" onclick="insertForm();">글올리기</button>
			<button type="button" class="reload_btn" onclick="reloadBoard();">새로고침</button>
		</div>
	</div>
	
</div>


<div class="row">
	<div class="">
		<div class="content-frame-second shadow"></div>
	</div>

</div>


<div class="row">
	<div class="">
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

//새로고침
function reloadBoard() {
	const f = document.searchForm;
	f.condition.value = "all";
	f.keyword.value = "";
	listPage(1);
	
	let selector = ".content-frame-second";
	$(selector).html("<p></p>");
}

//검색 리스트
function searchList() {
	const f = document.searchForm;
	
	f.condition.value = $("#condition").val();
	f.keyword.value = $.trim($("#keyword").val());
	listPage(1);	
	let selector = ".content-frame-second";
	$(selector).html("");
	
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

//글 수정폼
function updateForm(companyNo, pageNo) {
	let url = "${pageContext.request.contextPath}/admin/notice/update";
	let query = "companyNo="+companyNo+"&pageNo="+pageNo;
	let selector = ".content-frame-second";
	
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
	
	const fn = function(data) {
		$(selector).html(data);
	};
	
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
		$(selector).html("<p></p>");
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