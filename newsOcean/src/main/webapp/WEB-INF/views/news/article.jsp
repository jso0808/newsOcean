<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.divNewsLikeCount {
	display: grid;
	justify-content: center;
}

.btnSendNewsLike {
	width: 50px;
}

.td-content{

}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript">
<c:if test="${sessionScope.member.memberShip>50}">
	function deleteBoard() {
	    if(confirm("삭제 하시 겠습니까 ? ")) {
		    let query = "newsNo=${dto.newsNo}&${query}";
		    let url = "${pageContext.request.contextPath}/news/delete?" + query;
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

// 뉴스글 공감 여부
$(function(){
	$(".btnSendNewsLike").click(function(){
		const $i = $(this).find("i");
		let userLiked = $i.hasClass("fa-solid fa-heart");
		let msg = userLiked ? "게시글 공감을 취소하시겠습니까 ? " : "게시글에 공감하십니까 ? ";
		
		if(! confirm( msg )) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/news/insertNewsLike";
		let newsNo = "${dto.newsNo}";
		let query = "newsNo="+newsNo+"&userLiked="+userLiked;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				if( userLiked ) {  // fa-solid fa-heart    fa-regular fa-heart
					$i.removeClass("fa-solid fa-heart").addClass("fa-regular fa-heart");
				} else {
					$i.removeClass("fa-regular fa-heart").addClass("fa-solid fa-heart");
				}
				
				let count = data.newsLikeCount;
				$("#newsLikeCount").text(count);
			} else if(state === "liked") {
				alert("공감은 한 번만 가능합니다.");
			} else if(state === "false") {
				alert("공감 여부 처리가 실패했습니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	let url = "${pageContext.request.contextPath}/news/listReply";
	let query = "newsNo=${dto.newsNo}&pageNo="+page;
	let selector = "#listReply";
	
	const fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		let newsNo = "${dto.newsNo}";
		const $tb = $(this).closest("table");

		let content = $tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		let url = "${pageContext.request.contextPath}/news/insertReply";
		let query = "newsNo=" + newsNo + "&content=" + content;
		
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
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("댓글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		let replyNo = $(this).attr("data-replyNo");
		let page = $(this).attr("data-pageNo");
		
		let url = "${pageContext.request.contextPath}/news/deleteReply";
		let query = "replyNo=" + replyNo;
		
		const fn = function(data){
			// let state = data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글 좋아요 / 싫어요
$(function(){
	// 댓글 좋아요 / 싫어요 등록
	$("body").on("click", ".btnSendReplyLike", function(){
		let replyNo = $(this).attr("data-replyNo");
		let replyLike = $(this).attr("data-replyLike");
		const $btn = $(this);
		
		let msg;
		if(replyLike === "1") {
			msg = "뉴스에 공감하십니까 ?";
		}
		
		if(! confirm(msg)) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/news/insertReplyLike";
		let query = "replyNo=" + replyNo + "&replyLike=" + replyLike;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				let likeCount = data.likeCount;
				
				$btn.parent("td").children().eq(0).find("span").html(likeCount);
			} else if(state === "liked") {
				alert("게시물 공감 여부는 한번만 가능합니다. !!!");
			} else {
				alert("게시물 공감 여부 처리가 실패했습니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

$(function() {
	$("body").on("click", ".complainReply", function(){
		let replyNo = $(this).attr("data-replyNo");
		
		let msg = "댓글을 신고하시겠습니까 ? ";
		if(! confirm(msg)) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/news/replyComplain";
		let query = "replyNo=" + replyNo;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				alert("신고 처리가 완료되었습니다.");
			} else {
				if(data.userReplyComplain) {
					alert("이미 신고한 댓글입니다.");
					return;
				} else {
					alert("신고 처리에 실패했습니다.");
				}
				
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
})

// 댓글 신고 replyComplain  "complainModal"
$(function(){
	$("body").on("click", ".btnComplainSubmit", function(){
		let replyNo = $(this).attr("data-replyNo");
		
		let msg = "댓글을 신고하시겠습니까 ? ";
		if(! confirm(msg)) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/news/replyComplain";
		let query = "replyNo=" + replyNo;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				alert("신고 처리가 완료되었습니다.");
			} else {
				if(data.userReplyComplain) {
					alert("이미 신고한 댓글입니다.");
					return;
				} else {
					alert("신고 처리에 실패했습니다.");
				}
				
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

</script>

<div class="">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-app"></i> ${dto.title} </h3>
		</div>
		
		<div class="body-main">

			<table class="table mb-0">
				<thead>
					<tr>
						<td colspan="2" align="center">
							📌카테고리명 ${dto.categoryNo}			
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							${dto.title}
						</td>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td width="50%">
							📌언론사 
						</td>
						<td align="right">
							📌업로드일 | 조회 ${dto.hitCount}
						</td>
					</tr>
					
					<tr>
						<td colspan="2" valign="top" height="200" style="border-bottom: none;">
							📌 뉴스 내용 부분
						</td>
					</tr>
					
					<tr>
						<td colspan="2" class="text-center p-3">
							<div class="divNewsLikeCount">
								<span id="newsLikeCount">${newsLikeCount}</span>
								<button type='button' class='btn btn-light btnSendNewsLike' title="좋아요"><i class="${userNewsLiked ? 'fa-solid':'fa-regular'} fa-heart"></i></button>      
							</div>
						</td>
					</tr>
					
					<tr>
						<td colspan="2">
							이전 기사 : 📌
							<c:if test="${not empty preReadDto}">
								<a href="${pageContext.request.contextPath}/news/article?${query}&newsNo=${preNewsDto.newsNo}">${preNewsDto.subject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							다음 기사 : 📌
							<c:if test="${not empty nextReadDto}">
								<a href="${pageContext.request.contextPath}/news/article?${query}&newsNo=${nextNewsDto.newsNo}">${nextNewsDto.subject}</a>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="table table-borderless mb-2">
				<tr>
					<td width="50%">
						<c:choose>
							<c:when test="${sessionScope.member.memberShip > 50}">
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/news/update?newsNo=${dto.newsNo}&page=${page}';">수정</button>
							</c:when>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.memberShip > 50}">
				    			<button type="button" class="btn btn-light" onclick="deleteNews();">삭제</button>
				    		</c:when>
				    	</c:choose>
					</td>
					<td class="text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/news/list?${query}';">리스트</button>
					</td>
				</tr>
				
			
			</table>
			
			<div class="reply">
				<form name="replyForm" method="post">
					<div class='form-header'>
						<span class="bold">댓글</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
					</div>
					
					<table class="table table-borderless reply-form">
						<tr>
							<td>
								<textarea class='form-control' name="content"></textarea>
							</td>
						</tr>
						<tr>
						   <td align='right'>
						        <button type='button' class='btn btn-light btnSendReply'>댓글 등록</button>
						    </td>
						 </tr>
					</table>
					<input type="hidden" name="newsNo" id="newsNo" value="${dto.newsNo}">
				</form>
				
				<div id="listReply"></div>
			</div>
			
			<!-- 신고 모달 start -->
			<div class="modal fade" id="complainModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="exampleModalLabel">댓글 신고하기</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <input type="text" class="form-control" name="complain" id="complain" placeholder="신고 사유">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary btnComplainSubmit">신고하기</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- 신고 모달 end -->
			

		</div>
	</div>
</div>