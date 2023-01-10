<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-perform.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.2.2/echarts.min.js"></script>


<script>
//차트  --------------------------------------------
$(function(){
	let url = "${pageContext.request.contextPath}/admin/perform/line2";
	
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


//회원 구독 통계 - 메인꺼
$(function(){
	let url = "${pageContext.request.contextPath}/admin/main/line2";
	
	//제이슨 방식. GET 밖에 없다.
	$.getJSON(url, function(data){
		
		var chartDom = document.getElementById('chart-2');
		var myChart = echarts.init(chartDom);
		var option;
		
		option = {
		  tooltip: {
		    trigger: 'item'
		  },
		  title : {
				text: '  회원 구독 현황'
		  },
		  legend: {
		    top: '0%',
		    orient: 'vertical',
		    left: 'right'
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
			<span style="font-family: 'line_font_b';">Content Data</span>
		</div>
		<div class="pb-1">
			<button type="button" class="print_btn shadow-sm" onclick="location.href='${pageContext.request.contextPath}/admin/perform/excel_member';"><i class="fa-solid fa-file-excel"></i>&nbsp;&nbsp; EXCEL 파일 다운로드 </button>
			<button type="button" class="reload_btn shadow-sm" onclick="reload();"><i class="fa-solid fa-repeat"></i>&nbsp;&nbsp;새로고침</button>
		</div>
	</div>
</div>


<!-- 본문 차트 그래프 부분 -->
<div class="print-body">
	<div class="perform__title2" style="display: flex; justify-content:space-between;"> 
		<span style="font-family: 'line_font_b';">가입자수 통계<button class="more__sales" onclick="updateKpi();">+ KPI 등록/수정 </button></span>
	</div>
	
	<div class="row">
		<div class="chart-1 shadow-sm" id="chart-1"></div>
		<div class="chart-2 shadow-sm" id="chart-2"></div>
	</div>
	
	<div class="perform__title3" style="display: flex; justify-content:space-between;"> 
		<span style="font-family: 'line_font_b'; margin-left: 20px;" >일자별 가입자 내역<span class="hit__title">컨텐츠 조회수</span></span>
	</div>
	
	
	<!-- 테이블 리스트 영역 -->
	<div class="row"> 
		<div class="tb__area " ></div>
		<div class="tb__area2 " ></div>
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
	location.href = "${pageContext.request.contextPath}/admin/perform/main_content";
}


$(function(){
	listPage(1);
	listPage2(1);
	
});


//테이블 리스트 
function listPage(page) {
	let url = "${pageContext.request.contextPath}/admin/perform/list_member";
	let query = "pageNo="+page;
	let selector = ".tb__area";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}

//테이블 리스트  - 2
function listPage2(page) {
	let url = "${pageContext.request.contextPath}/admin/perform/list_hitcount";
	let query = "pageNo="+page;
	let selector = ".tb__area2";
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url, "get", query, "html", fn);

}
	


</script>