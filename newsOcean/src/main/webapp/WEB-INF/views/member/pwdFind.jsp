<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
.container {
	display: contents;
}
</style>

<script type="text/javascript">
function sendOk() {
	const f = document.pwdForm;

	let str = f.email.value.trim();
	if(!str) {
		alert("이메일을 입력하세요. ");
		f.email.focus();
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
							<p class="form-control-plaintext text-center">이메일을 입력하세요.</p>
		                </div>
                        
                        <div class="d-grid">
                            <input type="text" name="email" class="form-control form-control-lg" placeholder="newsocean@naver.com">
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