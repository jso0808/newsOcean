<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<c:if test="${not empty keywordList}">
   <div class="main_title_intro"><img style="width: 60px; " src="${pageContext.request.contextPath}/resources/images/man_swim.gif"> 관심 키워드 추천 뉴스 </div>
   		<div class="keyword__list__container">
   				<span class="keyword__list__st__click shadow-sm ">전체 추천 뉴스</span>
   			<c:forEach items="${keywordList}" var="kk">
   				<span class="keyword__list__st shadow-sm">${kk.keywordName}</span>
   			</c:forEach>
   		</div>
	   <div class="row" style="margin-bottom: 40px; ">
	   			<div class="pick_news_container shadow">
					<div class="pick_news_title row" >
						<span class=" " style="margin-left: 5px; width: 100px;">키워드</span>
						<span class="  " style="margin-left: 50px; padding-left:50px; width: 600px;">뉴스 제목</span>
						<span class=" " style=" width: 200px;">업로드 일자</span>
					</div>
					<c:forEach items="${pick_news}" var="pick">
						<div class="pick_news_span row" >	
								<span class=" " style="margin-left: 5px; width: 100px;">${pick.keyword}</span>
								<span class=" " style="width: 600px; padding-left: 30px; "  onclick="location.href='${pageContext.request.contextPath}/news/article?crawlUrl=${pick.pickLink}';">${pick.pickTitle}</span>
								<span class=" " style="width: 200px; margin-left: 10px;" >${pick.pickDate}</span>
						</div>
					</c:forEach>
					
					<div class="page-navigation">
						${paging}
					</div>

				</div>
			
		</div>
</c:if>	