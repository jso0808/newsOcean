<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/jquery/css/jquery-ui.min.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/jquery/js/jquery-ui.min.js"></script>

<!-- 자동완성  -->
<script>
$(function(){
		//검색어의 길이가 바뀔 때마다 호출
    function split( val ) {
      return val.split( /,\s*/ );
    }

	function extractLast( term ) {
      return split( term ).pop();
    }
		
	$("#searchName").autocomplete({
		source: function(request, response){
			
			let wordLength = $("#searchName").val().trim().length;
			if(wordLength == 0) {
				//$("#displayList").hide();
			} else {
				//서버에서 특정 키워드가져오기
				$.ajax({
					url:"${pageContext.request.contextPath}/searchform",
					type:"get",
					data:{"searchType": $("#searchType").val(),
						  "searchName": $("#searchName").val()},
					dataType:"json",
					success:function(data){
						if(data.length > 0){
							var availableTags = [];
							for(let item of data) {
								availableTags.push(item.word);
							}
							console.log(availableTags)
							response( $.ui.autocomplete.filter(
						            availableTags, extractLast( request.term ) ) );
						}
					}
				});
			}
		},
		select:function(event, ui){
			console.log(ui.item.label);
			console.log(ui.item.value);
		},
		focus: function() {
	          return false;
	    },
		minLength: 2, 
		autoFocus: true,
		error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
		
	  // 자동완성 목록을 클릭하면 검색하기
	$(document).on('click', ".result", function(){
		var word = $(this).text();
		$("#searchName").val(word);
	});
});

</script>
<script>
$(function(){
	
	$('form input[name=category]').click(function() {
	    $(this).toggleClass('category_selected');
	});
	
	//큰카테고리 선택하면 input checked 되도록
	$(".bigCategory").click(function(){
	    if($(this).find("span").hasClass("bigCategory_selected")) {
	    	$(this).find("input").prop('checked', false);
	        $(this).find("span").removeClass("bigCategory_selected");
	    } else {
	    	$(this).find("input").prop('checked', true);
	        $(this).find("span").addClass("bigCategory_selected");
	    }
	});

	//작은카테고리 선택하면 input checked 되도록
	$(".smallCategory").click(function(){
	    if($(this).hasClass("smallCategory_selected")) {
	    	$(this).next("input").prop('checked', false);
	        $(this).removeClass("smallCategory_selected");
	    } else {
	    	$(this).next("input").prop('checked', true);
	        $(this).addClass("smallCategory_selected");
	    }
	});
	/*
	$(".bigCategory").click(function(){
		let b = $(this).is(":checked");
		$(this).parent().parent().find(".category").prop("checked", b);
	});
	$("form .chkAll").click(function(){
		let cnt = $("form input[name=categoryNo]:checked").length;
		const f = document.searchForm;
		f.action = "${pageContext.request.contextPath}/searchresult";
		f.submit();
	});
	*/
	
});
</script>
<style>
*{margin:0; padding:0;}
*{margin:0; padding:0;}
.container2{
	display: flex;
    justify-content: center
}
.search_content{
 margin:5px auto;
}
.input-group-text{
justify-content: center;
}
.bigCategory, .smallCategory{
cursor: pointer;
}
.bigCategory_selected, .smallCategory_selected{
	background-color:#80B5FF;
	color:white;
	cursor: pointer;
}
#displayList{
	style=border: solid 1px gray; 
	height: 100px; 
	overflow: auto; 
	margin-left: 77px; 
	margin-top; -1px; 
	border-top: 0px;
}
.ui-autocomplete {
  max-height: 200px;
  overflow-y: auto;
  overflow-x: hidden;
  height: auto;
}
</style>
<div class="body-container2">
	<form action="${pageContext.request.contextPath}/searchresult" method="get" name="searchForm">
		<div class="search_content input-group-text">
			<div class="search_detail_content">
				<div class="search_detail_row input-group-text">
					<div class="search_detail_label m-2">
						search화면
					</div>
				</div>
				<div class="search_detail_row input-group-text">
					<div class="search_detail_label m-2">
						키워드 검색
					</div>
					<div class="ui-widget">
						<select name="searchType" id="searchType">
							<option value="subject">제목</option>
							<option value="keyword">키워드</option>
						</select>
						<input type="text" id="searchName" name="searchName" size="100" autocomplete="off" size="50">
						<label for="searchName" id="searchitemList"></label>
					</div>

				</div>
				<div class="search_detail_row input-group-text">
					<div class="m-2">카테고리종류</div>
					<div class="search_detail_label search_category">
						<c:forEach var="dto" items="${categorylist}" varStatus="status">
							<c:if test="${dto.categoryNo%100 == 0}">
								<div class="m-2 bigCategory">
									<input class="chkAll m-2 mt-0" type="checkbox" style="display: none;" name="categoryNo" data-categoryName="${dto.categoryName}" value="${dto.categoryNo} ">
		      						<span class="input-group-text">${dto.categoryName}</span>
								</div>
								<input type="hidden" name="categoryName" class="" value="${dto.categoryName}">
							</c:if>
							<c:if test="${dto.categoryNo%100 != 0}">
	      						<span class="input-group-text smallCategory" style="display:inline-block;">${dto.categoryName}</span>
								<input class="category m-2 mt-0" type="checkbox" style="display: none;" name="categoryNo"  data-categoryName="${dto.categoryName}" value="${dto.categoryNo}">
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="search_detail_row input-group-text">
					<input type="submit" class="search_submit btn btn-secondary btn-sm" value="검색">
				</div>
			</div>
		</div>
	</form>
</div>