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
