<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

<style type="text/css">
.replyDisplay1{
	min-height:820px;
}
.replyDisplay2{
	min-height:820px;
}
#newsReplyitem{
	width:100%;
	cursor:pointer;
    display: flex;
}
#qnaReplyitem{
	display: flex;
	
}
#newsReplyList{
	width:910px;
}
#QnaReplyList{
	width:910px;
}
.activity-tag{
	min-height:50px;
}
span{
 	display: flex;
    justify-content: center;
    align-items: center;
	font-size: 20px;
}
</style>
<script>
$(function(){
	
})
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
<script>
$(function(){
	function deleteqnaReply(tag) {
		let url = "${pageContext.request.contextPath}/mypage/qnaReplyDelete";
		let query = "qnaAContent="+tag.text();
		console.log("qnaAContent=",tag.text());
		
		const fn = function(data){
			tag.html(data);
		};
		
		ajaxFun(url, "get", query, "html", fn);
	}
	
	$(document).on("click", "#qnaReplyitem", function(){
		if($(this).parent(".save-qnaReply") != null){
			deleteqnaReply($(this));
		}
		$(this).next("input[type='hidden']").remove();
		$(this).remove();
	});
	
	function deleteqnaReply(tag) {
		let url = "${pageContext.request.contextPath}/mypage/qnaReplyDelete";
		let query = "qnaAContent="+tag.text();
		console.log("qnaAContent=",tag.text());
		
		const fn = function(data){
			tag.html(data);
		};
		
		ajaxFun(url, "get", query, "html", fn);
	}
});
</script>
<script>
$(function(){
	$(document).on("click", "button[id='addMynewsReply_btn']", function(){
		  let addnewsReply = $("#addMynewsReply_input").val();
          let newsReplyhtml = "<span id='newsReplyitem' style='font-size:1.5rem;' class='badge bg-light text-dark'>"+addnewsReply+"</span>";
          newsReplyhtml += "<input type='hidden' name='content' value="+addnewsReply+">";

          $("#newsReplyList").append(newsReplyhtml);
          $("#addMynewsReply_input").val("");
	});
	
	$(document).on("click", "#newsReplyitem", function(){
		if($(this).parent(".save-newsReply") != null){
			deletenewsReply($(this));
		}
		$(this).next("input[type='hidden']").remove();
		$(this).remove();
	});
	
	function deletenewsReply(tag) {
		let url = "${pageContext.request.contextPath}/mypage/newsReplyDelete";
		let query = "qnaAnswer="+tag.text();
		console.log("qnaAnswer=",tag.text());
		
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
			<h3><i class="bi bi-app"></i>나의 댓글</h3>
		</div>
		<div class="body-main input-group-text replyDisplay1 d-felx flex-column">
			<form action="${pageContext.request.contextPath}/mypage/activity">
				<div style="font-size:24px;">
					나의 뉴스글 댓글
				</div>
				<div class='addMynewsReplyList input-group-text'>
				</div>
				<div id="newsReplyList" class="input-group-text  flex-wrap">
					<c:forEach var="dto" items="${list}" varStatus="status">
						<div style="display: inline-block;" class="save-newsReply">
							<div  style="display:flex; justify-content: space-between;" class="badge bg-light text-dark m-2 activity-tag" style="font-size:1.5rem;">
								<span>뉴스제목 : ${dto.Content}</span>
							</div>
							<div  style="display:flex; justify-content: space-between;"  class="badge bg-light text-dark m-2 activity-tag" style="font-size:1.5rem;">
								<span>뉴스댓글 : ${dto.content}</span>
								<button id="newsReplyitem"  type="button" class="btn btn-danger" ><i class="bi bi-x"></i></button>
							</div>
							<input type="hidden" name="content" value="${dto.content}">
							<input type="hidden" name="newsNo" value="${dto.newsNo}">
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
		<div class="body-main input-group-text replyDisplay1 d-flex flex-column">
			<form action="${pageContext.request.contextPath}/mypage/activity">
				<div style="font-size:24px;">
					나의 Qna 댓글
				</div>
				<div class='addMyqnaReplyList input-group-text'>
				&nbsp;
				</div>
				<div id="qnaReplyList" class="input-group-text flex-wrap" >
					<c:forEach var="dto" items="${QnaReplylist}" varStatus="status">
						<div style="display: inline-block;width:100%" class="save-qnaReply m-2">
							<div  style="display:flex; justify-content: space-between;"  class="badge bg-light text-dark m-2 activity-tag" style="font-size:1.5rem;">
								<span>QNA제목 : ${dto.qnaSubject}</span>
								<button id="qnaReplyitem"  type="button" class="btn btn-danger" ><i class="bi bi-x"></i></button>
							</div>
							<div  style="display:flex; justify-content: space-between;" class="badge bg-light text-dark m-2 activity-tag" style="font-size:1.5rem;">
								<span>QNA질문 : ${dto.qnaContent}</span>
							</div>
							<div  style="display:flex; justify-content: space-between;" class="badge bg-light text-dark m-2 activity-tag" style="font-size:1.5rem;">
								<span>QNA질문의 답변 : ${dto.qnaAContent}</span>
							</div>
							<input type="hidden" name="qnaNo" value="${dto.qnaNo}">
							<input type="hidden" name="qnaAContent" value="${dto.qnaAContent}">
							<input type="hidden" name="qnaAContent" value="${dto.qnaContent}">
							<input type="hidden" name="qnaAnswer" value="${dto.qnaAnswer}">
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
		
	</div>
</div>