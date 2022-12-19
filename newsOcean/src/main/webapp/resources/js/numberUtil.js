// 숫자인지 검사
function isValidNumber(data){
    // let p = /^[0-9]*$/g;
	// let p = /^[+-]?\d+(\.?\d*)$/;  // 부호, 소수점도 가능
    let p = /^(\d+)$/;
    return p.test(data);
}

// 숫자 3자리마다 컴마 삽입
// javascript 1.5 부터는 number=number.toLocaleString();  로 가능하지만 정수 범위를 벗어나면 이상한 결과 
function numberWithCommas(data) {
    let parts = data.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}

// 컴마 제거
function removeComma(data) {
	data = String(data);
    // return data.replace(/[^\d]+/g, '');
	return data.replace(/[,]/g, '');
}
