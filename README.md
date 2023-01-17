##  뉴스 요약  및 챗봇 - <img src="https://user-images.githubusercontent.com/58289304/213015326-ed32c5b3-66eb-4b06-9390-f052e38c4adb.png" width="150" height="30"/>
<br>

### 📌 개발 기간
2022년 12월 14일 ~ 2023년 01월 27일 (약 5주)
<br>

### 📌 개발 인원
4명
<br>
<br>

### 📌 담당 기능: 로그인/회원가입, 구독 결제, 구독 메일 발송, 뉴스글, 카카오톡 챗봇, 네이트 뉴스 크롤링
##### ✔ 로그인/회원가입 주요 기능
- 로그인
    - 패스워드 5회 이상 틀리면 계정 비활성화
    - 패스워드 찾기: 임시 패스워드 발급 및 메일 전송
- 회원가입
   - 이메일, 닉네임 중복 검사
- 접근 권한
   -  관리자만 접근 가능한 페이지 진입 시 접근제한페이지 출력

##### ✔ 구독 결제 주요 기능
- 구독권 결제하기
   - 카카오페이API를 이용한 구독권 결제 
   - 구독권 선택 시 구독기간 자동 계산되어 출력
      - 첫 메일 발송일: 돌아오는 화요일
- 구독기간이 남은 구독권이 있다면 결제 불가
- 결제 구독권 리스트
   - 결제한 구독권 리스트 출력 및 페이징 처리
   - 구독권 종류로 검색 가능
   - 구독권 선택 시 해당 구독권의 상세 내역 확인
   - 첫 메일 발송일이 지난 구독권은 환불 불가

##### ✔ 구독 메일 발송 주요 기능
- 메일 작성
   - ck에디터 내부에 작성 가이드폼 출력
- 유료 구독자들에게 메일 발송
   - 발송일 기준으로 구독기간에 해당하는 구독자들에게만 뉴스 요약 메일 발송
- 메일 발신함
   - 조건별 검색 가능
- 발신 메일 상세보기
   - 메일 상세 내용과 수신한 구독자 수 출력

##### ✔ 뉴스글 주요 기능
- 크롤링한 뉴스 데이터 출력
- 뉴스글 공감 설정/해제
- 뉴스글 북마크 설정/해제
- 댓글 작성/삭제/신고/숨김
   - 신고 내역 3회 등록 시 댓글 숨김 처리
   - 댓글 좋아요
- SNS 공유
   - Twitter, KakaoTalk 공유 링크 생성

##### ✔ 챗봇 주요 기능
- 최신 뉴스
- 카테고리별 뉴스
- 키워드 뉴스 검색
- 관리자 1:1 채팅
<br>



### 📌 Development Environment
#### ✔ Framework
- Spring
- Spring Security
- mybatis 3
- maven
#### ✔ Programming Language
- JAVA 1.8
- Javascript
- jQuery, AJAX
- XML
- HTML5, CSS
- Servlet & JSP
- Python
#### ✔ DBMS
- Oracle DB 18
- MongoDB
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

### 📌 로그인/회원가입 주요 기능
#### ✔ 로그인
- 임시 패스워드 발급
![로그인](https://user-images.githubusercontent.com/58289304/213025064-8b3025da-547d-4685-b471-53ccabd7d832.png)
![이메일 입력](https://user-images.githubusercontent.com/58289304/213025066-35376655-ec9d-47e0-b744-114026523e4f.png)
![패스워드 발급](https://user-images.githubusercontent.com/58289304/213025060-3d8a1e9d-2bf6-466e-aa67-9219ca741eee.png)
![패스워드 메일](https://user-images.githubusercontent.com/58289304/213025053-4c56e788-ed47-47fe-b8ab-dac6ac2b646d.png)



### 📌 구독 주요 기능
#### ✔ 구독권 결제
- 카카오페이API를 이용한 구독권 결제 
- 구독권 선택 시 구독기간 계산되어 출력
   - 첫 메일 발송일: 돌아오는 화요일
- 구독기간이 남은 구독권이 있다면 결제 불가
![구독 메인](https://user-images.githubusercontent.com/58289304/213019693-91752326-1007-4157-89ed-f3c0d7531a1b.png)
<p align="center"><img src="https://user-images.githubusercontent.com/58289304/213020018-9514d06c-e00a-4a13-a09e-4f37ff167008.png" width="300" height="80"/></p>
<p align="center"><img src="https://user-images.githubusercontent.com/58289304/213020515-864c3f97-bd57-45af-a527-6023cfa6f4d5.png" width="300" height="400"/></p>
<p align="center"><img src="https://user-images.githubusercontent.com/58289304/213020560-7897e5c1-d567-4647-99a9-8051e6bda865.PNG" width="300" height="400"/></p>
<br>
#### ✔ 구독 내역 리스트
- 결제한 구독권 리스트 출력 및 페이징 처리
- 구독권 종류로 검색 가능
- 구독권 선택 시 해당 구독권의 상세 내역 확인
- 첫 메일 발송일이 지난 구독권은 환불 불가
![구독권 리스트](https://user-images.githubusercontent.com/58289304/213026678-bed4bed7-f835-4859-b990-d45f064589b2.png)
<p align="center"><img src="https://user-images.githubusercontent.com/58289304/213019686-0b309f76-e789-4255-bbfa-6d8df99b0860.png" width="400"/></p>
<p align="center"><img src="https://user-images.githubusercontent.com/58289304/213019692-93c12be6-6b59-485e-9f25-aa71f8d74439.png" width="400"/></p>
<br>






