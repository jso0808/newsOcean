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

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-envelope"></i> 메일 보내기 </h3>
		</div>
		
		<div class="body-main">
		
			<form name="mailForm" method="post" enctype="multipart/form-data">
				<table class="table mt-5 write-form">
        
					<tr>
						<td class="table-light col-sm-3" scope="row">보낼 그룹 선택</td>
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
						<td class="table-light col-sm-3" scope="row">내 용</td>
						<td>
							<textarea name="content" class="form-control"></textarea>
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