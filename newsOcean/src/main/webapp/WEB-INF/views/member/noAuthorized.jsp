<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<div class="container">
	<div class="body-container">	

        <div class="row justify-content-md-center mt-5">
            <div class="col-md-8">
                <div class="border border-primary mt-5 p-4">
                       <h4 class="text-center fw-bold">경고!</h4>
                       
	                <div class="d-grid pt-3">
						<p class="alert border bg-light text-center lh-base fs-6" >
							해당 정보를 접근 할 수 있는 권한 이 없습니다.<br>
							메인화면으로 이동하시기 바랍니다.
						</p>
	                </div>
                       
                       <div class="d-grid">
                           <button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/';">메인화면으로 이동 <i class="bi bi-arrow-counterclockwise"></i> </button>
                       </div>
                </div>
            </div>
        </div>

	</div>
</div>