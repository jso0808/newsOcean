<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt" %>

<style type="text/css">
.body-container {
	max-width: 800px;
	max-height: 1200px;
}

.area-title{
	border-top: 100px;
	font-size: 30px;
	text-align: center;
	margin-bottom: 50px;
	margin-top: 50px;
}

.container-card {
  width: 100%;
  height: 100vh;
  justify-content: center;
  align-items: center;
  display: flex;
}

.card {
  width: 450px;
  height: 180px;
  border-radius: 5px;
  box-shadow: 0 4px 6px 0 rgba(0, 0, 0, 0.2);
  background-color: #fff;
  padding: 40px 30px;
  position: relative;
  border: 1px solid gray;
}

.main {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.card::after {
  position: absolute;
  content: "";
  height: 40px;
  right: -20px;
  border-radius: 40px;
  z-index: 1;
  top: 70px;
  background-color: #fff;
  width: 40px;
  border-left: 1px solid gray;
}

.card::before {
  position: absolute;
  content: "";
  height: 40px;
  left: -20px;
  border-radius: 40px;
  z-index: 1;
  top: 70px;
  background-color: #fff;
  width: 40px;
  border-right: 1px solid gray;
}

.co-img img {
  width: 100px;
  height: 100px;
}
.vertical {
  border-left: 5px dotted black;
  height: 100px;
  position: absolute;
  left: 40%;
}

.content-card {
	display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.content-card h1 {
  font-size: 30px;
  color: #565656;
  display: inline-block;
  
}

.content-card h1 span {
  font-size: 25px;
  padding-left: 10px;
}
.content-card h2 {
  font-size: 18px;
  color: #565656;
  text-transform: uppercase;
}

.content-card p {
  font-size: 16px;
  color: #696969;
}

.div-area1 {
	margin-bottom: 50px;
}

.subType {
	font-size: 20px;
	padding-bottom: 10px;
}

.btn-card {
	margin-bottom: 50px;
}

</style>


<script type="text/javascript">
$(function() {
	
	
	
});


</script>


<div class="main-container">
	<div class="body-container">	
		<div class="area-title"></div>
		
		<div class="body-main">
		
			<!-- 페이지 타이틀, 최신순 버튼 -->
			<div class="row div-area1">
				<div class="col-9">
					<div>리스트</div>
				</div>
				<div class="col-3">
					<div>
						<select class="form-select">
							<option selected="selected" value="seqNew">최신순</option>
							<option value="seqOld">오래된순</option>
						</select>
					</div>
				</div>
			</div>
			
			<!-- 구독권 리스트 -->
			<div class="row div-area2">
				<div class="div-subList">
					<c:forEach var="dto" items="${list}">
						<div class="card btn btn-card">
							<div class="main">
								<div class="co-img">
									<img class="img-circle"
										src="${pageContext.request.contextPath}/resources/images/logo_circle_gray.png"
										alt="" />
								</div>
								<div class="vertical"></div>
								<div class="content-card">
									<div class="subType">1개월 구독권</div>
									<div class="subDate">
										${dto.subStart} ~ ${dto.subEnd}
									</div>
									<c:if test="${dto.subEnd != 'update'}">
									
									</c:if>
									<div>구독 중</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<div class="card btn btn-card">
						<div class="main">
							<div class="co-img">
								<img class="img-circle"
									src="${pageContext.request.contextPath}/resources/images/logo_circle_gray.png"
									alt="" />
							</div>
							<div class="vertical"></div>
							<div class="content-card">
								<div class="subType">1개월 구독권</div>
								<div class="subDate">
									2022.11.30 ~ 2022.12.30
								</div>
								<div>구독 종료</div>
							</div>
						</div>
					</div>
					<!-- 
					<c:forEach var="dto" items="${list}">
						<div>${sessionScope.member.memberNo}</div>
						<div>${sessionScope.member.nickName}</div>
						<div>${dto.subStart}</div>
						<div>${dto.subEnd}</div>
						<div>${dto.firstMail}</div>
						<div>${dto.merchant_uid}</div>
					</c:forEach>
					 -->
				</div>
				
			</div>
		</div>
	</div>
</div>
	<!--  
	<c:forEach var="dto" items="${list}">
		<h4>${sessionScope.member.memberNo}</h4>
		<h4>${sessionScope.member.nickName}</h4>
		<h4>${dto.subStart}</h4>
		<h4>${dto.subEnd}</h4>
		<h4>${dto.firstMail}</h4>
		<h4>${dto.merchant_uid}</h4>
	
	</c:forEach>
	-->