<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
var myModal = document.getElementById('myModal')
var myInput = document.getElementById('myInput')

myModal.addEventListener('shown.bs.modal', function () {
  myInput.focus()
})
</script>
<style>
*{margin:0; padding:0;}
.container{
	display:flex;
	margin:0 auto;
}
.search_content{
 margin:5px auto;
}
</style>
<div class="container body-container">
	search화면
	<form action="" method="post" id="searchForm">
		<div class="search_content">
			<input type="hidden" name="whatever" >
			<div class="search_detail_content">
				<div class="search_detail_row">
					<div class="serarch_detail_label">
						키워드 검색
					</div>
					<div class="search_detail_content">
						<input type="search" name="keyword" maxlength="255" placeholder="뉴스 검색">
						<!--  <button type="button" class="search_delete_button">
						</button>
						-->
					</div>
				</div>
				<div class="search_detail_row">
					<div class="serarch_detail_label">
						카테고리 검색(아코디언)
					</div>
					<div class="search_detail_content">
					<input type="radio" name="정치">
						<input type="radio" name="경제">
						<input type="radio" name="사회">
						<input type="radio" name="IT/과학">
					</div>
				</div>
				<div class="search_detail_row">
					<div class="serarch_detail_label">
						태그 검색
					</div>
					<div class="search_detail_content">
						<button type="button" class="btn btn-primary select-tag" data-bs-toggle="modal" data-bs-target="#tagModal">
						  태그 선택
						</button>
					</div>
				</div>
				<div class="search_detail_row">
					<div class="serarch_detail_label">
						뉴스 개시일
					</div>
					<div class="search_detail_content">
						<input type="search" name="keyword" maxlength="255" placeholder="뉴스 검색">
						<!--  <button type="button" class="search_delete_button">
						</button>
						-->
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- 태그 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">태그 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">선택</button>
      </div>
    </div>
  </div>
</div>