<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-perform.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.2.2/echarts.min.js"></script>






<script >
$(window).ready(function(){
	
	let cha = $(".year_cha").val();
	
	   draw(cha, '.pie-chart1', '#004b81');
	});

	function draw(max, classname, colorname){
	   var i=1;
	    var func1 = setInterval(function(){
	      if(i<max){
	          color1(i,classname,colorname);
	          i++;
	      } else{
	        clearInterval(func1);
	      }
	    },10);
	}
	function color1(i, classname,colorname){
	   $(classname).css({
	        "background":"conic-gradient("+colorname+" 0% "+i+"%, #ffffff "+i+"% 100%)"
	   });
	}

	
	
$(function(){
	$(".sales__goals__area__btn").click(function(){
		$("#updateModal").modal('show');
	});

})



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
			text: '주간 매출 통계'  
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


$(function(){
	let url = "${pageContext.request.contextPath}/admin/perform/line2";
	
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
				text: '회원 구독 현황'
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
			<span style="font-family: 'line_font_b';">Performance Review</span>
		</div>
		<div class="pb-1">
			<button type="button" class="print_btn shadow-sm" onclick="location.href='${pageContext.request.contextPath}/admin/perform/print';"><i class="fa-solid fa-print"></i>&nbsp;&nbsp; 전체화면  print </button>
			<button type="button" class="reload_btn shadow-sm" onclick="reload();"><i class="fa-solid fa-repeat"></i>&nbsp;&nbsp;새로고침</button>
		</div>
	</div>
</div>



<!-- 오늘 토탈 조회수  / 오늘 토탈 매출 / 월 토탈 조회수 / 월 토탈 매출 -->
<div class="row">
	<div class="today__cnt__container shadow-sm row side__by__side ">
		<div class="col">
			<div class="today__cnt__date">${sysdate}</div>
			<div class="today__cnt__title">오늘 총 조회수</div>
		</div>
		<div class="col">
			<div class="today__member__cnt">${today_hitCount}</div>
		</div>
	</div>
	
	<div class="today__cnt__container shadow-sm row side__by__side2">
		<div class="col">
			<div class="today__cnt__date">${sysdate}</div>
			<div class="today__cnt__title">오늘 전체 매출</div>
			<div class="today__member__cnt">${toady_sales}</div>
		</div>
		<div class="col" style="margin-left: 45px;">
			<c:if test="${sales_cha < 0}">
				<div class="chart__icon__blue"><i class="fa-solid fa-arrow-trend-down"></i></div>
			</c:if>
			<c:if test="${sales_cha >= 0}">
				<div class="chart__icon__plus"><i class="fa-solid fa-arrow-trend-up"></i></div>
			</c:if>
			<div class="${sales_cha < 0 ? 'today__member__percent__minus' : 'today__member__percent__plus'}">${sales_cha < 0 ? "▼":"▲"}&nbsp;${sales_cha}</div>
		</div>
	</div>
	
	
	<div class="today__cnt__container shadow-sm row side__by__side2">
		<div class="col">
			<div class="today__cnt__date">${month}</div>
			<div class="today__cnt__title">월 전체 매출</div>
			<div class="today__member__cnt">${month_sales}</div>
		</div>
		<div class="col" style="margin-left: 45px;">
			<c:if test="${month_cha < 0}">
				<div class="chart__icon__blue"><i class="fa-solid fa-arrow-trend-down"></i></div>
			</c:if>
			<c:if test="${month_cha >= 0}">
				<div class="chart__icon__plus"><i class="fa-solid fa-arrow-trend-up"></i></div>
			</c:if>
			<div class="${month_cha < 0 ? 'today__member__percent__minus' : 'today__member__percent__plus'}">${month_cha < 0 ? "▼":"▲"}&nbsp;${month_cha}</div>
		</div>
	</div>
	
	
	<div class="today__cnt__container shadow-sm row side__by__side2">
		<div class="col">
			<div class="today__cnt__date">${year}년</div>
			<div class="today__cnt__title">매출 목표 & 달성률</div>
			<div class="today__member__cnt">${year_target}</div>
		</div>
		<div class='col'>
		    <div class="pie-chart pie-chart1"><span class="center">${year_cha}%</span></div>
		    <input type="hidden" value="${year_cha}" name="year_cha" class="year_cha">
		</div>
	</div>
	
</div>



<!-- 연 매출 목표 보기 / 연 매출 금액 / 연 매출 목표 수정하기 버튼 -->
<div class="row">
	<div class="sales__goals__area shadow-sm">
	<div class="sales__goals__title">NewsOcean company's Sales goals</div>
		<span class="sales__icon">💰 ${year}년 매출 목표&nbsp; <span style="font-family: 'line_font_b';">${year_target}원</span> , &nbsp; 전체 매출금액&nbsp; <span style="color: #FF0066; font-family: 'line_font_b';">${year_sales}</span>원 입니다. (${sysdate} 기준) </span>
		<span></span>
		<span></span>
	</div>
	<div class="sales__goals__area__btn  shadow-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">매출 목표 변경/등록</div>
</div>




<!-- 본문 차트 그래프 부분 -->
<div class="perform__title2" style="display: flex; justify-content:space-between;"> 
	<span style="font-family: 'line_font_b';">매출 통계 및 유료 구독 비율<button class="more__sales">+ 더보기</button></span>
</div>

<div class="row">
	<div class="chart-1 shadow-sm" id="chart-1">
		
	</div>
	<div class="chart-2 shadow-sm" id="chart-2">
		
	</div>
</div>


<!-- 본문 순위 rank / 1.조회수 순위 2.좋아요 순위 3.인기검색어 -->
<div class="perform__title2" style="display: flex; justify-content:space-between;"> 
	<span style="font-family: 'line_font_b'; margin-left: 10px;">금주 컨텐츠 랭킹</span>
	<span style="font-family: 'line_font_b'; margin-right: 230px;" >매출 내역<button class="more__sales">+ 더보기</button></span>
	
</div>

<div class="row">
	<div class="rank-1 shadow-sm">
		<div class="rank1__block row" >
			<span class="col" >순위</span>
			<span class="col" style="margin-left: 40px;">내용</span>
			<span class="col" style="margin-left: 40px;">조회수</span>
		</div>
		<c:forEach var="r1" items="${ranklist1}" varStatus="status">
			<div class="rank1__block__area row">
				<span class=" area__rank" style="width: 15px; margin-left: 20px; ">${rank_num+status.index}</span>
				<span class=" area__con" >${r1.title}</span>
				<span class=" area__hit" style="width: 30px;" >${r1.hitCount}</span>
			</div>
		</c:forEach>

		
	</div>
	<div class="rank-1 shadow-sm" >
		<div class="rank1__block row" >
			<span class="col" >순위</span>
			<span class="col" style="margin-left: 40px;">내용</span>
			<span class="col" style="margin-left: 40px;">❤️수</span>
		</div>
		<c:forEach var="r2" items="${ranklist2}" varStatus="status">
			<div class="rank1__block__area row">
				<span class=" area__rank" style="width: 15px; margin-left: 20px; ">${rank_num+status.index}</span>
				<span class=" area__con" >${r2.title}</span>
				<span class=" area__hit" style="width: 30px;" >${r2.dataLike}</span>
			</div>
		</c:forEach>

		
	</div>
	<div class="rank-1 shadow-sm">
		<div class="rank1__block row" >
			<span class="col" >순위</span>
			<span class="col" style="margin-left: 40px;">내용</span>
			<span class="col" style="margin-left: 40px;">조회수</span>
		</div>
		<div class="rank1__block__area row">
			<span class=" area__rank" style="width: 15px; margin-left: 20px; ">1</span>
			<span class=" area__con" style="width: 188px; margin-left: 7px;">뉴스 내용...</span>
			<span class=" area__hit" style="width: 30px;" >56</span>
		</div>

		
	</div>
	<div class="sales-1 ">
		<c:forEach var="dto" items="${listSales}" varStatus="status">
			<div class="sales_block shadow-sm">
				<div style="font-family: 'line_font_b';"> ${dto.paid_at} </div>
				<span style="font-size: 13px;" >계정 : ${dto.email}</span>
				<span style="margin-left: 20px; font-family: 'line_font_b'; font-size: 18px;">💵  ${dto.paid_amount}</span>
			</div>
		</c:forEach>
	</div>
	
</div>





<!-- 모달!! -->
<div class="modal" tabindex="-1" id="updateModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">연간 목표 수정하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p style="font-size: 15px;">${year}년 올해 연간 매출 목표는 ${year_target} 입니다. 변경하시겠습니까?</p>
        <span>새로운 매출 목표 금액 : </span><input class="new__input" type="text" name="new_year_target">
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



//매출 목표 변경
function updateOk(){
	let new_year_target = $(".new__input").val();
	
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
	
	let url = "${pageContext.request.contextPath}/admin/perform/update";
	let query = "?new_year_target="+new_year_target;
	
	
	try {
		location.href = url + query;
		alert("변경 완료 되었습니다.");
		location.href = "${pageContext.request.contextPath}/admin/perform/main";
		
	} catch (e) {
		alert("변경에 실패했습니다.");
	}

	
}


	


</script>