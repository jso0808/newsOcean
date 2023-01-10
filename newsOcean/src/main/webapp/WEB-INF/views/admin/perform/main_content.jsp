<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-perform.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.2.2/echarts.min.js"></script>

<script type="text/javascript">
function onPrint() {
	// 배경이미지 출력 : 크롬 - 인쇄 - 설정 더보기 - 배경 그래픽 선택
	const printContents = document.querySelector(".print-body").innerHTML;
	let originalContents = document.body.innerHTML;
	
	document.body.innerHTML = printContents;
	// document.close();
	window.focus();
	
	window.print();
	
	document.body.innerHTML = originalContents;
}
</script>



<style>
@media print {
.today__cnt__container {
	width: 300px;
	background: #fff;
	border-radius: 15px;
	height: 90px;
	margin-left: 10px;
	
}

.today__cnt__date {
	color: 	#999999;
	font-size: 10px;
	font-family: 'line_font_b';
	margin-top: 10px;
	margin-left: 8px;

}

.today__cnt__title {
	color: 	#333333;
	font-size: 13px;
	font-family: 'line_font_b';
	padding-left: 7px;
	
}

.today__member__cnt {
	font-size: 26px;
	font-family: 'line_font_b';
	color: 	#000;
	margin-left: 5px;
}

.today__member__percent__plus {
	font-size: 11px;
	font-family: 'line_font_b';
	color: 	#FF0066;
	
}

.today__member__percent__minus {
	font-size: 11px;
	font-family: 'line_font_b';
	color: 		#0066FF	;
	margin-left: 2px;
	
}

.chart__icon__blue {
	font-size: 47px;
	padding-top: 7px;
	font-weight: 600;
	margin-bottom: -12px;
	color: 	#0066FF	;
}

.chart__icon__plus {
	font-size: 47px;
	padding-top: 7px;
	font-weight: 600;
	margin-bottom: -12px;
	color: #FF0066;
	
}


.side__by__side {margin-left: 40px;}
.side__by__left{margin-left: 120px;}
.side__by__side2{margin-left: 50px;}

.reload_btn {
	height: 40px;
    text-align: center;
    vertical-align: middle;
    border-radius: 20px;
    width: 120px;
    border: none;
    background: #fff;
}

/*제목*/
.perform__title {
	color: #595959;
	font-size: 22px;
	font-family: line_font_b;
	margin-left: 10px;
	margin-top: 5px;
}

.perform__title2 {
	color: #595959;
	font-size: 18px;
	font-family: line_font_b;
	margin-left: 30px;
	margin-bottom: 20px;
	margin-top: 40px;
}

.perform__title3 {
	color: #595959;
	font-size: 18px;
	font-family: line_font_b;
	margin-left: 30px;
	margin-bottom: -10px;
	margin-top: 40px;
	
}


/*프린트 버튼*/
.print_btn {
	height: 40px;
    text-align: center;
    vertical-align: middle;
    border-radius: 10px;
    width: 210px;
    border: none;
    background: #fff;
    margin-right: 7px;
    background: linear-gradient( to right, #004b81, #9999FF );
    color: #fff;
    font-family: 'line_font_b';
}

.print_btn:hover {
	 background: #fff;
	 color: #595959;
	
	 transition: .5s;
	
}

/*main 페이지 디자인 요소 */


.chart-1 {
	background: #fff;
	width: 920px;
	margin-left: 40px;
	border-radius: 20px;
	height: 340px;
	padding-left: -130px;
	padding-right: -150px;
	padding-top: 25px;
	
}

.chart-1_sales {
	background: #fff;
	width: 1300px;
	margin-left: 40px;
	border-radius: 20px;
	height: 340px;
	padding-left: -130px;
	padding-right: -150px;
	padding-top: 25px;
}

.chart-2 {
	background: #fff;
	width: 350px;
	margin-left: 40px;
	border-radius: 20px;
	height: 340px;
	padding-top: 25px;
	
}

.sales__table {
	background: #fff;
	width: 1320px;
	margin-left: 40px;
	border-radius: 5px;
	height: 490px;
	padding-top: 30px;
	padding-left: 40px;
	margin-top: 37px;
	margin-bottom: 40px;
	
}


/*도넛 차트*/
.pie-chart {
  position: relative;
  display:inline-block;
  width: 67px;
  height: 67px;
  border-radius: 50%;
  transition: 0.3s;
  margin-top: 10px;
  margin-left: 5px;
  border: 2px solid #004b81;
}

span.center{
  background: #eee;
  display : block;
  position: absolute;
  top:50%; left:50%;
  width:40px; height:40px;
  border-radius: 50%;
  text-align:center; 
  line-height: 40px;
  font-family:'line_font_b';
  font-size:10px;
   transform: translate(-50%, -50%);
}


.sales__goals__title {
	font-family: 'line_font_b';
	color: #999999;
	margin-left: 30px;
	font-size: 12px;
	margin-bottom: 3px;
	margin-top: 3px;
}

.sales__goals__area {
	width: 1135px;
    background: #fff;
    border-radius: 22px;
    height: 80px;
    margin-left: 40px;
    margin-top: 20px;
    padding-top: 11px;
    padding-left: 30px;
}

.sales__goals__area__btn {
	width: 160px;
	margin-left: 20px;
    margin-top: 33px;
    height: 55px;
    text-align: center;
    background: #004b81;
    border-radius: 15px;
    vertical-align: middle;
    padding-top: 17px;
    font-family: 'line_font_b';
    font-size: 16px;
    color: #fff;
}

.sales__goals__area__btn:hover {
	width: 160px;
	margin-left: 20px;
    margin-top: 33px;
    height: 55px;
    text-align: center;
    background: #fff;
    border-radius: 15px;
    vertical-align: middle;
    padding-top: 17px;
    font-family: 'line_font_b';
    font-size: 16px;
    color: #595959;
    transition: 0.3s;
    cursor: pointer;
}



.sales__icon {
	font-size: 22px;
	color: #000;
	font-family: 'line_font_b';
	
}

.new__input {
	width: 200px;
	height: 24px;
	margin-left: 10px;
	border: 1px solid #595959;
	border-radius: 5px;
	padding-left: 7px;
}


/*랭킹 블럭 - 첫번째 영역*/
.rank-1{
	border-radius: 20px;
	margin-left: 33px;
	background: #fff;
	width: 300px;
	height: 300px;
	overflow: scroll;
	
	-ms-overflow-style: none; /* 인터넷 익스플로러 */
    scrollbar-width: none;
	
}

.rank-1::-webkit-scrollbar {
    display: none; /* 크롬, 사파리, 오페라, 엣지 */
}

/*제목*/
.rank1__block {
 	color: #fff;
 	font-size: 13px;
 	background: #004b81;
 	padding-top: 15px; 
 	padding-bottom: 5px; 
 	padding-left: 10px;
 	
 	
}

.rank1__block span {
	font-family: 'line_font_b';
}

.rank1__block__area {
	height: 33px;
	background: #fff;
	padding-top: 5px;
	border-bottom: 1px solid #eee;
	margin-bottom: 7px;
	margin-top: 5px;
}

.rank1__block__area:hover {
	cursor: pointer;
	background: #eee;
	transition: 0.3s;
}


.rank1__block__area:nth-child(-n+4) span:first-child {
	color: #FF0066;
	font-family: 'line_font_b';	
}

/*랭킹 내용 영역*/
.area__con {
	width: 188px; 
	margin-left: 7px;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
	
}

.hit__title {
	font-family: 'line_font_b';	
	margin-left: 550px;
	display: inline-block;
}

/*테이블 출력 리스트*/
.tb__area {
	width: 650px; 
	margin-left: 30px; 
	margin-top: 30px;
}

.tb__area2 {
	width: 650px; 
	margin-left: 30px; 
	margin-top: 30px;
}

/*매출 테이블은 전체사이즈*/
.tb__area__sales {
	width: 1320px; 
	margin-left: 30px; 
	margin-top: 30px;
	
}


.tb__border {
	border: 1px solid #a0a0a0;
}

.tb__font td {
	font-size: 11px;
	background: #fff;
	border-right: 0.5px solid #C0C0C0;
}

.tb__font:hover {
	cursor: pointer;
	background: #eee;
	transition: 0.3s;
}

.tb__font__title th {
	font-family: 'line_font_b';
	color: #fff;

}


/*인쇄버튼*/

.more__sales {
	background: #004b81;
	margin-left: 15px;
	border: none;
	font-size: 12px;
	color: 	#fff;
	font-family: 'line_font_b';
	width: 94px;
	padding-right: 4px;
	padding-top: 2px;
	padding-bottom: 1px;
	vertical-align: middle;

}

.more__sales__large {
	background: #004b81;
	margin-left: 15px;
	border: none;
	font-size: 12px;
	color: 	#fff;
	font-family: 'line_font_b';
	width: 122px;
	padding-right: 4px;
	padding-top: 2px;
	padding-bottom: 1px;
	vertical-align: middle;
	
}

.modal__main__btn {
	border: none;
	background: #004b81;
	border-radius: 4px;
	width: 100px;
	height: 30px;
	color: #fff;
	font-family: 'line_font_b';
	font-size: 13px;
	margin-bottom: 10px;
	
}

.modal__main__btn2 {
	border: none;
	background: #ffcc44;
	border-radius: 4px;
	width: 90px;
	height: 30px;
	color: #fff;
	font-family: 'line_font_b';
	font-size: 13px;
	margin-bottom: 10px;
	margin-right: 8px;
	
}

.modal_table_title th {
	font-family: 'line_font_b';
	
}

.new_title {
	font-family: 'line_font_b';
	margin-left: 20px;
}

.new_input {
	height: 30px;
	border-radius: 5px;
	border: 1px solid #595959;
	padding-left: 7px;
	margin-left: 10px;
	
}

}
</style>


<script >

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
			<button type="button" class="print_btn shadow-sm" onclick="onPrint()"><i class="fa-solid fa-file-excel"></i>&nbsp;&nbsp; EXCEL 파일 다운로드 </button>
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