<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/jquery/css/jquery-ui.min.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/jquery/js/jquery-ui.min.js"></script>

<!-- 자동완성  -->
<script>
$(function(){
	$("#displayList").hide();
		//검색어의 길이가 바뀔 때마다 호출
	$("#searchName").autocomplete({
		source: function(request, response){
			
			let wordLength = $("#searchName").val().trim().length;
			if(wordLength == 0) {
				$("#displayList").hide();
			} else {
				//서버에서 특정 키워드가져오기
				$.ajax({
					url:"${pageContext.request.contextPath}/searchform",
					type:"get",
					data:{"searchType": $("#searchType").val(),
						  "searchName": $("#searchName").val() },
					dataType:"json",
					success:function(data){
						console.log("...")
						console.log(data);
						
						if(data.length > 0){
							// 검색된 데이터가 있는 경우
							response(
								$.map(data, function(item){
									return {
										label: item+"label",
										value: item
									};
							}));
							
							$("#displayList").show();
						}
					}
				});
			}
			
		},
		select:function(event, ui){
			console.log(ui.item.label);
			console.log(ui.item.value);
		},
		minLength: 1, 
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
	$(".chkAll").click(function(){
		let b = $(this).is(":checked");
		$(this).parent().parent().find(".category").prop("checked", b);
	});
	$("form .chkAll").click(function(){
		let cnt = $("form input[name=categoryNo]:checked").length;
		const f = document.searchForm;
		f.action = "${pageContext.request.contextPath}/searchresult";
		f.submit();
	});
});
</script>
<style>
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

.bigCategory_selected{
	background-color:#80B5FF;
	color:white;
}
#displayList{
style=border: solid 1px gray; 
height: 100px; 
overflow: auto; 
margin-left: 77px; 
margin-top; -1px; 
border-top: 0px;
}
</style>
<div class="body-container2">
	<form action="${pageContext.request.contextPath}/searchresult"method="post" name="searchForm">
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
					
					<select name="searchType" id="searchType">
						<option value="subject">제목</option>
						<option value="searchName">키워드</option>
					</select>
					<input type="text" id="searchName" name="searchName" size="100" autocomplete="off">
					<div id="displayList">
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
								<input class="category m-2 mt-0" type="checkbox" name="categoryNo"  data-categoryName="${dto.categoryName}" value="${dto.categoryNo}">
	      						<span class="input-group-text" style="display:inline;">${dto.categoryName}</span>
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