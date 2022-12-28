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
	
    let str = f.userPwd.value.trim();
    if(!str) {
        alert("패스워드를 입력하세요. ");
        f.userPwd.focus();
        return;
    }

	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.userPwd.focus();
		return;
	}
	
	if(f.userPwd.value !== f.userPwd2.value) {
		alert("패스워드가 일치하지 않습니다.");
		f.userPwd.focus();
		return;
	}

    f.action = "${pageContext.request.contextPath}/member/updatePwd";
    f.submit();
}
</script>

<div class="container">
	<div class="body-container">	

        <div class="row justify-content-md-center">
            <div class="col-md-7">
                <div class="border mt-5 p-4">
                    <form name="pwdForm" method="post" class="row g-3">
                        <h3 class="text-center fw-bold">패스워드 변경</h3>
                        
		                <div class="d-grid">
							<p class="form-control-plaintext text-center">안전한 사용을 위하여 기존 패스워드를 변경하세요.</p>
		                </div>
                        
                        <div class="d-grid">
                            <input type="password" name="userPwd" class="form-control form-control-lg" placeholder="패스워드">
                        </div>
                        <div class="d-grid">
                            <input type="password" name="userPwd2" class="form-control form-control-lg" placeholder="패스워드 확인">
                        </div>
		                <div class="text-center">
							<small class="form-control-plaintext">※ 5~10자 이내의 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
		                </div>
		                
                        <div class="text-center">
                            <button type="button" class="btn btn-primary" onclick="sendOk();">변경완료 <i class="bi bi-check2"></i> </button>
                            <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/';">다음에 변경 <i class="bi bi-x"></i> </button>
                        </div>
                    </form>
                </div>

                <div class="d-grid">
					<p class="form-control-plaintext text-center">${message}</p>
                </div>
            </div>
        </div>
	        
	</div>
</div>