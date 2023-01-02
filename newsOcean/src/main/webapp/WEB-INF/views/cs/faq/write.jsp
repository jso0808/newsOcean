<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.table-category input, .table-category select {
	border: none;
}
.table-category input:disabled, .table-category select:disabled {
	background: #f8f9fa; text-align: center;
}

.table-category th, .table-category td {
	border: 1px solid #eee;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript">
function sendOk() {
    const f = document.faqForm;

    if(! f.categoryNum.value) {
        alert("카테고리를 선택하세요. ");
        f.categoryNum.focus();
        return;
    }
    
	let str = f.faqSubject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.faqSubject.focus();
        return;
    }

	str = f.faqContent.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.faqContent.focus();
        return;
    }
    
    f.action="${pageContext.request.contextPath}/cs/faq/${mode}";
    f.submit();
}
</script>

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
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	// 카테고리 수정 대화상자
	$("body").on("click", ".btnCategoryDialog", function(){
		$("form[name=categoryForm]").each(function(){
			this.reset();
		});
		
		$("#myDialogModal").modal("show");
	});
	
	
	var myModalEl = document.getElementById('myDialogModal');
	
	// 모달이 show 될 때
	myModalEl.addEventListener('show.bs.modal', function (event) {
		var url="${pageContext.request.contextPath}/cs/faq/listAllCategory?tmp="+(new Date()).getTime();
		$(".category-list").load(url);
	});
	
	// 모달이 hide 될 때
	myModalEl.addEventListener('hide.bs.modal', function (event) {
		  $("form[name=faqForm] select[name=categoryNum]").find('option').remove();

		  var url="${pageContext.request.contextPath}/cs/faq/listCategory";
		  var query="mode=enabled";
			
		  var fn=function(data) {
				$.each(data.listCategory, function(index, item){
					var categoryNum = item.categoryNum;
					var category = item.category;
					var s = "<option value='"+categoryNum+"'>"+category+"</option>";
					$("form[name=faqForm] select[name=categoryNum]").append(s);
				});
				
				var mode="${mode}";
				if(mode=="update") {
					$("form[name=faqForm] select[name=categoryNum]").val("${dto.categoryNum}");
				}
		  };
		  ajaxFun(url, "get", query, "json", fn);
	});
	
});

$(function(){
	// 카테고리 등록
	$("body").on("click", ".btnCategoryAddOk", function(){	
		var $tr=$(this).closest("tr");
		var category = $tr.find("input[name=category]").val().trim();
		var enabled = $tr.find("select[name=enabled]").val().trim();
		var orderNo = $tr.find("input[name=orderNo]").val().trim();
		
		if(! category) {
			$tr.find("input[name=category]").focus();
			return false;
		}
		
		if(! /^[0-9]+$/.test(orderNo)) {
			$tr.find("input[name=orderNo]").focus();
			return false;
		}
		
		category = encodeURIComponent(category);
		var url="${pageContext.request.contextPath}/cs/faq/insertCategory";
		var query="category="+category+"&enabled="+enabled+"&orderNo="+orderNo;
		
		var fn = function(data){
			// var state=data.state;
			$("form[name=categoryForm]").each(function(){
				this.reset();
			});
			
			url = "${pageContext.request.contextPath}/cs/faq/listAllCategory?tmp="+(new Date()).getTime();
			$(".category-list").load(url); 
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});

	// 카테고리 수정
	$("body").on("click", ".btnCategoryUpdate", function(){	
		var $tr = $(this).closest("tr");
		$tr.find("input").prop("disabled", false);
		$tr.find("select").prop("disabled", false);
		
		$tr.find(".btnCategoryUpdate").hide();
		$tr.find(".btnCategoryDeleteOk").hide();

		$tr.find(".btnCategoryUpdateOk").show();
		$tr.find(".btnCategoryUpdateCancel").show();
	});

	// 카테고리 수정 완료
	$("body").on("click", ".btnCategoryUpdateOk", function(){	
		var $tr=$(this).closest("tr");
		var categoryNum = $tr.find("input[name=categoryNum]").val();
		var category = $tr.find("input[name=category]").val().trim();
		var enabled = $tr.find("select[name=enabled]").val().trim();
		var orderNo = $tr.find("input[name=orderNo]").val().trim();
		
		if(! category) {
			$tr.find("input[name=category]").focus();
			return false;
		}
		
		if(! /^[0-9]+$/.test(orderNo)) {
			$tr.find("input[name=orderNo]").focus();
			return false;
		}
		
		category = encodeURIComponent(category);
		var url = "${pageContext.request.contextPath}/cs/faq/updateCategory";
		var query = "categoryNum="+categoryNum+"&category="+category+"&enabled="+enabled+"&orderNo="+orderNo;
		
		var fn = function(data){
			var state = data.state;
			if(state === "false") {
				alert("카테고리 삭제가 불가능합니다.");
				return false;
			}
			
			url = "${pageContext.request.contextPath}/cs/faq/listAllCategory?tmp="+(new Date()).getTime();
			$(".category-list").load(url); 
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});

	// 카테고리 수정 취소
	$("body").on("click", ".btnCategoryUpdateCancel", function(){	
		var $tr = $(this).closest("tr");
		$tr.find("input").prop("disabled", true);
		$tr.find("select").prop("disabled", true);
		
		$tr.find(".btnCategoryUpdateOk").hide();
		$tr.find(".btnCategoryUpdateCancel").hide();

		$tr.find(".btnCategoryUpdate").show();
		$tr.find(".btnCategoryDeleteOk").show();
	});

	// 카테고리 삭제
	$("body").on("click", ".btnCategoryDeleteOk", function(){
		if(! confirm("카테고리를 삭제 하시겠습니까 ?")) {
			return false;
		}
		
		var $tr = $(this).closest("tr");
		var categoryNum = $tr.find("input[name=categoryNum]").val();
		
		var url = "${pageContext.request.contextPath}/cs/faq/deleteCategory";
		var query = "categoryNum="+categoryNum;
		
		var fn = function(data){
			url = "${pageContext.request.contextPath}/cs/faq/listAllCategory?tmp="+(new Date()).getTime();
			$(".category-list").load(url); 
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-question-octagon"></i> 자주하는 질문 </h3>
		</div>
		
		<div class="body-main">
		
			<form name="faqForm" method="post">
				<table class="table mt-5 write-form">
					<tr>
						<td class="table-light col-sm-2" scope="row">카테고리</td>
						<td>
							<div class="row">
								<div class="col-sm-4 pe-1">
									<select name="categoryNum" class="form-select">
										<c:forEach var="vo" items="${listCategory}">
											<option value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.category}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-2" scope="row">제 목</td>
						<td>
							<input type="text" name="faqSubject" class="form-control" value="${dto.faqSubject}">
						</td>
					</tr>
        
					<tr>
						<td class="table-light col-sm-2" scope="row">작성자명</td>
 						<td>
							<p class="form-control-plaintext">${sessionScope.member.nickName}</p>
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td>
							<textarea name="faqContent" id="faqContent" class="form-control">${dto.faqContent}</textarea>
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/faq/main?pageNo=${pageNo}';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="faqNo" value="${dto.faqNo}">
								<input type="hidden" name="pageNo" value="${pageNo}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">카테고리 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		
				<form name="categoryForm" method="post">
					<table class="table table-borderless table-category">
						<thead class="table-light">
							<tr class="border-top border-bottom text-center"> 
								<th width="150">카테고리</th>
								<th width="110">활성</th>
								<th width="80">출력순서</th>
								<th>변경</th>
							</tr>
						</thead>
						<tbody>
							<tr align="center">
								<td class="p-0"> <input type="text" name="category" class="form-control"> </td>
								<td class="p-0">
									<select name="enabled" class="form-select">
										<option value="1">활성</option>
										<option value="0">비활성</option>
									</select>
								</td>
								<td class="p-0"> <input type="text" name="orderNo" class="form-control"> </td>
								<td class="p-0"> <button type="button" class="btn btnCategoryAddOk">등록하기</button> </td>
							</tr>
						</tbody>
						<tfoot class="category-list"></tfoot>
					</table>
				</form>
        		
			</div>
		</div>
	</div>
</div>