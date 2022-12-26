<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<form name="noticeForm" method="post" enctype="multipart/form-data">
	<table class="table mt-5 write__form">
		<tr>
			<td class="table-light col-sm-2" scope="row">제 목</td>
			<td>
				<input type="text" name="companySubject" class="form-control" value="${dto.companySubject}">
			</td>
		</tr>
		
		<tr>
			<td class="table-light col-sm-2" scope="row">공지여부</td>
			<td class="py-3">
				<input type="checkbox" name="notice" id="notice" class="form-check-input" value="1" ${dto.notice==1 ? "checked='checked' ":"" } >
				<label class="form-check-label" for="notice"> 공지</label>
			</td>
		</tr>        
     
		<tr>
			<td class="table-light col-sm-2" scope="row">작성자명</td>
				<td>
				<p class="form-control-plaintext">${sessionScope.member.name}</p>
			</td>
		</tr>

		<tr>
			<td class="table-light col-sm-2" scope="row">내 용</td>
			<td>
				<div class="editor">${dto.companyContent}</div>
				<input type="hidden" name="companyContent" id="companyContent">
			</td>
		</tr>
		
		<tr>
			<td class="table-light col-sm-2">첨 부 </td>
			<td> 
				<input type="file" name="selectFile" multiple="multiple" class="form-control">
			</td>
		</tr>
		
		<c:if test="${mode=='update'}">
			<c:forEach var="vo" items="${listFile}">
				<tr id="f${vo.fileNo}">
					<td class="table-light col-sm-2" scope="row">첨부된파일</td>
					<td> 
						<p class="form-control-plaintext">
							<a href="javascript:deleteFile('${vo.fileNo}');"><i class="bi bi-trash"></i></a>
							${vo.originalFilename}
						</p>
					</td>
				</tr>
			</c:forEach> 
		</c:if>
	</table>
	
	<table class="table table-borderless">
			<tr>
			<td class="text-center">
				<button type="button" class="btn btn-dark" onclick="sendOk('${mode}', '${pageNo}');">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
				<button type="reset" class="btn btn-light">다시입력</button>
				<button type="button" class="btn btn-light" onclick="sendCancel();">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
				<c:if test="${mode=='update'}">
					<input type="hidden" name="companyNo" value="${dto.companyNo}">
				</c:if>
			</td>
		</tr>
	</table>
</form>



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

