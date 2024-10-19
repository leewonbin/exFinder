# ExFinder 실행 모습 보기
실행 화면 캡쳐한 이미지들을 모아보았습니다.
    
## 기능 소개 - 회원가입
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>
회원가입  | 
:-----: |
![join](https://github.com/user-attachments/assets/6977bbd7-842d-49a3-a103-98e03bfba260) |
- 각 항목별로 유효성 검사를 하고 ID중복을 막기 위해 중복검사 버튼을 구현했습니다.

<br/><br/>

## 기능 소개 - 로그인
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>

<table>
  <tr align="center">
    <td colspan="2">로그인</td>
  </tr>
  <tr>
    <td colspan="2">
       <img src="https://github.com/user-attachments/assets/6b570dd9-a5b7-4ba6-bb7b-077ccfabc7e1" alt="login"></td>   
    </td>
   </tr>
  <tr align="center">
    <td>아이디 저장</td>
    <td>ID/PW 찾기</td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/73e32532-4e0c-4f9e-8599-73491dbe3cb5" alt="id_save"></td>
    <td><img src="https://github.com/user-attachments/assets/6fbcff3a-dff0-4cbe-adf4-f98c7125020f" alt="pw_find"></td>
  </tr>
</table>

- 홈페이지 내 오른쪽 상단 로그인 버튼을 눌러 로그인 화면에 진입할 수 있고 아이디 저장, 자동 로그인, ID/PW찾기 기능을 구현했습니다.


<br/><br/>

## 기능 소개 - 커뮤니티
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>
<table>
    <tr align="center">
        <td>게시글</td>
    </tr>
    <tr>
        <td><img src="https://github.com/user-attachments/assets/8f8e710c-d6f4-4101-b9ea-b1ba9bf3214d"></td>
    </tr>  
    <tr align="center">
        <td>댓글</td>
    </tr>
    <tr>
        <td><img src="https://github.com/user-attachments/assets/802597f7-ca16-4419-8b8b-7ae0d1e5baae"></td>
    </tr>
</table>

- <strong>게시글</strong> : 게시글 추가,수정,삭제 기능과 카테고리별 필터링, 검색 기능을 통해 원하는 게시글을 조회할 수 있도록 구현했습니다.
- <strong>댓글</strong> : 각 게시글마다 댓글을 달 수 있고 댓글에 대한 답글과 수정,삭제를 할 수 있도록 구현했습니다.

<br/><br/>

## 기능 소개 - 메인페이지
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>
메인페이지 | 
:-----:|
![mainPage](https://github.com/user-attachments/assets/1e2d049c-b7b4-42a5-91b0-c4610d494099) |
- 메인 페이지를 구상할 때, 환율 사이트에 방문하는 유저들은 물건을 구매하려는 것이 아니라 원하는 정보를 신속하게 얻고자 한다는 점에 중점을 두었습니다. 이를 반영해, 메인 페이지는 직관적이면서도 다양한 정보를 제공하도록 구성했습니다.

- <strong>환율 계산기</strong> : 시간별로 웹 크롤링을 통해 최신 환율 정보를 가져온 뒤 Ajax를 통해 계산기에 실시간 환율 정보를 적용시켰습니다.

- <strong>시간별 변동 추이 차트</strong> : 구글 차트를 활용해 하루 동안 변동되는 환율 정보를 직관적으로 볼 수 있게 하였습니다.

- <strong>전일비 지도</strong> : 사이트에서 지원하는 모든 통화의 전일 대비 변동을 한눈에 확인할 수 있도록 구현했습니다..

- <strong>실시간 환율 표</strong> : 사이트에서 지원하는 모든 통화의 정보를 표로 한눈에 확인 할 수 있도록 구현했습니다..
  
- <strong>가까운 환전은행,환전소 찾기</strong> : 현재 위치를 기반으로 주변 환전이 가능한 장소를 확인할 수 있도록 구현했습니다..
  
- <strong>고객센터</strong> : 자주 하는 질문과 1대1상담이 필요할 경우 카카오톡플러스친구를 통해 문의할 수 있도록 구현했습니다..
  


<br/><br/>


## 기능 소개 - 상세페이지
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>
상세페이지 | 
:-----:|
![detail](https://github.com/user-attachments/assets/efe7b22a-aa0e-4e8a-a50e-d8efb9072c1f) |
- <strong>통화 정보</strong> : 현재 통화에 대한 정보와 기간별 차트를 통해 변동 추이를 볼 수 있습니다.
- <strong>최신 뉴스</strong> : 해당 통화의 최신뉴스 정보를 확인 할 수 있습니다.
- <strong>일자,시간별 테이블</strong> : 일자별, 시간별 해당 통화의 정보를 확인 할 수 있습니다.
- <strong>즐겨찾기</strong> : 즐겨찾기 기능을 통해 관심있는 통화만 모아서 볼 수 있습니다.
- <strong>알림 설정</strong> : 알림을 받고 싶은 통화를 선택하면 해당 통화의 차트가 나타나고 금액을 입력해 알림을 설정 할 수 있습니다.

<br/><br/>

## 기능 소개 - 마이페이지
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>
<table>
    <tr align="center">
        <td>내정보 관리</td>
        <td>게시글 관리</td>
    </tr>
    <tr>
        <td><img src="https://github.com/user-attachments/assets/f68c62c4-f7e8-4678-bff3-9eadb4d2b459"/></td>
        <td><img src="https://github.com/user-attachments/assets/d56e49d5-cffa-4d1d-9d72-23846d45b6ad"/></td>
    </tr>
    <tr align="center">
        <td>알림 관리</td>
        <td>즐겨찾기 관리</td>
    </tr>
    <tr>
        <td><img src="https://github.com/user-attachments/assets/4a6eb163-f2c1-4798-9732-d725aa3590a4"/></td>
        <td><img src="https://github.com/user-attachments/assets/c6bbcd8a-1755-4c29-92e2-4a9df063347f"/></td>
    </tr>
</table>

- <strong>내 정보 관리</strong> : 현재 내 정보를 확인 할 수 있고 정보수정, 비밀번호 변경, 회원탈퇴를 할 수 있습니다.
- <strong>게시글 관리</strong> : 내가 작성한 게시글 목록을 볼 수 있고 체크박스를 통해 일괄 삭제가 가능합니다.
- <strong>알림 관리</strong> : 설정한 알림을 확인 할 수 있고 목표치 수정과 삭제를 할 수 있습니다.
- <strong>즐겨찾기 관리</strong> : 상세페이지에서 즐겨찾기에 등록한 통화를의 현재 값과 전일비를 확인 할 수 있고 클릭하면 해당 통화의 상세페이지로 이동합니다. 

<br/><br/>

## 기능 소개 - 관리자페이지
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>
<table>
    <tr align="center">
        <td>회원관리</td>
        <td>고객센터관리</td>
    </tr>
    <tr>
        <td><img src="https://github.com/user-attachments/assets/6fd6c701-e328-4ee9-b7ad-2f99caf5c2bc"/></td>
        <td><img src="https://github.com/user-attachments/assets/c2368b0e-60e6-489e-b729-aff37cd4a740"/></td>
    </tr>
    <tr align="center">
        <td>게시글관리</td>
        <td>환율정보업데이트</td>
    </tr>
    <tr>
        <td><img src="https://github.com/user-attachments/assets/a8b888a6-04b9-42d4-bf23-57493fbc2d3f"/></td>
        <td><img src="https://github.com/user-attachments/assets/8fc2902d-d2cf-4f83-86f3-0920391d79a6"/></td>
    </tr>
</table>

- <strong>회원 관리</strong> : 전체 회원의 정보를 조회할 수 있고 내용을 변경할 수 있으며 회원 계정의 활성화 여부를 결정 할 수 있습니다. 또한 회원의 권한을 관리자,일반회원으로 구분하여 설정 할 수 있습니다.
- <strong>고객센터 관리</strong> : 자주 하는 질문 조회하고 수정,삭제, 활성화 여부를 결정할 수 있습니다.
- <strong>게시글 관리</strong> : 전체 게시글을 조회 할 수 있고 활성화 여부와 삭제를 할 수 있습니다. 
- <strong>환율 정보 업데이트</strong> : 오늘 날짜를 기준으로 해당 웹 사이트에서 지원하는 모든 통화의 1년치 데이터를 웹크롤링을 통해 저장할 수 있습니다.

<br/><br/>

## 기능 소개 - 실시간 환율 알림
<a href="https://github.com/leewonbin/test?tab=readme-ov-file#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5">README로 돌아가기</a>
<table>
    <tr align="center">
        <td colspan="2">환율 설정</td>
    </tr>
    <tr>
        <td colspan="2"><img src="https://github.com/user-attachments/assets/c7df34c1-0802-482d-a73a-db61b0735ebc"></td>
    </tr>
    <tr align="center">
        <td>웹페이지 알림</td>
        <td>메시지 알림</td>
    </tr>
    <tr align="center">
        <td><img src="https://github.com/user-attachments/assets/08630588-8aab-4a22-867a-cce3a2fe179c"></td>
        <td><img src="https://github.com/user-attachments/assets/6d7bd03e-f4d1-418f-9419-1d8381330a6b"></td>
    </tr>
</table>
- 상세페이지를 통해 알림 설정을 하고 목표치에 도달하면 웹페이지 헤더에 있는 알림 점멸과 SMS로 사용자에게 알림이 줍니다.


<br/><br/>

<a href="https://github.com/leewonbin/test/blob/master/preview.md#exfinder-%EC%8B%A4%ED%96%89-%EB%AA%A8%EC%8A%B5-%EB%B3%B4%EA%B8%B0">맨위로</a>
