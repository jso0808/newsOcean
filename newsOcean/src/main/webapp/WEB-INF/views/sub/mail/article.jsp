<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.div-subject {
	font-size: 25px;
}

.div-text{
	font-size: 16px;
}

.cnt{
	font-size: 18px;
	color: red;
}

.div-content {
	background-color: #E8DCCA;
	
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript">

</script>

<div class="">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="fa-solid fa-envelope-open-text"></i> 구독 메일 발신함 </h3>
		</div>
		
		<div class="body-main">

			<table class="table mb-0">
				<thead>
					<tr>
						<td colspan="2" align="center">
							<div class="div-subject">${dto.subject}</div>
						</td>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td width="50%">
							 <div class="div-text">작성한 서퍼 : ${dto.senderName}  (${dto.senderEmail})</div>
						</td>
						<td align="right">
							<div class="div-text"> 수신한 구독자 수 : <span class="cnt">${dto.cnt}</span></div>
						</td>
					</tr>
					
					<tr class="div-text">
						<td class="div-content" colspan="2" valign="top" height="200" style="background-color: #E8DCCA; padding-top:40px;">
							${dto.content}
						</td>
					</tr>
					
					<tr>
						<td colspan="2">
							이전글 :
							<c:if test="${not empty preDto}">
								<a href="${pageContext.request.contextPath}/sub/mail/article?${query}&mailNo=${preDto.mailNo}">${preDto.subject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							다음글 :
							<c:if test="${not empty nextDto}">
								<a href="${pageContext.request.contextPath}/sub/mail/article?${query}&mailNo=${nextDto.mailNo}">${nextDto.subject}</a>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="table table-borderless">
				<tr>
					<td class="text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sub/mail/listSendMail?${query}';">리스트</button>
					</td>
				</tr>
			</table>
			
		</div>
	</div>
</div>