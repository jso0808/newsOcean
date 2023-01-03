<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
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

.ck.ck-editor {
   max-width: 900px;
}
.ck-editor__editable {
    min-height: 250px;
}
.ck-content .image>figcaption {
   min-height: 25px;
}

.editorTd{
	max-width: 800px;
}

.tdTitle {
	width: 50px;
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


$(function() {
	$(".ck-editor__main").css({"height": "600px"});
});

/*
// 보낼 그룹 (selectReceiver) 선택할 때마다 input값 변경
$(function() {
	$("#selectReceiver").click(function() {
		let selectReceiver = $("#selectReceiver").find("option:selected").val();
		$("input[name=receiverGroup]").attr("value", selectReceiver);
		console.log(selectReceiver);
	});
});

// 내용 작성폼 JSP html 가져오기
$(function() {
	$("#content").click(function() {
		
		let today = new Date().toISOString().substring(0, 10);
		$("#sendDate").empty();
		$("#sendDate").append(today);
		
		$("#contentModal").modal("show");	
		
	});
	// ajax
});

// 작성 완료 버튼 클릭 시 content로 내용 가져오기. btnContentWriteFinish
$(function() {
	$("#btnContentWriteFinish").click(function() {
		let modalContent = $("#modalContent").val();
		console.log(modalContent);
		let ttt = $(".modal-body").html();
		console.log(ttt);
		

		// modal-contentHeader
		let modalContentHeader = $(".modal-contentHeader").html();
		console.log(modalContentHeader);
	});
});
*/

// content의 헤더, 바디, 푸터 html 코드 가져오기
$(function() {
	
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
    
	if(!f.receiverGroup.value.trim()) {
        alert("보낼 그룹을 선택해주세요 . ");
        return;
	}
    
	str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

	str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

	f.action="${pageContext.request.contextPath}/sub/mail/send";
	f.submit();
}
</script>

<div class="container mail-container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-envelope"></i> 메일 보내기 </h3>
		</div>
		
		<div class="body-main">
		
			<form name="mailForm" method="post" enctype="multipart/form-data">
				<table class="table mt-5 write-form">
        
					<tr>
						<td class="table-light col-sm-3 tdTitle" scope="row">보낼 그룹 선택</td>
						<td>
							<select class="form-select" id="selectReceiver" name="selectReceiver">
								<option selected="selected" value="subscriber">구독자만</option>
								<option value="all">모든 오셔너</option>
								<option value="test">테스트용</option>
							</select>
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-3" scope="row">제 목</td>
						<td>
							<input type="text" name="subject" class="form-control" placeholder="제 1호">
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-sm-3">표지 파일 첨부</td>
						<td> 
							<input type="file" name="selectFile" multiple="multiple" class="form-control">
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-3" scope="row">내용</td>
						<td class="editorTd">
							<div class="editor">${dto.content}</div>
							<input type="hidden" name="content">
						</td>
					</tr>
					
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">메일 전송&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/';">전송 취소&nbsp;<i class="bi bi-x"></i></button>
						</td>
					</tr>
				</table>
				<input type="hidden" name="senderEmail" value="${sessionScope.member.email}">
				<input type="hidden" name="senderName" value="${sessionScope.member.nickName}">
				<input type="hidden" name="receiverGroup" value="">
				<input type="hidden" name="receiverEmail" value="moonkite__@naver.com">
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

