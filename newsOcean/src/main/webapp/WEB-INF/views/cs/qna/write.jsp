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
function sendOk() {
    const f = document.boardForm;
	let str;
	
    str = f.qnaSubject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.qnaSubject.focus();
        return;
    }

    str = f.qnaContent.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.qnaContent.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/cs/qna/${mode}";
    f.submit();
}


</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-app"></i> QNA </h3>
		</div>
		
		<div class="body-main">
		
			<form name="boardForm" method="post">
				<table class="table mt-5 write-form">
					<tr>
						<td class="table-light col-sm-2" scope="row">제 목</td>
						<td>
							<input type="text" name="qnaSubject" class="form-control" value="${dto.qnaSubject}">
						</td>
					</tr>
        
					<tr>
						<td class="table-light col-sm-2" scope="row">닉네임</td>
 						<td>
							<p class="form-control-plaintext">${sessionScope.member.nickName}</p>
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-2" scope="row">내 용</td>
						<td>
							<textarea name="qnaContent" id="qnaContent" class="form-control">${dto.qnaContent}</textarea>
						</td>
					</tr>
					
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/cs/qna/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</div>