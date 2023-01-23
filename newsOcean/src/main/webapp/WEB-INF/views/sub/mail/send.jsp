<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 1000px;
}

.mail-container {
	display: flex;
}

.img-modalLogo {
	max-width: 500px;
	max-height: 700px;
	padding-left: 55px;
}

.modal-contentHeader {
	display: flex;
    flex-direction: column;
    align-items: center;
}

.contentHeader {
	display: flex;
    flex-direction: column;
    align-items: center;
}

.tdTitle {
	width: 200px;
	font-size: 20px;
}

.ck.ck-editor {
	width: 700px;
}

.ck-editor__editable { 
	height: 400px; 
}

.ck-content { font-size: 12px; }

.tdNewsBring {
	width: 100%;
	display: flex;
    justify-content: space-around;
}

.newsBring { 
	animation-duration: 3s; 
	animation-name: rainbowLink; 
	animation-iteration-count: infinite;     
	font-size: 25px;
	border-color: #000;
	border-radius: 30px;
} 
@keyframes rainbowLink {     
 0% { color: #ff2a2a; }
 15% { color: #ff7a2a; }
 30% { color: #ffc52a; }
 45% { color: #43ff2a; }
 60% { color: #2a89ff; }
 75% { color: #202082; }
 90% { color: #6b2aff; } 
 100% { color: #e82aff; }
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>

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
		beforeSend:function(jqXHR){
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
/*
$(document).ready(function() {
	let url = "${pageContext.request.contextPath}/sub/mail/guideForm"; // <div id="guideForm">
 	const fn = function(guideForm) {
 		console.log(guideForm);
 		// $(selector).html(data);
 		window.editor.setData(guideForm);
 	}
	ajaxFun(url, "get", "", "html", fn);
	
});
*/



// 보낼 그룹 (selectReceiver) 선택할 때마다 input값 변경
$(function() {
	$("#selectReceiver").click(function() {
		let selectReceiver = $("#selectReceiver").find("option:selected").val();
		$("input[name=receiverGroup]").attr("value", selectReceiver);
		console.log(selectReceiver);
	});
});


function sendOk() {
    const f = document.mailForm;
	let str;
	
    str = f.senderName.value.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.senderName.focus();
        return;
    }

	str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

 // 값 가져오기
	// window.editor.getData();
	// 값 셋팅
	    // window.editor.setData('<p>example</p>');
	
    str = window.editor.getData().trim();
    if(! str) {
        alert("내용을 입력하세요. ");
        window.editor.focus();
        return;
    }
	f.content.value = str;
	console.log(str);

	f.action="${pageContext.request.contextPath}/sub/mail/send";
	f.submit();
}


$(function() {
	$(".btnNewsBring").click(function() {
		let url = "${pageContext.request.contextPath}/sub/mail/guideFormNewsList"; 
	 	const fn = function(guideForm) {
	 		console.log(guideForm);
	 		// $(selector).html(data);
	 		window.editor.setData(guideForm);
	 	}
		ajaxFun(url, "get", "", "html", fn);
	});
})


</script>

<div class="container mail-container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-envelope"></i> 구독 메일 작성하기 </h3>
		</div>
		
		<div class="body-main">
		
			<form name="mailForm" method="post" enctype="multipart/form-data">
				<table class="table mt-5 write-form">
        
					<tr>
						<td class="table-light col-sm-3 tdTitle" scope="row">수신인</td>
						<td>
							<input type="text" class="form-control" name="receiverGroup" value="구독자" readonly="readonly">
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-3 tdTitle" scope="row">제  목</td>
						<td>
							<input type="text" name="subject" class="form-control" placeholder="제 1호">
						</td>
					</tr>
					
					<tr class="trNewsBring">
						<td></td>
						<td class="tdNewsBring">
							<button type="button" class="btn newsBring btnNewsBring">⛵ 뉴스 가져오기 ⛵</button>
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-3 tdTitle" scope="row">내  용</td>
						<td class="editorTd">
							<div class="editor"></div>
							<input type="hidden" name="content">
						</td>
					</tr>
					
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">메일 전송&nbsp;<i class="bi bi-check2"></i></button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sub/mail/listSendMail';">전송 취소&nbsp;<i class="bi bi-x"></i></button>
						</td>
					</tr>
				</table>
				<input type="hidden" name="senderEmail" value="${sessionScope.member.email}">
				<input type="hidden" name="senderName" value="${sessionScope.member.nickName}">
			</form>
		
		</div>
	</div>
	

</div>


<script>

			ClassicEditor
				.create( document.querySelector( '.editor' ), {
					fontFamily: {
			            options: [
			                'default',
			                '맑은 고딕, Malgun Gothic, 돋움, sans-serif',
			                '나눔고딕, NanumGothic, Arial'
			            ]
			        },
			        fontSize: {
			            options: [
			                9, 11, 13, 'default', 17, 19, 21
			            ]
			        },
					toolbar: {
						items: [
							'heading','|',
							'fontFamily','fontSize','bold','italic','fontColor','|',
							'alignment','bulletedList','numberedList','|',
							'imageUpload','insertTable','sourceEditing','blockQuote','mediaEmbed','|',
							'undo','redo','|',
							'link','outdent','indent','|',
						]
					},
					image: {
			            toolbar: [
			                'imageStyle:inline',
			                'imageStyle:side',
			                '|',
			                'imageTextAlternative'
			            ],
	
			            // The default value.
			            styles: [
			                'full',
			                'side'
			            ]
			        },
					language: 'ko',
					ckfinder: {
				        uploadUrl: '${pageContext.request.contextPath}/image/upload' // 업로드 url (post로 요청 감)
				    }
				})
				.then( editor => {
					window.editor = editor;
				})
				.catch( err => {
					console.error( err.stack );
				});
			

	</script>

