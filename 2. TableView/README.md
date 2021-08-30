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

## 2.3.0

<img src = "https://user-images.githubusercontent.com/50232474/131358782-567d541b-71da-4354-9e01-3594d80e9090.png" width = "30%" height = "30%">

1. RxDataSources를 이용한 멀티섹션, 헤더뷰
2. ReusableKit 사용해서 cell을 regist / deque
---

## 버전2 회고

### 1. UITableView +RxCocoa
RxCocoa가 모든 걸 지원하지는 않았다.

UITableViewDatasource에서 구현되는 기능 (섹션, 헤더 타이틀, 푸터 타이틀, 편집, 이동)을 

rx로 이용하려면 RxDataSources를 이용해야 했다.

하지만 RxDataSources를 사용한다고 해도 모든 dataSource를 지원하는 것도 아니다.

내가 자주쓰는 것 중 지원하지 않는 것은 viewForHeaderInSection였다.

### 2. RxDatasources
섹션을 구분하기 위한 보일러 플레이트 코드가 생각보다 많이 들어간다.

예제를 따라치며 어찌어찌 구현은 했는데 제대로 이해햐지는 못했다.

자주 보고 쓰며 익숙해지는 수밖에 없을 것 같다.

> 큰 골자는 나뉠 섹션을 정의하고 각 섹션에 어떤 데이터가 들어갈지 정의한다는 것이다.

### 3. ReusableKit (수열님 감사합니다...)
RxDataSources 예제를 보다가 우연히 발견한 라이브러리다.

cell을 regist하고 deque할 때 하드코딩된 문자열을 쓰거나 강제 옵셔널 언래핑을 하는 경우가 방지된다.

사용법도 간단하고 직관적이어서 당장 실무에서 적용하기 좋을 것 같다.

---

tips
- 테이블뷰 헤더뷰의 배경색을 바꿀 때 **contentView의 배경색**을 바꿔야 한다!
- reactor.action.onNext로 rx 바인딩 없이 이벤트를 전달할 수 있다.

---

다음 써볼 것
- ReactorKit transform, global state
