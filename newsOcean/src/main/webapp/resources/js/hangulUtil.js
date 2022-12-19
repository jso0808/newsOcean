// 한글 필터링
function isValidKorean(data){
     // UTF-8 코드 중 AC00부터 D7A3 값인지 검사
    // var p = /^[가-힣]+$/;
    let p = /^[\uac00-\ud7a3]+$/g;
    return p.test(data);
}

// 한글만 입력 허용
function onlyKorean(event) {
	if((event.keyCode < 12592) || (event.keyCode > 12687)) {
		event.preventDefault();
    }
}
/*
// 사용 방법
window.addEventListener('load', function () {
	let inputElement;
	inputElement = document.querySelector('.inputKor');
	inputElement.addEventListener('keypress', event => onlyKorean(event));
});
*/

// 한글 삭제
function deleteKorean(event) {
	// keypress에서는 bs, tab키, <-, -> 키등은 인식하지 않음
	// backspace : 8, horizontal tab : 9, <-:37, ->:39, delete:46
    if(event.keyCode === 8 || event.keyCode === 9 || event.keyCode === 37 
    		|| event.keyCode === 39 || event.keyCode === 46 ) {
    	return;
	}
    
    // 자음, 모음, 한글을 지움
    let obj = event.currentTarget;
    obj.value = obj.value.replace(/[ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}

// inputElement 객체의 한글 입력 제한
function notKorean(inputElement) {
	inputElement.addEventListener('input', function(e){
		let obj = e.currentTarget;
		// obj.value = obj.value.replace(/[^\w]/g, "");
		obj.value = obj.value.replace(/[\W]/g, "");
	});
}
