package com.sp.app.common;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public abstract class MyUtil {
	/**
	 * 전체 페이지수를 구하는 메소드
	 * 
	 * @param dataCount		총 데이터 개수
	 * @param size			한 화면에 출력할 데이터 개수
	 * @return				총 페이지 수
	 */
	public int pageCount(int dataCount, int size) {
		if(dataCount <= 0) {
			return 0;
		}
	
		return dataCount / size + (dataCount % size > 0 ? 1 : 0);
	}
	
	/**
	 * 페이징(paging) 처리를 하는 메소드(GET 방식, a 태그를 이용하여 해당 페이지의 URL로 이동)
	 * 
	 * @param current_page	화면에 출력할 페이지 번호
	 * @param total_page	총 페이지 수
	 * @param list_url		페이지 번호에 link를 설정할 URL
	 * @return				페이징 처리 결과
	 */
	public abstract String paging(int current_page, int total_page, String list_url);

	/**
	 * javascript를 이용하여 페이징 처리를하는 메소드 : javascript의 지정한 함수(methodName)를 호출
	 * 
	 * @param current_page	화면에 출력할 페이지 번호
	 * @param total_page	총 페이지 수
	 * @param methodName	호출할 자바스크립트 함수명
	 * @return				페이징 처리 결과
	 */
    public abstract String pagingMethod(int current_page, int total_page, String methodName);

	public abstract String pagingUrl(int current_page, int total_page, String list_url);
	public abstract String pagingFunc(int current_page, int total_page, String methodName);
    
    /**
     * 문자열에서 HTML 태그를 제거하는 메소드
     * 
     * @param str	HTML 태그를 제거할 문자열
     * @return		HTML 태그가 제거된 문자열
     */
    public String removeHtmlTag(String str) {
		if(str==null||str.length()==0) {
			return "";
		}

		String regex="<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
		String result=str.replaceAll(regex, "");
		return result;
    }

    /**
     * HTML 문서에서 img 태그의 src 속성값을 추출하는 메소드
     * 
     * @param html		html 문자열
     * @return			추출된 src 속성값을 가지고 있는 List 객체 
     */
    public List<String> getImgSrc(String html) {
		List<String> result = new ArrayList<String>();
		
		if(html==null||html.length()==0) {
			return result;
		}

		String regex="<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>";
		Pattern nonValidPattern = Pattern.compile(regex);

		Matcher matcher = nonValidPattern.matcher(html);
		while (matcher.find()) {
			result.add(matcher.group(1));
		}
		return result;
    }

    /**
     * 특수 문자를 HTML 문자로 변경 및 엔터를 <br>로 변경 하는 메소드
     * 
     * @param str	특수 문자를 HTML 문자로 변경할 문자열
     * @return		특수 문자가 HTML 문자로 변경된 문자열
     */
     public String htmlSymbols(String str) {
		if(str==null||str.length()==0) {
			return "";
		}

    	 str=str.replaceAll("&", "&amp;");
    	 str=str.replaceAll("\"", "&quot;");
    	 str=str.replaceAll(">", "&gt;");
    	 str=str.replaceAll("<", "&lt;");
    	 
    	 str=str.replaceAll(" ", "&nbsp;"); // \\s를 사용할 경우 \n 아래에서 사용해야 한다.
    	 str=str.replaceAll("\n", "<br>");
    	 
    	 return str;
     }

     /**
      * 정규식을 이용하여 E-Mail을 검사하는 메소드
      * 
      * @param email	검사할 E-Mail
      * @return			올바른 E-Mail 이지의 여부
      */
     public boolean isValidEmail(String email) {
         if (email==null) return false;
         boolean b = Pattern.matches(
        	 "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+", 
             email.trim());
         return b;
     }
}
