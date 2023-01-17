<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">

<style type="text/css">

</style>

<script type="text/javascript">
function Withdrawal(){
	if($("#withdrawalcheck").is(':checked')){
		const f = document.infoForm;
		f.action = "${pageContext.request.contextPath}/mypage/withDrawal";
	    f.submit();
	}else{
		alert("회원탈퇴에 동의해야합니다.");
	}
};
function memberOk() {
	const f = document.infoForm;
	let str;
		
	if( f.nickNameValid.value === "nickNameValid") {
		str = "닉네임 중복 검사가 실행되지 않았습니다.";
		f.nickNameValid.focus();
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
    
	str = f.pwd.value;
	
	if( str !== f.pwd2.value ) {
        alert("패스워드가 일치하지 않습니다. ");
        f.pwd.focus();
        return;
	}
	if(str.length === 0){
		f.action = "${pageContext.request.contextPath}/mypage/infoSubmit";
	    f.submit();
	}else if( !/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str) ) { 
		alert("패스워드를 다시 입력 하세요. ");
		f.pwd.focus();
		return;
	}

   	f.action = "${pageContext.request.contextPath}/mypage/infoSubmit";
    f.submit();
}

function changeEmail() {
    const f = document.infoForm;
	    
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
			
			if("${dto.nickName}" ==nickName){
				passed = "true";
				
				let str = "<span style='color:blue; font-weight: bold;'>" + nickName + "</span> 기존 닉네임";
				$(".nickName-box").find(".help-block").html(str);
				$(".nickName-box").find(".help-block").css("color","blue");
				$("#nickNameValid").val("true");
			}
			else if(passed === "true") {
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
			<h3><i class="bi bi-person-square"></i> 정보수정 </h3>
		</div>
		
	    <div class="alert alert-info" role="alert">
	        <i class="bi bi-person-check-fill"></i> 오셔너🌊를 구독하면 뉴스오션만의 유익한 정보를 만날 수 있습니다.
	    </div>
		    		
		<div class="body-main">

			<form name="infoForm" method="post">
					<div class="row mb-3" style="width:1000px;">
					<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
					<div class="col-sm-10">
			            <input type="password" name="pwd" id="pwd" class="form-control" autocomplete="off" placeholder="패스워드" value="">
			            <small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
			        </div>
			    </div>
			    
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="userPwd2">패스워드 확인</label>
			        <div class="col-sm-10">
			            <input type="password" name="pwd2" id="pwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인" value="">
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
				            		readonly='readonly' placeholder="닉네임">
				        </div>
				        <div class="col-3 ps-1">
							<button type="button" class="btn btn-light" onclick="nickNameCheck();">닉네임중복검사</button>
						</div>
				        
				        <div class="row-3">
							<small class="form-control-plaintext help-block">닉네임 중복검사를 해주세요.</small>
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
			
				<input class="form-check-input" type="hidden" name="gender" id="gender-m" value="${dto.gender}">
			
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="agree">회원 탈퇴</label>
					<div class="col-sm-8" style="padding-top: 5px;">
						<label class="form-check-label text-decoration-none" for="withdrawal"><!--label-for = input-id -->
							회원탈퇴시 개인정보 및 NewsOceans 에서 만들어진 모든 데이터는 삭제됩니다. 동의합니다.
						</label>
						<input id="withdrawalcheck" type="checkbox" >
						<button type="button" id="withdrawal" name="withdrawal" class="btn btn-primary"   onclick="Withdrawal();">탈퇴</button>
					</div>
			    </div>
			     
			    <div class="row mb-3">
			        <div class="text-center">
			            <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();">정보수정 <i class="bi bi-check2"></i></button>
			            <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/mypage';">수정취소<i class="bi bi-x"></i></button>
						<input type="hidden" name="emailValid" id="emailValid" value="false">
						<input type="hidden" name="nickNameValid" id="nickNameValid" value="false">
						<input type="hidden" name="email" id="email" value="">
			        </div>
			    </div>
			</form>
			<div>
				${msg}
			</div>
		</div>
	</div>
</div>
