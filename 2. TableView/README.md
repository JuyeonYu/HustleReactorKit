# ReactorKit으로 UITableView 구현

사용API: https://jsonplaceholder.typicode.com/

## 2.1.0

<img src = "https://user-images.githubusercontent.com/50232474/130636687-ef4d720c-68d6-40c1-8d7c-77cfca4a2ee9.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130636701-42563cf2-08d9-4fb6-a73a-838a9f3b6900.png" width = "30%" height = "30%">

1. 유저목록을 API를 호출해서 테이블뷰에 보여준다.
2. 게시물 목록을 API를 호출해서 테이블뷰에 보여준다.
3. 사용자 정보 API를 호출해서 게시물 목록에 보여준다.

- 게시물 목록 API를 호출하면 제목, 내용, **닉네임 아이디**를 받습니다.
- 테이블뷰의 셀이 그려질 때 사용자 정보 API를 호출해서 닉네임을 채워 넣습니다.
- 오버헤드를 줄이기 위해 닉네임 정보를 캐시합니다.

## 2.2.0

<img src = "https://user-images.githubusercontent.com/50232474/130998664-6733e64e-0a62-487a-b3e8-b247d32abae8.png" width = "30%" height = "30%">

1. 사용자 필터 기능 테이블뷰 헤더로 추가

<img src = "https://user-images.githubusercontent.com/50232474/130998698-4a0a66d5-aea9-4030-aa0f-5347923ffb78.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130998888-f92e99fe-fded-42c0-ae6e-d0fea475d305.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130998897-e0dd3207-a96f-436d-82b3-1822799bb53d.png" width = "30%" height = "30%">

2. 문자열 길이에 따라 유효성 체크
