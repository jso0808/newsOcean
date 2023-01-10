<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-perform.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.2.2/echarts.min.js"></script>

<script >

//차트  --------------------------------------------
$(function(){
	let url = "${pageContext.request.contextPath}/admin/perform/line1";
	
	//제이슨 방식. GET 밖에 없다.
	$.getJSON(url, function(data){
		
		var chartDom = document.getElementById('chart-1');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  tooltip: {
		    trigger: 'item'
		  },
		  title : {
				text: '  최근 30일 기준'
		  },
		  xAxis: data.xAxis
		  ,
		  yAxis: {
		    type: 'value'
		  },
		  series: data.series 
		  
		};

		option && myChart.setOption(option);
	});
	

});



</script>



<div class="body-title">
	<div class="col" style="display: flex; justify-content:space-between;">
		<div class="perform__title" > 
			<span style="font-family: 'line_font_b';">Sales Data</span>
		</div>
		<div class="pb-1">
			<button type="button" class="print_btn shadow-sm" onclick="location.href='${pageContext.request.contextPath}/admin/mypage/main';"><i class="fa-solid fa-print"></i>&nbsp;&nbsp; 화면 프린트하기 </button>
			<button type="button" class="reload_btn shadow-sm" onclick="reload();"><i class="fa-solid fa-repeat"></i>&nbsp;&nbsp;새로고침</button>
		</div>
	</div>
</div>







<!-- 본문 차트 그래프 부분 -->
<div class="perform__title2" style="display: flex; justify-content:space-between;"> 
	<span style="font-family: 'line_font_b';">매출 통계<button class="more__sales__large" onclick="updateYearTarget();">+ 매출 목표 등록/수정 </button> </span>
</div>

<!-- 그래프 line1 -->
<div class="row">
	<div class="chart-1_sales shadow-sm" id="chart-1">
	</div>
</div>

<div class="perform__title3" style="display: flex; justify-content:space-between;"> 
	<span style="font-family: 'line_font_b';">일자별 매출 내역</span>
</div>


<!-- 테이블 리스트 영역 -->
<div class="row">
	<div class="tb__area__sales " ></div>
</div>





<!-- 모달!! -->
<div class="modal" tabindex="-1" id="updateModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" style="font-family: 'line_font_b';">${dto.golsdate} 목표 등록/수정하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<button class="btn modal__main__btn" style="float: right;" disabled="${dto.golsdate==year ? 'disabled' :''}">올해 목표 등록</button>
      	<button class="btn modal__main__btn2" style="float: right;" onclick="showupdateForm()">목표 수정</button>
        <table class="table text-center">
        	<thead >
        		<tr class="modal_table_title">
        			<th>년도</th>
        			<th>매출 유형</th>
        			<th>매출 목표 금액</th>
        		</tr>
        	</thead>
        	<tbody>
        		<tr>
        			<td>${dto.golsdate}</td>
        			<td>${dto.goltype}</td>
        			<td>${dto.golamount}</td>
        		</tr>
        	</tbody>
        </table>
        <div class="updateForm">
        </div>
      </div>
      <div class="modal-footer">
      	
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="updateBtn" onclick="updateOk();">Save changes</button>
      </div>
    </div>
  </div>
</div>





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
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
	    	if(jqXHR.status === 403) {
	    		login();
	    		return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false,  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		contentType: false,  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function reload(){
	location.href = "${pageContext.request.contextPath}/admin/perform/main_sales";
}
	


$(function(){
	listPage(1);
});


//테이블 리스트 
function listPage(page) {
	let url = "${pageContext.request.contextPath}/admin/perform/list_sales";
	let query = "pageNo="+page;
	let selector = ".tb__area__sales";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}

function updateYearTarget() {
	$("#updateModal").modal('show');
	$("#updateBtn").hide();

}

function showupdateForm(){
	let selector = ".updateForm";
	let ff = "<span class='new_title'>새로운 목표 금액 : </span><input class='new_input' type='text' id='updateCount'>";
	
	$(selector).html(ff);
	$("#updateBtn").show();
	
}


//매출 목표 변경
function updateOk(){
	let new_year_target = $("#updateCount").val();
	
	if(! /^\d+$/.test(new_year_target)){
		alert("숫자만 입력 가능합니다.")
		new_year_target.focus();
		return false;
	}
	
	if(! new_year_target){
		alert("공백은 입력 불가합니다. 취소 버튼을 눌러주세요.");
		new_year_target.focus();
		return;
	}
	
	let url = "${pageContext.request.contextPath}/admin/main/update";
	let query = "?new_year_target="+new_year_target;
	
	
	try {
		location.href = url + query;
		alert("새로운 매출 목표로 변경되었습니다!");
		location.href = "${pageContext.request.contextPath}/admin/perform/main_sales";
		
	} catch (e) {
		alert("변경에 실패했습니다.");
	}

	
}





</script>