<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

<style type="text/css">

</style>

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
</script>
<script>
$(function(){
	$(document).on("click", "button[id='addMyKeyword_btn']", function(){
		let addKeyword = $("#addMykeyword_input").val();
        let keywordhtml = "<span id='keyworditem' style='font-size:1.5rem;' class='badge bg-light text-dark'>"+addKeyword+"</span>";
        keywordhtml += "<input type='hidden' name='keywordName' value="+addKeyword+">";
		if(!confirm("키워드"+addKeyword+"를 추가하시겠습니까?")){
			return;
		}
        //<input type="hidden" name="keywordNo" value="${dto.keywordNo}">
		//<input type="hidden" name="keywordName" value="${dto.keywordName}">
        
        
   		let url = "${pageContext.request.contextPath}/mypage/addkeyword";
   		let query = "keywordName="+addKeyword;
   		console.log("keywordName=",addKeyword);
   		
   		const fn = function(data){
   			$("#keywordList").append(keywordhtml);
   	        $("#addMykeyword_input").val("");
   		};
   		
   		ajaxFun(url, "post", query, "html", fn);

	});
	
	$(document).on("click", "#keyworditem", function(){
		if(!confirm("키워드"+$(this).val()+"를 삭제하시겠습니까?")){
			return;
		}
		if($(this).parent(".save-keyword") != null){//db에 있는 keywordname
			deleteKeyword($(this));
		}
		$(this).next("input[type='hidden']").remove();
		$(this).remove();
	});
	
	function deleteKeyword(tag) {
		let url = "${pageContext.request.contextPath}/mypage/keywordDelete";
		let query = "keywordName="+tag.text();
		console.log("keywordName=",tag.text());
		
		const fn = function(data){
			tag.html(data);
		};
		
		ajaxFun(url, "get", query, "html", fn);

	}
})
</script>
<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-app"></i>키워드</h3>
		</div>
		<div class="body-main input-group-text">
			<form name ="keywordForm" action="${pageContext.request.contextPath}/mypage/keyword" method="post">
				<div class='addMyKeywordList input-group-text'>
					<input type='text' id="addMykeyword_input">
					<button class='btn btn-light' type="button" id='addMyKeyword_btn'>나의 키워드 추가</button>
				</div>
				<div id="keywordList" class="input-group-text">
					<c:forEach var="dto" items="${keywordList}" varStatus="status">
						<div style="display: inline-block;" class="save-keyword"><!--db저장된 키워드-->
							<span id="keyworditem" class="badge bg-light text-dark" style="font-size:1.5rem;">${dto.keywordName}</span>
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
	</div>
</div>