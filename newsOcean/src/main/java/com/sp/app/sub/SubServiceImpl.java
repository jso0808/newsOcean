package com.sp.app.sub;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

@Service("sub.subService")
public class SubServiceImpl implements SubService {
	/*
	@Autowired
	private CommonDAO dao;
	*/
	
	private static final String HOST = "https://kapi.kakao.com";
	 
	private PayReady payReady;
	private ApproveResponse approveResponse;


	@Override
	public ReadyResponse payReady(int totalAmout) {
		
        // 카카오가 요구한 결제요청request값을 담아줍니다. 
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("partner_order_id", "1001"); // 구독권 
		params.add("partner_user_id", "testId@naver.com"); // 유저 아이디(이메일)
		params.add("item_name", "1개월 구독권"); // 1개월권
		params.add("quantity", "1");
		params.add("total_amount", String.valueOf("1000"));
		params.add("tax_free_amount", "0");
		params.add("approval_url", "http://localhost:9090/app/sub/pay_complete");
        params.add("cancel_url", "http://localhost:9090/app/sub/main");
        params.add("fail_url", "http://localhost:9090/app/sub/fail");
		
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(params, this.getHeaders());
		// 외부url요청 통로 열기.
		RestTemplate template = new RestTemplate();
		String url = "https://kapi.kakao.com/v1/payment/ready";
        // template으로 값을 보내고 받아온 ReadyResponse값 readyResponse에 저장.
		ReadyResponse readyResponse = template.postForObject(url, requestEntity, ReadyResponse.class);
        // 받아온 값 return
		return readyResponse;
	}
	
	@SuppressWarnings("deprecation")
	@Override
	public String kakaoPayReady() {
		 
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "김뿡빵");
        params.add("item_name", "1개월 구독권");
        params.add("quantity", "1");
        params.add("total_amount", "3000");
        params.add("tax_free_amount", "100");
        params.add("approval_url", "http://localhost:9090/app/sub/pay_complete");
        params.add("cancel_url", "http://localhost:9090/app/sub/kakaoPaySuccess");
        params.add("fail_url", "http://localhost:9090/app/sub/fail");
 
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
            payReady = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, PayReady.class);
            
            System.out.println("" + payReady);
            
            return payReady.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "/sub/pay_complete";
    }
	
	@SuppressWarnings("deprecation")
	@Override
	public ApproveResponse kakaoPayInfo(String pg_token) {
		 
		System.out.println("KakaoPayInfoVO............................................");
		System.out.println("-----------------------------");
        
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "admin key를 넣어주세요~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", payReady.getTid());
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "gorany");
        params.add("pg_token", pg_token);
        params.add("total_amount", "2100");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
        	approveResponse = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, ApproveResponse.class);
        	System.out.println("" + approveResponse);
          
            return approveResponse;
        
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return null;
    }

	@Override
	public ApproveResponse payApprove(String tid, String pgToken) {
		// TODO Auto-generated method stub
		return null;
	}

	// header() 셋팅
	private HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		// ADMIN 키
		headers.set("Authorization", "");
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		return headers;
	}
}
