<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript">
function sendOk() {
	const f = document.pwdForm;

	let str = f.userId.value.trim();
	if(!str) {
		alert("아이디를 입력하세요. ");
		f.userId.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/member/pwdFind";
	f.submit();
}
</script>

<div class="container">
	<div class="body-container">	

        <div class="row justify-content-md-center">
            <div class="col-md-7">
                <div class="border mt-5 p-4">
                    <form name="pwdForm" method="post" class="row g-3">
                        <h3 class="text-center fw-bold">패스워드 찾기</h3>
                        
		                <div class="d-grid">
							<p class="form-control-plaintext text-center">회원 아이디를 입력 하세요.</p>
		                </div>
                        
                        <div class="d-grid">
                            <input type="text" name="userId" class="form-control form-control-lg" placeholder="아이디">
                        </div>
                        <div class="d-grid">
                            <button type="button" class="btn btn-lg btn-primary" onclick="sendOk();">확인 <i class="bi bi-check2"></i> </button>
                        </div>
                    </form>
                </div>

                <div class="d-grid">
					<p class="form-control-plaintext text-center py-3">${message}</p>
                </div>

            </div>
        </div>
	        
	</div>
</div>