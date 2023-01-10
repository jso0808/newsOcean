<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

<style type="text/css">

</style>
<script>
$(function(){
	$(document).on("click", "#bookmarkitem", function(){
		if($(this).parent(".save-bookmark") != null){//db에 있는 keywordname
			if(confirm("삭제하시겠습니까?")){
				deleteBookmark($(this).next());
			}else{
				return;
			}
		}
		$(this).next("input[type='hidden']").remove();
		$(this).remove();
	});
})
function deleteBookmark(tag) {
		let url = "${pageContext.request.contextPath}/mypage/deleteBookmark";
		let query = "bookmarkNum="+tag.val();
		console.log("bookmarkNum=",tag.val());
		
		const fn = function(data){
			tag.html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
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
<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-app"></i>북마크</h3>
		</div>
		<div class="body-main input-group-text">
			<form action="${pageContext.request.contextPath}/mypage/bookmark">
				<div id="submit_btnbox">
				<button type="submit" id="submit_btn" class="btn btn-outline-primary">저장</button>				
				</div>
				<div class='addMyBookmarkList input-group-text'>
				</div>
				<div id="bookmarkList" class="input-group-text">
					<c:forEach var="dto" items="${bookmarkList}" varStatus="status">
						<div style="display: inline-block;" class="save-bookmark"><!--db저장된 키워드-->
							<span id="bookmarkitem" name="bookmarkName" class="badge bg-light text-dark" style="font-size:1.5rem;">${dto.bookmarkName}</span>
							<input type="hidden" name="bookmarkNum" value="${dto.bookmarkNum}">
							<input type="hidden" name="bookmarkName" value="${dto.bookmarkName}">
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
	</div>
</div>