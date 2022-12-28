<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.write__btn__st1 {
	height: 40px;
	text-align: center;
	vertical-align: middle;
	border-radius: 20px;
	font-family:'line_font_b';
	color: #fff;
	width: 120px;
	border: none;
	background: #004b81;
}

.write__btn__st {
	height: 40px;
	text-align: center;
	vertical-align: middle;
	font-family:'line_font_b';
	border-radius: 20px;
	color: #595959;
	width: 120px;
	border: none;
	background: #eee;
}

.write__title__st td:first-child {
	font-family:'line_font_b';
	padding-top: 10px;
	color: #595959;
}

.bigbig {
	color: #595959;
	font-size: 30px;
	font-family:'line_font_b';
	margin-left: 40px;
}

.form-check-label{
	 display: inline-block;
    cursor: pointer;
    height: 25px;
    width: 90px;
    border: 1px solid #333;
    line-height: 24px;
    text-align: center;
    font-weight:bold;
    font-size:13px;
}

.form-check-input:checked+label{
    background-color: #004b81;
    color: #fff;
}

.form-check-input input[type=checkbox]{
    display: none;
    border:none;
}

input[type=checkbox], input[type=radio] { 
border:none !important; 
width: 0.1px;
height: 0.1px;
padding: 0;
margin: -1px;
overflow: hidden;
outline: none;
clip:rect(0,0,0,0);
border: none;} 

input[type=checkbox]:focus {
	outline: none;
	border:none !important; 
}

</style>


<div class="bigbig">새로운 게시글 등록.</div>
<form name="noticeForm" method="post" enctype="multipart/form-data" style="margin-top: -20px;">
	<table class="table mt-5 write__form write__title__st">
		<tr>
			<td class="table-light col-sm-2 " scope="row">제 목</td>
			<td>
				<input type="text" name="companySubject" class="form-control" value="${dto.companySubject}">
			</td>
		</tr>
		
		<tr>
			<td class="table-light col-sm-2" scope="row">공지여부</td>
			<td class="py-3">
				<input type="checkbox" name="notice" id="notice" class="form-check-input" value="1" ${dto.notice==1 ? "checked='checked' ":"" } >
				<label class="form-check-label" for="notice" >공지 등록</label>
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
	
	<table class="table table-borderless" >
			<tr>
			<td class="text-center" style="padding-bottom: 30px;">
				<button type="button" class="write__btn__st1" onclick="sendOk('${mode}', '${pageNo}');">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
				<button type="reset" class="write__btn__st">다시입력</button>
				<button type="button" class="write__btn__st" onclick="sendCancel();">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
				
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

