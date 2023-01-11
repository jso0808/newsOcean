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

.divReplyLikeCount {
	display: flex;
	align-items: flex-end;
    justify-content: flex-end;
}


.btnSendNewsLike {
	width: 50px;
}

.bookMark {
	display: flex;
    justify-content: flex-end;
}

.btnBookMark {
	display: flex;
	justify-content: flex-end;
}


</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

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
		let userNewsLiked = $i.hasClass("fa-solid fa-heart");
		let msg = userNewsLiked ? "게시글 공감을 취소하시겠습니까 ? " : "게시글에 공감하십니까 ? ";
		
		if(! confirm( msg )) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/news/insertNewsLike";
		let newsNo = "${dto.newsNo}";
		let query = "newsNo="+newsNo+"&userNewsLiked="+userNewsLiked;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				if( userNewsLiked ) {  // fa-solid fa-heart    fa-regular fa-heart
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

// 댓글 좋아요 / 좋아요 취소
$(function(){
	$("body").on("click", ".btnSendReplyLike", function(){
		const $i = $(this).find("i");
		const $span = $(this).find("span");
		let userReplyLiked = $i.hasClass("fa-solid fa-heart");
		
		let replyNo = $(this).attr("data-replyNo");
		let replyLike = $(this).attr("data-replyLike");
		
		console.log(replyNo);
		console.log(replyLike);
		
		let msg = userReplyLiked ? "댓글 공감을 취소하시겠습니까 ? " : "댓글에 공감하시겠습니까 ? ";
	
		if(! confirm(msg)) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/news/insertReplyLike";
		let query = "replyNo=" + replyNo + "&userReplyLiked=" + userReplyLiked;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				if( userReplyLiked ) {  // fa-solid fa-heart    fa-regular fa-heart
					$i.removeClass("fa-solid fa-heart").addClass("fa-regular fa-heart");
				} else {
					$i.removeClass("fa-regular fa-heart").addClass("fa-solid fa-heart");
				}
				
				let likeCount = data.likeCount;
				$span.text(likeCount);
			} else if(state === "liked") {
				alert('댓글 공감을 취소했습니다.');
			} else {
				alerr('댓글 공감을 등록했습니다.')
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글 숨김/해제 기능
$(function(){
	$("body").on("click", ".replyShowHide", function(){
		let $menu = $(this);
		
		let replyNo = $(this).attr("data-replyNo");
		let showHide = $(this).attr("data-showHide");
		
		let msg = "댓글을 숨김 하시겠습니까 ? ";
		if(showHide === "0") {
			msg = "댓글 숨김을 해제 하시겠습니까 ? ";
		}
		if(! confirm(msg)) {
			return false;
		}
		
		showHide = showHide === "0" ? "-1" : "0";
		
		let url = "${pageContext.request.contextPath}/news/replyShowHide";
		let query = "replyNo=" + replyNo + "&showHide="+showHide;
		
		const fn = function(data){
			if(data.state === "true") {
				let $item = $menu.closest("tr").next("tr").find("td"); // 내용

				console.log($item);
				if(showHide === "0") {
					$item.removeClass("text-primary").removeClass("text-opacity-50");
					$menu.attr("data-showHide", "0");
					$menu.html("숨김");
				} else {
					$item.addClass("text-primary").addClass("text-opacity-50");
					$menu.attr("data-showHide", "-1");
					$menu.html("표시");
				}
			}
			
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


// 댓글 신고하기: 신고 버튼 클릭 시 신고 내용 작성 모달(complainModal) 띄우기
$(function() {
	$("body").on("click", ".complainReply", function(){
		let replyNo = $(this).attr("data-replyNo");
		
		// 모달 내부 input 데이터에 replyNo 넣어주기
		$("#complainReplyNo").attr("value", replyNo);
		// 신고 내용 작성 모달 show
		$("#complainModal").modal("show");
		
	});
})

// 댓글 신고하기: 작성한 신고 내역 보내기
$(function(){
	$("body").on("click", ".btnComplainSubmit", function(){
		let replyNo = $("#complainReplyNo").val();
		let complain = $("#complain").val();
		
		let msg = "댓글을 신고하시겠습니까 ? ";
		if(! confirm(msg)) {
			return false;
		}
		
		if(! complain) {
			alert("신고 내용을 작성해주세요.");
			return;
		}
		
		let url = "${pageContext.request.contextPath}/news/replyComplain";
		let query = "replyNo=" + replyNo + "&complain=" + complain;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				alert(data.msg);
			} else {
				alert("신고 처리에 실패했습니다.");
			}
			// 처리 완료 후 모달창 닫기
			$("#complain").attr("value", "");
			$("#complainModal").modal("hide");
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글 작성 유저 클릭
$(function() {
	$("#replyUserIcon").on("click", function() {
		
	});
});

// 뉴스글 북마크 클릭
$(function() {
	$(".btnBookMark").on("click", function() {
		const $i = $(this).find("i");
		let bookMarked = $i.hasClass("fa-solid fa-bookmark");
		let msg = bookMarked ? "북마크를 취소하시겠습니까 ? " : "북마크 하시겠습니까 ? ";
		let newsNo = "${dto.newsNo}";
		
		if(! confirm(msg)) {
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/news/insertBookMark";
		let query = "newsNo=" + newsNo + "&bookMarked=" + bookMarked;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true") {
				if( bookMarked ) {  
					$i.removeClass("fa-solid fa-bookmark").addClass("fa-regular fa-bookmark");
				} else {
					$i.removeClass("fa-regular fa-bookmark").addClass("fa-solid fa-bookmark");
				}
				
			} else if(state === "bookMarked") {
				alert('북마크를 삭제했습니다.');
			} else {
				alerr('북마크를 추가했습니다.')
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});



function shareTwitter() {
    var sendText = "newsocean";
    var sendUrl = "http://localhost:9090/app/news/article?newsNo="+"${dto.newsNo}"; 
    window.open("https://twitter.com/intent/tweet?url=" + sendUrl);
}

function shareKakao() {
	  // 사용할 앱의 JavaScript 키 설정
	  Kakao.init('키');
	 
	  // 카카오링크 버튼 생성
	  Kakao.Link.createDefaultButton({
	    container: '#btnKakao', // 카카오공유버튼ID
	    objectType: 'feed',
	    content: {
	      title: "NewsOcean", // 보여질 제목
	      description: "거친 파도를 유연하게 헤엄치는 서퍼처럼", // 보여질 설명
	      imageUrl: "http://localhost:9090/app/news/article?newsNo="+"${dto.newsNo}", // 콘텐츠 URL
	      link: {
	         mobileWebUrl: "http://localhost:9090/app/news/article?newsNo="+"${dto.newsNo}",
	         webUrl: "http://localhost:9090/app/news/article?newsNo="+"${dto.newsNo}"
	      }
	    }
	  });
}

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
							<div class="btn btnBookMark"><i class="${dto.bookMarkNum==1 ? 'fa-solid':'fa-regular'} fa-bookmark fa-2x"></i></div>
							<div>📌 뉴스 내용 부분</div>
						</td>
					</tr>
					
					<tr>
						<td colspan="2" class="text-center p-3">
							<div class="divNewsLike">
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
					<td>
						<img class="img-logo btn" id="btnTwitter"
							src="${pageContext.request.contextPath}/resources/images/icon-twitter.png" onclick="shareTwitter();">
						<img class="img-logo btn" id="btnKakao"
							src="${pageContext.request.contextPath}/resources/images/icon-kakao.png" onclick="shareKakao();">
					</td>
				
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
			        <input type="hidden" id="complainReplyNo" value="">
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