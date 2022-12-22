<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt" %>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.main-container {
	display: contents;
}

.div-sub{
	width: 800px;
	height: 80%;
	display: flex;
    align-content: flex-end;
    justify-content: space-around;
}

.div-sub-pass {
	width: 300px;
	height: 300px;
	padding: 50px;
	text-align: center;
	border-radius: 30px;
	background: #9DE4FF
}

.div-subContent {
	text-align: center;
	display: flex;
    justify-content: center;
}

</style>


<div class="main-container">
	<div class="body-container">	
		<div class="body-title">
			뉴스오션을 구독해보세요 !
		</div>
		    		
		<div class="body-main div-sub">
			<div class="row">
				<div class="col-sm-1 div-sub-pass div-subMonth">
					<div class="div-subContentTitle">1개월 구독권</div>	
					<div class="div-subContentPrice">3,000원</div>
				</div>
				
				<div class="col-sm-1 div-sub-pass div-subYear">
					<div class="row div-subContent div-subContentTitle">
						<div class="col">12개월 구독권</div>	
					</div>
					<div class="row div-subContent div-subContentPrice">
						<div class="col">월 2,500원</div>
					</div>
					<div class="row div-subContent div-subContentRealPrice">
						<div class="col">30,000원</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</div>



</body>
</html>