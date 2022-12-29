<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	
	<h3> 결제 성공 야호 ~ 🤩 </h3>
	
	결제일시:     ${payInfo.approved_at}<br/>
	주문번호:    ${payInfo.partner_order_id}<br/>
	상품명:    ${payInfo.item_name}<br/>
	상품수량:   ${payInfo.quantity}<br/>
	결제금액:    ${payInfo.amount.total}<br/>
	결제방법:    ${payInfo.payment_method_type}<br/>
	 

</body>
</html>