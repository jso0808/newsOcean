﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.containerSendComplete {
	padding-right: 20px;
}


</style>

<div class="containerSendComplete">
	<div class="body-container">	

        <div class="row justify-content-md-center mt-5">
            <div class="col-md-8">
                <div class="border bg-light mt-5 p-4">
                       <h4 class="text-center fw-bold"><i class="bi bi-envelope"></i> 메일 전송</h4>
                       <hr class="mt-4">
                       
	                <div class="d-grid p-3">
						<p class="text-center">${message}</p>
	                </div>
                       
                       <div class="d-grid">
                           <button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/sub/mail/listSendMail';">구독 메일 목록으로 <i class="bi bi-check2"></i> </button>
                       </div>
                </div>

            </div>
        </div>
	        
	</div>
</div>