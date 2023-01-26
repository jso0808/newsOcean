<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

<style type="text/css">
.replyDisplay1{
	min-height:120px;
}
.replyDisplay2{
	min-height:120px;
}
#newsReplyitem{
	width:41px;
	height:41px;
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
.badge div{
display: flex; align-items: center; 
font-size:15px;		
}
.save-newsReply{
	width:100%;
	word-break: break-all;
    word-wrap: normal;
    border-bottom: 1px solid #e1e5ef;

}
.save-qnaReply{
	width:100%;
	word-break: break-all;
    word-wrap: normal;
    border-bottom: 1px solid #e1e5ef;
}
.words{
display:flex;
flex-wrap: wrap;	
}

.activity-title{
 margin-bottom:0px;
}
.activity-content{
	margin-top:0px;
}
#qnaReplyList{
    border: none;
}
#newsReplyList{
	border: none;
}
.myTitle{
	width:910px;
	font-size:24px;
}
</style>

<script>
$(function(){
	function deleteqnaReply(tag) {
		let url = "${pageContext.request.contextPath}/mypage/qnaReplyDelete";
		let query = "qnaAnswer="+tag.val();
		console.log("qnaAnswer=",tag.val());
		
		const fn = function(data){
			tag.html(data);
		};
		
		ajaxFun(url, "get", query, "html", fn);
	}
	
	$(document).on("click", "#qnaReplyitem", function(){
		if($(this).parent().parent(".save-qnaReply") != null){
			deleteqnaReply($(this).parent().find("#qnaAnswer"));
		}
		$($(this).parent().parent()).remove();
		
	});
});
</script>

<script>
//뉴스댓글 삭제
$(function(){
	function deletenewsReply(tag) {
		let url = "${pageContext.request.contextPath}/mypage/newsReplyDelete";
		let query = "replyNo="+tag.val();
		console.log("replyNo=",tag.val());	
		
		const fn = function(data){
			tag.html(data);
		};
		
		ajaxFun(url, "get", query, "html", fn);

	}
	
	$(document).on("click", "#newsReplyitem", function(){
		if($(this).parent().parent(	".save-newsReply") != null){	
			let tag = $(this).parent().siblings("input[name=replyNo]");
			console.log("첫콘손",tag.val(), tag.text());
			deletenewsReply(tag);
		}
		$(this).parent().parent().remove();
	});
	
	
})
</script>
<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-app"></i>나의 댓글</h3>
		</div>
		
		<div class="body-main input-group-text replyDisplay1 d-felx flex-column mb-4">
			<form action="${pageContext.request.contextPath}/mypage/activity">
				<div class="myTitle">
					나의 뉴스글 댓글
				</div>
				<div id="newsReplyList" class="input-group-text  flex-wrap">
					<c:if test="${empty list}">
						<div style="display: inline-block;" class="save-newsReply">
							<div  style="display:flex; justify-content: space-between;font-size:1.5rem;" class="badge bg-light text-dark m-2 activity-tag activity-title">
								<div style="width:100%; white-space: normal;text-align: left;">뉴스글에 댓글단 이력이 없습니다.</div>
							</div>
						</div>
					</c:if>
					<c:forEach var="dto" items="${list}" varStatus="status">
						<div style="display: inline-block;" class="save-newsReply">
							<div  style="display:flex; justify-content: space-between;font-size:1.5rem;" class="badge bg-light text-dark m-2 activity-tag activity-title">
								<div style="width:100%; white-space: normal;text-align: left;">
									<a href="${pageContext.request.contextPath}/news/article?crawlUrl=${dto.originlink}">뉴스제목 : ${dto.title}</a>
								</div>
							</div>
							<div style="display:flex; justify-content: space-between;font-size:1.5rem;"  class="badge bg-light text-dark m-2 activity-tag activity-content">
								<div style="width:100%; white-space: normal;text-align: left;">
									<a href="${pageContext.request.contextPath}/news/article?crawlUrl=${dto.originlink}">뉴스댓글 : ${dto.content}</a>
								</div>
								<button id="newsReplyitem"  type="button" class="btn btn-danger" ><i class="bi bi-x"></i></button>
							</div>
							<input type="hidden" name="content" value="${dto.content}">
							<input type="hidden" name="replyNo" value="${dto.replyNo}">
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
		<c:if test="${Authority ne 'no'}">
			<div class="body-main input-group-text replyDisplay1 d-flex flex-column">
				<form action="${pageContext.request.contextPath}/mypage/activity">
					<div  class="myTitle">
						나의 Qna 댓글
					</div>
					<div id="qnaReplyList" class="input-group-text flex-wrap" >
						<c:if test="${empty QnaReplylist}">
							<div style="display: inline-block;" class="save-qnaReply">
								<div  style="display:flex; justify-content: space-between;font-size:1.5rem;" class="badge bg-light text-dark m-2 activity-tag activity-title">
									<div style="width:100%; white-space: normal;text-align: left;">Qna댓글 이력이 없습니다.</div>
								</div>
							</div>
						</c:if>
						<c:forEach var="dto" items="${QnaReplylist}" varStatus="status">
							<div style="display: inline-block;width:100%" class="save-qnaReply m-2">
								<div  style="display:flex; justify-content: space-between;font-size:1.5rem;"  class="badge bg-light text-dark m-2 activity-tag" >
									<div style="width:100%; white-space: normal;text-align: left;"><a href="${pageContext.request.contextPath}/news/article?crawlUrl=${dto.originlink}">QNA제목 : ${dto.qnaSubject}</a></div>
									<button id="qnaReplyitem"  type="button" class="btn btn-danger" ><i class="bi bi-x"></i></button>
									<input type="hidden" id="qnaAnswer" name="qnaAnswer" value="${dto.qnaAnswer}">
								</div>
								<div  style="display:flex; font-size:1.5rem;" class="badge bg-light text-dark m-2 activity-tag" >
									<div style="width:100%; white-space: normal;text-align: left;" ><a href="${pageContext.request.contextPath}/cs/qna/article?qnaNo=${dto.qnaNo}&page=" >QNA질문 : ${dto.qnaContent}</a></div>
								</div>
								<div style="display:flex; font-size:1.5rem;" class="badge bg-light text-dark m-2 activity-tag">
									<div style="width:100%; white-space: normal;text-align: left;" ><a href="${pageContext.request.contextPath}/cs/qna/article?qnaNo=${dto.qnaNo}&page=" >QNA질문의 답변 : ${dto.qnaAContent}</a></div>
								</div>
								<input type="hidden" name="qnaNo" value="${dto.qnaNo}">
								<input type="hidden" name="qnaAContent" value="${dto.qnaAContent}">
								<input type="hidden" name="qnaContent" value="${dto.qnaContent}">
							</div>
						</c:forEach>
					</div>
				</form>
			</div>
		</c:if>	
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
</script>