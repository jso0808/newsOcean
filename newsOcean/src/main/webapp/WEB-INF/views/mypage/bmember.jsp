<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

<style type="text/css">

</style>
<script>
$(function(){
	$(document).on("click", "button[id='addMyKeyword_btn']", function(){
		  let addKeyword = $("#addMykeyword_input").val();
          let keywordhtml = "<span id='keyworditem' style='font-size:1.5rem;' class='badge bg-light text-dark'>"+addKeyword+"</span>";
          keywordhtml += "<input type='hidden' name='keywordName' value="+addKeyword+">";

          $("#keywordList").append(keywordhtml);
          $("#addMykeyword_input").val("");
	});
	$(document).on("click", "#keyworditem", function(){
		$(this).prev().val();
		$(this).next("input[type='hidden']").remove();
		$(this).remove();
	});
})
</script>
<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-app"></i>즐겨찾는 회원</h3>
		</div>
		<div class="body-main input-group-text">
			<form action="${pageContext.request.contextPath}/mypage/keyword">
				<div id="submit_btnbox">
				<button type="submit" id="submit_btn" class="btn btn-outline-primary">저장</button>				
				</div>
				<div class='addMyKeywordList input-group-text'>
					<input type='text' id="addMykeyword_input">
					<button class='btn btn-light' type="button" id='addMyKeyword_btn'>즐겨찾는 회원추가</button>
				</div>
				<div id="keywordList" class="input-group-text">
					<c:forEach var="dto" items="${keywordList}" varStatus="status">
						<span id="keyworditem" class="badge bg-light text-dark" style="font-size:1.5rem;">${dto.keywordName}</span>
						<input type="hidden" name="keywordNo" value="${dto.keywordNo}">
						<input type="hidden" name="keywordName" value="${dto.keywordName}">
					</c:forEach>
				</div>
			</form>
		</div>
	</div>
</div>