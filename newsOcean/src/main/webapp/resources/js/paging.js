/*
 	dataCount : 전체 데이터 개수
 	pageSize : 한 페이지의 데이터 개수
 */
function pageCount(dataCount, pageSize) {
	let result = 0;
	
	try {
		dataCount = Number(dataCount);
		pageSize = Number(pageSize);
		
		if(dataCount <= 0) {
	        return 0;
	    }

		// result = Math.ceil(dataCount / pageSize);
		result = Math.floor(dataCount / pageSize) + (dataCount % pageSize > 0 ? 1 : 0);
	} catch (e) {
	}
	
	return result;
}

/*
	current_page : 화면에 표시할 페이지
	total_page : 전체 페이지 수
	url : 링크를 설정할 url
*/
function pagingUrl(current_page, total_page, url) {
	let result = "";
	
    let numPerBlock = 10;
    let currentPageSetup;
    let n, page;
    
    try {
    	current_page = Number(current_page);
    	total_page = Number(total_page);
		
        if(current_page < 1 || total_page < current_page) { return ""; }
        
        if(url.indexOf("?") !== -1) {
        	url += "&";
        } else {
        	url += "?";
        }
        
        currentPageSetup = Math.floor(current_page / numPerBlock) * numPerBlock;
        if(current_page%numPerBlock === 0) {
            currentPageSetup = currentPageSetup - numPerBlock;
        }
        
        result = "<div class='paginate'>";
        // 처음페이지, 이전(10페이지 전)
        n = current_page - numPerBlock;
        if(total_page > numPerBlock && currentPageSetup > 0) {
        	result += "<a href='" + url + "page=1'>처음</a>";
        	result += "<a href='" + url + "page=" + n + "'>이전</a>";
        }
        
        page = currentPageSetup + 1;
        while(page <= total_page && page <= (currentPageSetup + numPerBlock)) {
            if(page === current_page) {
            	result += "<span>" + page + "</span>";
            } else {
            	result += "<a href='" + url + "page=" + page + "'>" + page + "</a>";
            }
            page++;
        }
        
        // 다음(10페이지 후), 마지막페이지
        n = current_page + numPerBlock;
        if(n > total_page){ n = total_page; }
        if(total_page - currentPageSetup > numPerBlock) {
        	result += "<a href='" + url + "page=" + n + "'>다음</a>";
        	result += "<a href='" + url + "page=" + total_page + "'>끝</a>";
        }
        result += "</div>";

	} catch (e) {
	}
	
	return result;
}

/*
	current_page : 화면에 표시할 페이지
	total_page : 전체 페이지 수
	methodName : 호출할 메소드 명
*/
function pagingMethod(current_page, total_page, methodName) {
	let result = "";
	
    let numPerBlock = 10;
    let currentPageSetup;
    let n, page;
    
    try {
    	current_page = Number(current_page);
    	total_page = Number(total_page);

        if(current_page < 1 || total_page < 1) { return ""; }
        
        currentPageSetup = Math.floor(current_page / numPerBlock) * numPerBlock;
        if(current_page%numPerBlock === 0) {
            currentPageSetup = currentPageSetup-numPerBlock;
        }
        
        result += "<div class='paginate'>";
        // 처음페이지, 이전(10페이지 전)
        n = current_page - numPerBlock;
        if(total_page > numPerBlock && currentPageSetup > 0) {
        	result += "<a onclick='" + methodName + "(1);'>처음</a>";
        	result += "<a onclick='" + methodName + "(" + n + ");'>이전</a>";
        }
        
        page = currentPageSetup + 1;
        while(page <= total_page && page <= (currentPageSetup + numPerBlock)) {
            if(page === current_page) {
            	result += "<span>" + page + "</span>";
            } else {
            	result += "<a onclick='" + methodName + "(" + page + ");'>" + page + "</a>";
            }
            
            page++;
        }
        
        // 다음(10페이지 후), 마지막페이지
        n = current_page + numPerBlock;
        if(n > total_page){ n = total_page; }
        if(total_page - currentPageSetup > numPerBlock) {
        	result += "<a onclick='" + methodName + "(" + n + ");'>다음</a>";
        	result += "<a onclick='" + methodName + "(" + total_page + ");'>끝</a>";
        }
        result += "</div>";    	
    	
	} catch (e) {
	}
    
    return result;
}
