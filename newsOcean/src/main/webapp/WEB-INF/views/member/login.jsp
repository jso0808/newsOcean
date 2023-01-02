<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.container {
	display: inline-block;
}
.body-container {
	max-width: 800px;
}
.body-container-login {
	display: flex;
    justify-content: flex-end;
}
</style>

<script type="text/javascript">
function sendLogin() {
    const f = document.loginForm;
	let str;
	
	str = f.userId.value.trim();
    if(!str) {
        f.userId.focus();
        return;
    }

    str = f.userPwd.value.trim();
    if(!str) {
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/login";
    f.submit();
}
</script>

<div class="container" style="margin-bottom: 80px; margin-top: 10px;">
	<div class="body-container-login">	

        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="border mt-5 p-4">
                    <form name="loginForm" action="" method="post" class="row g-3">
                        <h3 class="text-center"><i class="bi bi-lock"></i> 오셔너 로그인</h3>
                        <div class="col-12">
                            <label class="mb-1">이메일</label>
                            <input type="text" name="userId" class="form-control" placeholder="user@naver.com">
                        </div>
                        <div class="col-12">
                            <label class="mb-1">패스워드</label>
                            <input type="password" name="userPwd" class="form-control" autocomplete="off" 
                            	placeholder="패스워드">
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">이메일 저장</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <button type="button" class="btn btn-primary float-end" onclick="sendLogin();">&nbsp;Login&nbsp;<i class="bi bi-check2"></i></button>
                        </div>
                    </form>
                    <hr class="mt-4">
                    <div class="col-12">
                        <p class="text-center mb-0">
                        	<a href="#" class="text-decoration-none me-2">이메일 찾기</a>
                        	<a href="${pageContext.request.contextPath}/member/pwdFind" class="text-decoration-none me-2">패스워드 찾기</a>
                        	<a href="${pageContext.request.contextPath}/member/member" class="text-decoration-none">회원가입</a>
                        </p>
                    </div>
                </div>

                <div class="d-grid">
						<p class="form-control-plaintext text-center text-primary">${message}</p>
                </div>

            </div>
        </div>

	</div>
</div>