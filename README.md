##  뉴스 요약  및 챗봇 - <img src="https://user-images.githubusercontent.com/58289304/213015326-ed32c5b3-66eb-4b06-9390-f052e38c4adb.png" width="150" height="30"/>
<br>

### 📌 개발 기간
2022년 12월 14일 ~ 2023년 01월 27일 (약 5주)
<br>

### 📌 개발 인원
4명
<br>
<br>

### 📌 담당 기능: 전자 결재 기능, DB모델링, 메인화면 구현
##### ✔ 전자결재 주요 기능
- 전자결재 문서 발신, 수신함 조회
- 결재 문서 임시보관함 조회
- 결재 문서 유형별 폼 출력
- 결재 라인 지정 기능
- 결재 문서 등록, 수정
- 임시보관 문서 등록, 삭제
- 결재 문서 승인, 반려 기능
- 다중 파일 업로드 기능    
<br>


### 📌 Development Environment
#### ✔ Framework
- Spring
- Spring Security
- mybatis 3
- maven
#### ✔ Front-end 
- HTML5, CSS
- Javascript
- jQuery
- AJAX
#### ✔ Back-end
- Oracle DB 18
- MongoDB
- Servlet & JSP
- JAVA 1.8
- Python
#### ✔ Server
- Apache Tomcat 9.0
#### ✔ 버전 관리
- GitHub    
#### ✔ 기타
- ck 에디터
- Bootstrap 5.2
   
<br>
<br>

### 📌 요구사항 명세서
![요구사항1](https://user-images.githubusercontent.com/58289304/213016685-b47fcb5c-8563-4626-a5f7-17f969e322f2.PNG)
![요구사항2](https://user-images.githubusercontent.com/58289304/213016733-79fada27-22c6-4f63-8a97-92235e354081.PNG)

   
<br>
<br>
   

### 📌 ERD-Cloud
- https://www.erdcloud.com/d/MZQggYphu7hDx46Kj
![(최종) 2조_파이널](https://user-images.githubusercontent.com/58289304/213017055-28fc89ff-a2d3-472e-b753-0b0b805e3f1c.png)

<br>
<br>
    
### 📌 Class-Diagram
![클래스 다이어그램](https://user-images.githubusercontent.com/58289304/213017605-6bc1c162-7bc1-4ed1-8fac-0273f2ffc827.png)
<br>
<br>

### 📌 Sequence-Diagram
![시퀀스 다이어그램](https://user-images.githubusercontent.com/58289304/213017731-facb1442-50b5-4bd3-a139-70aa16eb8205.png)
<br>
<br>

### 📌 UseCase-Diagram
![유스케이스 다이어그램](https://user-images.githubusercontent.com/58289304/213017974-18f5c114-7dc7-4797-b682-1142005cd834.png)
<br>
<br>

### 📌 메인 페이지
![메인](https://user-images.githubusercontent.com/58289304/213015017-fad78c6c-3990-4b9e-a8b9-e6c1cff8b6c6.png)
<br>
<br>

### 📌 구독 주요 기능
#### ✔ 구독권 결제
- 카카오페이API를 이용한 구독권 결제 
- 구독권 선택 시 구독기간 계산되어 출력
   - 첫 메일 발송일: 돌아오는 화요일
- 구독기간이 남은 구독권이 있다면 결제 불가
![구독 메인](https://user-images.githubusercontent.com/58289304/213019693-91752326-1007-4157-89ed-f3c0d7531a1b.png)
![상세내역(환불버튼)](https://user-images.githubusercontent.com/58289304/213019686-0b309f76-e789-4255-bbfa-6d8df99b0860.png)
![상세내역](https://user-images.githubusercontent.com/58289304/213019692-93c12be6-6b59-485e-9f25-aa71f8d74439.png)
<img src="https://user-images.githubusercontent.com/58289304/213020018-9514d06c-e00a-4a13-a09e-4f37ff167008.png" width="300" height="80"/>
<img src="https://user-images.githubusercontent.com/58289304/213020515-864c3f97-bd57-45af-a527-6023cfa6f4d5.png" width="300" height="500"/>
<img src="https://user-images.githubusercontent.com/58289304/213020560-7897e5c1-d567-4647-99a9-8051e6bda865.PNG" width="300" height="500"/>
<br>

#### ✔ 구독 내역 리스트
- 결제한 구독권 리스트 출력 및 페이징 처리
- 구독권 종류로 검색 가능
- 구독권 선택 시 해당 구독권의 상세 내역 확인
- 첫 메일 발송일이 지난 구독권은 환불 불가
<br>






