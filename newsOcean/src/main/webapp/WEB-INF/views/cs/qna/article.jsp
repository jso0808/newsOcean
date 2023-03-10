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

<script type="text/javascript">
<c:if test="${sessionScope.member.memberNo==dto.memberNo||sessionScope.member.memberShip>50}">
	function deleteQna() {
	    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    let query = "qnaNo=${dto.qnaNo}&${query}";
		    let url = "${pageContext.request.contextPath}/cs/qna/delete?" + query;
	    	location.href = url;
	    }
	}
</c:if>
</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
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
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	let url = "${pageContext.request.contextPath}/cs/qna/listAnswer";
	let query = "qnaNo=${dto.qnaNo}&pageNo="+page;
	let selector = "#listAnswer";
	
	const fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글 등록
$(function(){
	$(".btnSendAnswer").click(function(){
		let qnaNo = "${dto.qnaNo}";
		const $tb = $(this).closest("table");

		let qnaAContent = $tb.find("textarea").val().trim();
		if(! qnaAContent) {
			$tb.find("textarea").focus();
			return false;
		}
		qnaAContent = encodeURIComponent(qnaAContent);
		
		let url = "${pageContext.request.contextPath}/cs/qna/insertAnswer";
		let query = "qnaNo=" + qnaNo + "&qnaAContent=" + qnaAContent + "&qnaReply=0";
		
		const fn = function(data){
			$tb.find("textarea").val("");
			
			let state = data.state;
			if(state === "true") {
				listPage(1);
			} else if(state === "false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 삭제, 신고 메뉴
$(function(){
	$("body").on("click", ".reply-dropdown", function(){
		const $menu = $(this).next(".reply-menu");
		if($menu.is(':visible')) {
			$menu.fadeOut(100);
		} else {
			$(".reply-menu").hide();
			$menu.fadeIn(100);

			let pos = $(this).offset();
			$menu.offset( {left:pos.left-70, top:pos.top+20} );
		}
	});
	$("body").on("click", function() {
		if($(event.target.parentNode).hasClass("reply-dropdown")) {
			return false;
		}
		$(".reply-menu").hide();
	});
});

// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteAnswer", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		let qnaAnswer = $(this).attr("data-qnaAnswer");
		let page = $(this).attr("data-pageNo");
		
		let url = "${pageContext.request.contextPath}/cs/qna/deleteAnswer";
		let query = "qnaAnswer=" + qnaAnswer + "&mode=answer";
		
		const fn = function(data){
			// let state = data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글별 답글 리스트
function listReply(qnaAnswer) {
	let url = "${pageContext.request.contextPath}/cs/qna/listReply";
	let query = "qnaReply=" + qnaAnswer;
	let selector = "#listReply" + qnaAnswer;
	
	const fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function qnaAReplyCount(qnaAnswer) {
	let url = "${pageContext.request.contextPath}/cs/qna/qnaAReplyCount";
	let query = "qnaReply=" + qnaAnswer;
	
	const fn = function(data){
		let count = data.count;
		let selector = "#qnaAReplyCount"+qnaAnswer;
		$(selector).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyLayout", function(){
		const $trReplyAnswer = $(this).closest("tr").next();
		// const $trReplyAnswer = $(this).parent().parent().next();
		// const $answerList = $trReplyAnswer.children().children().eq(0);
		
		let isVisible = $trReplyAnswer.is(':visible');
		let qnaAnswer = $(this).attr("data-qnaAnswer");
			
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
            
			// 답글 리스트
			listReply(qnaAnswer);
			
			// 답글 개수
			qnaAReplyCount(qnaAnswer);
		}
	});
	
});

// 댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReply", function(){
		let qnaNo = "${dto.qnaNo}";
		let qnaAnswer = $(this).attr("data-qnaAnswer");
		const $td = $(this).closest("td");
		
		let qnaAContent = $td.find("textarea").val().trim();
		if(! qnaAContent) {
			$td.find("textarea").focus();
			return false;
		}
		qnaAContent = encodeURIComponent(qnaAContent);
		
		let url = "${pageContext.request.contextPath}/cs/qna/insertAnswer";
		let query = "qnaNo=" + qnaNo + "&qnaAContent=" + qnaAContent + "&qnaReply=" + qnaAnswer;
		
		const fn = function(data){
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state === "true") {
				listReply(qnaAnswer);
				qnaAReplyCount(qnaAnswer);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		let qnaAnswer = $(this).attr("data-qnaAnswer");
		let qnaReply = $(this).attr("data-qnaReply");
		
		let url = "${pageContext.request.contextPath}/cs/qna/deleteAnswer";
		let query = "qnaAnswer=" + qnaAnswer + "&mode=qnaReply";
		
		const fn = function(data){
			listReply(qnaReply);
			qnaAReplyCount(qnaReply);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

</script>

<div class="">
	<div class="body-container">	
		<div class="body-title">
			<h3>QNA</h3>
		</div>
		
		<div class="body-main">

			<table class="table mb-0">
				<thead>
					<tr>
						<td colspan="2" align="center">
							${dto.qnaSubject}
						</td>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td width="50%">
							이름 : ${dto.nickName}
						</td>
						<td align="right">
							${dto.qnaRegdate} | 조회 ${dto.qnaHit}
						</td>
					</tr>
					
					<tr>
						<td colspan="2" valign="top" height="200" style="border-bottom: none;">
							${dto.qnaContent}
						</td>
					</tr>
					
					<tr>
						<td colspan="2">
							이전글 :
							<c:if test="${not empty preReadQna}">
								<a href="${pageContext.request.contextPath}/cs/qna/article?${query}&qnaNo=${preReadQna.qnaNo}">${preReadQna.qnaSubject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							다음글 :
							<c:if test="${not empty nextReadQna}">
								<a href="${pageContext.request.contextPath}/cs/qna/article?${query}&qnaNo=${nextReadQna.qnaNo}">${nextReadQna.qnaSubject}</a>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="table table-borderless mb-2">
				<tr>
					<td width="50%">
						<c:choose>
							<c:when test="${sessionScope.member.memberNo==dto.memberNo}">
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/qna/update?qnaNo=${dto.qnaNo}&page=${page}';">수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-light" disabled="disabled">수정</button>
							</c:otherwise>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.memberNo==dto.memberNo || sessionScope.member.memberShip>50}">
				    			<button type="button" class="btn btn-light" onclick="deleteQna();">삭제</button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
				    		</c:otherwise>
				    	</c:choose>
					</td>
					<td class="text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/qna/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>
			
			<div class="reply">
				<c:if test="${sessionScope.member.memberShip>50}">
					<form name="replyForm" method="post">
						<div class='form-header'>
							<span class="bold">답변</span>
						</div>
						
						<table class="table table-borderless reply-form">
							<tr>
								<td>
									<textarea class='form-control' name="qnaAContent"></textarea>
								</td>
							</tr>
							<tr>
							
								   <td align='right'>
								        <button type='button' class='btn btn-light btnSendAnswer'>답변 등록</button>
								    </td>
								
							 </tr>
						</table>
					</form>
				</c:if>
				<div id="listAnswer"></div>
			</div>

		</div>
	</div>
</div>