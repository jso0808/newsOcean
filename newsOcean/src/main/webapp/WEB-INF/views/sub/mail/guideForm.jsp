<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="guideForm">
<p style="text-align:center;">
    &nbsp;
</p>
<p style="text-align:center;">
    <span style="font-family:나눔고딕, NanumGothic, Arial;font-size:21px;"><strong>NEWS OCEAN</strong></span>
</p>
<p style="text-align:center;">
    <span style="font-size:17px;">제 1호</span>
</p>
<p style="text-align:center;">
    <span style="font-size:17px;" class="sendDate">2023-xx-xx</span>
</p>
<hr>
<p style="text-align:center;">
    &nbsp;
</p>
<p style="text-align:center;">
    <span style="font-size:21px;"><strong>🏄‍♀️ 오늘의 뉴스 오션 🏄‍♀️</strong></span>
</p>
<br>
<c:forEach var="dto" items="${list}" varStatus="status">						
	<p style="text-align:center;">
	    <span style="font-size:19px;" class="news__title">✔ ${dto.crawlTitle}</span>
	</p>
</c:forEach>

<p style="text-align:center;">
    &nbsp;
</p>
<hr>
<p style="text-align:center;">
    &nbsp;
</p>

<c:forEach var="dto" items="${list}" varStatus="status">	
	<p>
	    <span style="font-size:21px;"><strong class="news__1_title">${dto.crawlTitle}.</strong></span>&nbsp;
	</p>
	<p class="news__1_content">
	   ${dto.crawlSummary} &nbsp;
	</p>
	<p style="text-align:center;">
	    &nbsp;
	</p>
</c:forEach>


</div>