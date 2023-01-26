<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.main-container {
	display: flex;
}

.help-block {
	color: red;
}
</style>

<script type="text/javascript">
function memberOk() {
	const f = document.memberForm;
	let str;
	
	str = f.email1.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    str = f.email2.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

	let mode = "${mode}";
	if(mode === "member" && f.emailValid.value === "false") {
		str = "이메일 중복 검사가 실행되지 않았습니다.";
		alert(str);
		f.email1.focus();
		return;
	}
	
	if(mode === "member" && f.nickNameValid.value === "false") {
		str = "닉네임 중복 검사가 실행되지 않았습니다.";
		alert(str);
		f.nickNameValid.focus();
		return;
	}
	
	str = f.pwd.value;
	if( !/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str) ) { 
		alert("패스워드를 다시 입력 하세요. ");
		f.pwd.focus();
		return;
	}

	if( str !== f.pwd2.value ) {
        alert("패스워드가 일치하지 않습니다. ");
        f.pwd.focus();
        return;
	}
	
    str = f.name.value;
    if( !/^[가-힣]{2,5}$/.test(str) ) {
        alert("이름을 다시 입력하세요. ");
        f.name.focus();
        return;
    }
    
    str = f.nickName.value;
    if( !str ) {
        alert("닉네임을 입력하세요. ");
        f.nickName.focus();
        return;
    }

    str = f.birth.value;
    if( !str ) {
        alert("생년월일를 입력하세요. ");
        f.birth.focus();
        return;
    }

   	f.action = "${pageContext.request.contextPath}/member/${mode}";
    f.submit();
}

function changeEmail() {
    const f = document.memberForm;
	    
    let str = f.selectEmail.value;
    if(str !== "direct") {
        f.email2.value = str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value = "";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function emailCheck() {
	// 이메일 중복 검사
	let email1 = $("#email1").val();
	let email2 = $("#email2").val();
	if(!email1) { 
		let str = "이메일을 입력해주세요";
		$("#email1").focus();
		return;
	}
	
	if(!email2) { 
		let str = "이메일을 입력해주세요";
		$("#email1").focus();
		return;
	}
	
	let url = "${pageContext.request.contextPath}/member/emailCheck";
	let email = email1 + "@" + email2
	console.log(email)
	let query = "email=" + email;
	
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			let passed = data.passed;

			if(passed === "true") {
				console.log('passed = true')
				
				let str = "<span style='color:blue; font-weight: bold;'>" + email1+"@"+email2 + "</span> 사용 가능합니다.";
				$(".email-box").find(".help-block").html(str);
				$(".email-box").find(".help-block").css("color","blue");
				$("#emailValid").val("true");
			} else {
				console.log('passed = false')
				let str = "<span style='color:red; font-weight: bold;'>" + email1+"@"+email2 + "</span> 사용할 수 없는 이메일입니다.";
				$(".email-box").find(".help-block").css("color","red");
				$(".email-box").find(".help-block").html(str);
				$("#emailValid").val("");
				$("#emailValid").val("false");
				$("#emailValid").focus();
			}
		}
	});
}

function nickNameCheck() {
	// 닉네임 중복 검사
	let nickName = $("#nickName").val();
	
	if(!nickName) { 
		let str = "닉네임을 입력해주세요";
		$("#nickName").focus();
		return;
	}
	
	let url = "${pageContext.request.contextPath}/member/nickNameCheck";
	let query = "nickName=" + nickName;
	
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			let passed = data.passed;

			if(passed === "true") {
				console.log('passed = true')
				
				let str = "<span style='color:blue; font-weight: bold;'>" + nickName + "</span> 사용 가능합니다.";
				$(".nickName-box").find(".help-block").html(str);
				$(".nickName-box").find(".help-block").css("color","blue");
				$("#nickNameValid").val("true");
			} else {
				console.log('passed = false')
				let str = "<span style='color:red; font-weight: bold;'>" + nickName + "</span> 사용할 수 없는 이메일입니다.";
				$(".nickName-box").find(".help-block").css("color","red");
				$(".nickName-box").find(".help-block").html(str);
				$("#nickNameValid").val("");
				$("#nickNameValid").val("false");
				$("#nickNameValid").focus();
			}
		}
	});
}



</script>

<div class="main-container" style="margin-bottom: 50px;">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-person-square"></i> ${mode=="member"?"회원가입":"정보수정"} </h3>
		</div>
		
	    <div class="alert alert-info" role="alert">
	        <i class="bi bi-person-check-fill"></i> 오셔너🌊가 되면 뉴스오션만의 유익한 정보를 만날 수 있습니다.
	    </div>
		    		
		<div class="body-main">

			<form name="memberForm" method="post">
				<div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="selectEmail">이메일</label>
			        <div class="col-sm-10 row email-box">
						<div class="col-3 pe-0">
							<select name="selectEmail" id="selectEmail" class="form-select" onchange="changeEmail();">
								<option value="">선 택</option>
								<option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>naver</option>
								<option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>gmail</option>
								<option value="daum.net" ${dto.email2=="daum.net" ? "selected='selected'" : ""}>daum</option>
								<option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>hotmail</option>
								<option value="direct">직접입력</option>
							</select>
						</div>
						
						<div class="col input-group">
							<input type="text" name="email1" id="email1" class="form-control" maxlength="30" value="${dto.email1}" >
						    <span class="input-group-text p-1" style="border: none; background: none;">@</span>
							<input type="text" name="email2" id="email2" class="form-control" maxlength="30" value="${dto.email2}" readonly="readonly">
						</div>		
						
						<div class="col-3 ps-1">
							<c:if test="${mode=='member'}">
								<button type="button" class="btn btn-light" onclick="emailCheck();">이메일 중복검사</button>
							</c:if>
						</div>
							
						<div class="row-3">
							<c:if test="${mode=='member'}">
								<small class="form-control-plaintext help-block">이메일 중복검사를 해주세요.</small>
							</c:if>
						</div>
					</div>
	
			    </div>
			 
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
					<div class="col-sm-10">
			            <input type="password" name="pwd" id="pwd" class="form-control" autocomplete="off" placeholder="패스워드">
			            <small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
			        </div>
			    </div>
			    
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="userPwd2">패스워드 확인</label>
			        <div class="col-sm-10">
			            <input type="password" name="pwd2" id="pwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
			            <small class="form-control-plaintext">패스워드를 한 번 더 입력해주세요.</small>
			        </div>
			    </div>
			 
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="userName">이름</label>
			        <div class="col-sm-10">
			            <input type="text" name="name" id="name" class="form-control" value="${dto.name}" 
			            		${mode=="update" ? "readonly='readonly' ":""}
			            		placeholder="이름">
			        </div>
			    </div>
			    
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="userNickName">닉네임</label>
			        <div class="col-sm-10 row nickName-box">
				        <div class="col-sm-7">
				            <input type="text" name="nickName" id="nickName" class="form-control" value="${dto.nickName}" 
				            		${mode=="update" ? "readonly='readonly' ":""}
				            		placeholder="닉네임">
				        </div>
				        
				        <div class="col-3 ps-1">
							<c:if test="${mode=='member'}">
								<button type="button" class="btn btn-light" onclick="nickNameCheck();">닉네임중복검사</button>
							</c:if>
						</div>
				        
				        <div class="row-3">
							<c:if test="${mode=='member'}">
								<small class="form-control-plaintext help-block">닉네임 중복검사를 해주세요.</small>
							</c:if>
						</div>
					</div>
			    </div>
			 
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="birth">생년월일</label>
			        <div class="col-sm-10">
			            <input type="date" name="birth" id="birth" class="form-control" value="${dto.birth}" placeholder="생년월일">
			            <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력 합니다.</small>
			        </div>
			    </div>
			
			    
		
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="gender">성별</label>
			        <div class="col-sm-10">
			           	<div class="form-check">
						  <input class="form-check-input" type="radio" name="gender" id="gender-m" value="M">
						  <label class="form-check-label" for="flexRadioDefault1">
						     	남성
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="gender" id="gender-f" value="F" checked>
						  <label class="form-check-label" for="flexRadioDefault2">
						     	여성
						  </label>
						</div>
			       		
					</div>
			    </div>
		
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
					<div class="col-sm-8" style="padding-top: 5px;">
						<input type="checkbox" id="agree" name="agree"
							class="form-check-input"
							checked="checked"
							style="margin-left: 0;"
							onchange="form.sendButton.disabled = !checked">
						<label class="form-check-label">
							<a href="#" class="text-decoration-none">이용약관</a>에 동의합니다.
						</label>
					</div>
			    </div>
			     
			    <div class="row mb-3">
			        <div class="text-center">
			            <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();"> ${mode=="member"?"회원가입":"정보수정"} <i class="bi bi-check2"></i></button>
			            <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/';"> ${mode=="member"?"가입취소":"수정취소"} <i class="bi bi-x"></i></button>
						<input type="hidden" name="emailValid" id="emailValid" value="false">
						<input type="hidden" name="nickNameValid" id="nickNameValid" value="false">
			        </div>
			    </div>
			
			    <div class="row">
					<p class="form-control-plaintext text-center">${msg}</p>
			    </div>
			</form>

		</div>
	</div>
</div>
