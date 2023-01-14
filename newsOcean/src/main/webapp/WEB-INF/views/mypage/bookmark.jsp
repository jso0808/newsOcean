<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

<style type="text/css">
#bookmarkList{
display: flex;
flex-direction: column;

}
.save-bookmark{
display: flex;
flex-direction: column;
padding: 5px; 
}
#bookmarkitem{
width: 900px;
}
</style>
<script>
$(function(){
	$(document).on("click", "#bookmarkdelete", function(){
		if($(this).parent().parent(".save-bookmark") != null){//db에 있는 keywordname
			if(confirm("삭제하시겠습니까?")){
				deleteBookmark($(this).next("bookmarkNum"));
			}else{
				return;
			}
		}
		$(this).parent().parent().remove();
		$(this).next("input[name='bookmarkNum']").remove();
		$(this).next("input[name='bookmarkName']").remove();
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
				<div id="bookmarkList"  class="input-group-text">
					<c:forEach var="dto" items="${bookmarkList}" varStatus="status">
						<div class="save-bookmark" onclick="location.href='${pageContext.request.contextPath}/news/article?crawlUrl=${dto.originLink}" ><!--db저장된 키워드-->
							<div name="title" onclick="location.href='${pageContext.request.contextPath}/news/article?crawlUrl=${dto.title}" class="badge bg-light text-dark" style="font-size:1.5rem;">${dto.title}</div>
							<div class="d-flex">
								<div id="bookmarkitem" name="bookmarkName" onclick="location.href='${pageContext.request.contextPath}/news/article?crawlUrl=${dto.originLink}" class="badge bg-light text-dark" style="font-size:1.5rem;">${dto.bookmarkName}</div>
								<button id="bookmarkdelete"  type="button" class="btn btn-danger" ><i class="bi bi-x"></i></button>
								<input type="hidden" name="bookmarkNum" value="${dto.bookmarkNum}">
								<input type="hidden" name="bookmarkName" value="${dto.bookmarkName}">
							</div>
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
	</div>
</div>