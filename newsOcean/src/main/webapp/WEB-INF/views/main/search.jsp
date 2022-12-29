<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!--태그 선택이벤트 필요x -->
<script>
$(function(){
	$(".select-tag").click(function(){
		let url = "${pageContext.request.contextPath}/search/searchlist.do";
		
		$.ajax({
			type:"post",
			url:url,
			data:null,// httprequest와함께 서버에 보낼 data
			dataType:"json",
			success:function(data){
				
				let out = "";
				let i = 0;
				$(data.list).each(function(index, item){
					let tagName = item.tagName;
					let tagNo = item.tagNo;
					out += '<input type="checkbox" name="chktag" id="'+"tagNo"+(++i)+'" value="'+tagNo+'"><label class="col" for="'+"tagNo"+(i)+'">'+tagName+'</label>';
				});
				
				$(".tagList").html(out);		
			},
			error:function(e) {
				console.log(e.responseText);
			}
		});
	});
})
//
$(function(){
	
	$('form input[name=category]').click(function() {
	    $(this).toggleClass('category_selected');
	});
	
	//큰카테고리 선택하면 input checked 되도록
	$("#bigCategory").click(function(){
	    if($(this).hasClass("bigCategory_selected")) {
	    	$(this).find("input").prop('checked', false);
	        $(this).removeClass("bigCategory_selected");
	    } else {
	    	$(this).find("input").prop('checked', true);
	        $(this).addClass("bigCategory_selected");
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

<!--  참고-->
<script>
function tagSelect(){
	let radioText = $("input[name=radio3]:checked").next("label").text();
	let stationCode = $("input[name=radio3]:checked").val();
	
	$("#busdeparture").text(radioText);
	$("#busdeparture").attr("data-busdeparture", stationCode);
	if(!radioText) {
		$("#busdeparture").text("선택");
		$("#busdeparture").val("선택");
	} 
	$("#myDialogModal1").modal("hide");
	
	let busdeparture = $("#busdeparture").text();
	let busdestination = $("#busdestination").text();
	if(busdeparture === busdestination){
		$("#busdestination").text("선택");
		$("#busdestination").val("선택");
		$("#busdestination").attr("data-busdestination", "");
	}
}
	

function selectDes(){
	let radioText = $("input[name=radio5]:checked").next("label").text();
	let stationCode = $("input[name=radio5]:checked").val();
	$("#busdestination").text(radioText);
	$("#busdestination").attr("data-busdestination", stationCode);
	$("#myDialogModal22").modal("hide");
}
</script>
<!-----------------------------------날짜 선택-->
<script>
$(function(){
	let out ="${pageContext.request.contextPath}/searchresult?";
	let chkbox_out = "";
	/* get방식
	$('.search_submit').click(function(){
		let staDate = $('.staDate').val(); 
		let endDate = $('.endDate').val();
		if(staDate>endDate){
			alert("시작일이 종료일보다 늦을수없습니다.");
			return;
		}
		
		const f = document.searchForm;
		f.action = "${pageContext.request.contextPath}/searchresult";
		f.submit();
		
		let searchInfo = $("form[name=searchForm] input[name=keyword]").val();
		out += "searchInfo="+searchInfo;
		
    	out += "&staDate="+staDate+"&endDate="+endDate;
    	out += chkbox_out;
    	location.href = out;
    	
	});
	*/
	
	/*get방식
	$(".form[name=searchForm] input:checkbox").click(function(){
		if ($(this).is(":checked") ==true) {
			let categoryNo =$(this).val();
			let categoryName =  $(this).attr("data-categoryName");
			chkbox_out += "&categoryNo="+categoryNo+"&categoryName="+categoryName;
		}
		if ($(this).is(":checked") ==false) {
			let categoryNo =$(this).val();
			let categoryName =  $(this).attr("data-categoryName");

			chkbox_out.replace("&categoryNo=", "");
			chkbox_out.replace(categoryNo, "");
			chkbox_out.replace("&categoryName=", "");
			chkbox_out.replace(categoryName, "");
		}
	});
	*/
});
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
.input-group-text{
justify-content: center;
}

.bigCategory_selected{
	background-color:#80B5FF;
	color:white;
}
</style>
<div class="container body-container">
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
					<div class="search_detail_content">
						<input  type="text" name="keyword" maxlength="255" placeholder="뉴스 검색">
					</div>
				</div>
				<div class="search_detail_row input-group-text">
					<div class="m-2">카테고리종류</div>
					<div class="search_detail_label search_category">
						<c:forEach var="dto" items="${categorylist}" varStatus="status">
							<c:if test="${dto.categoryNo%100 == 0}">
							<div class="m-2" id="bigCategory">
								<input class="chkAll m-2  form-check-input mt-0" type="checkbox" style="display: none;" name="categoryNo" data-categoryName="${dto.categoryName}" value="${dto.categoryNo} ">
	      						<span class="input-group-text">${dto.categoryName}</span>
							</div>
							<input type="hidden" name="categoryName" class="" value="${dto.categoryName}">
							</c:if>
							<c:if test="${dto.categoryNo%100 != 0}">
							<input class="category m-2 form-check-input mt-0" type="checkbox" name="categoryNo"  data-categoryName="${dto.categoryName}" value="${dto.categoryNo}">
      						<span class="input-group-text" style="display:inline;">${dto.categoryName}</span>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="search_detail_row input-group-text">
					<input type="submit" class="search_submit" value="검색">
				</div>
			</div>
		</div>
	</form>
</div>