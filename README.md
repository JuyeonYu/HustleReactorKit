# HustleReactorKit
ReactorKit으로 RxSwift와 놀아보기

## 1.0.0 - world time api를 호출해서 현재 시간을 화면에 보여준다.

<img src = "https://user-images.githubusercontent.com/50232474/130097492-a78fa6e1-ae79-4c38-ae5f-c50e56db83ab.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130101074-aea6e167-63b6-407b-a5ac-8bef16a1ef72.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130097512-545c58a7-0605-4123-91c8-d47af08ad74a.png" width = "30%" height = "30%">

1. 현재 시간을 누르면 API를 호출해서 시간을 가져온 후 화면에 보여준다.
2. API 호출 후 결과 같이 오기 전까지는 loading... 이라는 메시지를 띄운다.
3. 현재 시간을 짧은 시간 여러번 누를 경우에 대비해 **debounce**를 사용한다.

## 1.0.1 - 시간 형식 보기 편하게 변경

<img src = "https://user-images.githubusercontent.com/50232474/130107357-8edd3bc1-9bff-4b4e-be1e-ad7a2ddba29c.png" width = "30%" height = "30%">

## 1.1.1 - 시간이 있을 때만 다음 버튼 활성화

<img src = "https://user-images.githubusercontent.com/50232474/130166847-c2ec9b1b-9ad6-4580-aafa-ff127ede3535.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130166854-ec070216-b759-4c9d-b19e-4237a3cbc3ca.png" width = "30%" height = "30%">

---

## 버전1 회고

1. ReactorKit
2. RxSwift
3. Moya

### 1. ReactorKit
처음에는 MVVM으로 RxSwift를 익혀보려고 했다. ReactorKit을 선택한 이유는 몇가지 있는데
  1. 명확한 템플릿이 없다.

    지금 프로젝트는 RxSwift를 익히기 위함이지 MVVM을 익히기 위함은 아니였다.
    그런점에서 자유도 높은 MVVM은 나를 헷깔리게 했다.
    예를들면 뷰에서 모델로 버튼 탭 이벤트를 전달할 때 rx로 바인딩을 해야하는 건지 
    그냥 원래 하던대로 addTarget 후 뷰모델에 있는 함수를 호출 하는건지...
    어떻게 하는게 맞는건지 혼란스러웠다.
    
  2. input, output 프로토콜보다 더 좋은게 있다.

    높은 자유도 때문에 어떻게 구현할지 모르고 있던 중
    뷰모델에 input과 output 프로토콜 만들어서 뷰모델을 구현하는 것을 보았다.
    이런 방식이라면 어느정도 명확한 템플릿이라고 생각이 들었고 MVVM으로 진행하면 되겠다고 판단했다.

    그러던중 ReactorKit을 알게되었는데...?
    Action과 State로 input output을 훌륭이 표현하고 있었고
    무엇보다도 enum으로 관리되어 좀 더 명확하다고 생각했다.
    
  3. 뷰 -> 리액터 단방향 흐름

    ReactorKit은 
    뷰 -> 리액터로 이벤트를 전달하고 
    리액터 -> 뷰로 값을 전달한다. 
    이런 단방향 흐름을 강제하는게 처음 학습하는 입장에서 자유도 높은 것보다 이게 편했다. 
    또 어떤 코드를 어디에 넣어야 할지 직관적으로 판단할 수 있겠다고 생각했다.
    
### 2. RxSwift
    RxSwift가 필요하다고 느낀 계기 중 하나는 debounce다.
    사내 테스트를 하면 버튼을 미친듯이 누르고 화면을 누르는건지 화면을 비비는건지 모를정도로 열심히 해주신다.
    그럴 때 뻗어버리는 내 작고 초라한 앱을 보면서 눈물을 흘리곤 했다.
    어떻게든 extension을 주워와서 debounce를 만들어내거나 로직을 만들기 쉽게 바꿔 달라고 조른 적도 있었다.
    그러다가 RxSwift에서 debounce를 한줄에 하는 걸보고 안할수가 없었다.
    결과는 대만족! 한줄에 이렇게 되는걸 보니 눈물이 난다. ㅠㅜ

    또한 시퀀스 데이터가 비동기로 전달이 되는것도 매력적이다.
    API를 호출하기 전에 loading을 보여주고 호출이 되면 값을 보여준다. 는 기능이
    너무 간결하게 구현할 수 있다.

### 3. Moya
    이것도 전부터 알고 있던 라이브러리인데 처음 써봤다.
    API를 호출하는 창구를 하나로 통합하는 역할을 하는데 사내에 적용하기엔 시간이 너무 오래 걸리고
    objc로 호출하는 API도 50% 이상이어서 포기했던 라이브러리다.
    Moya는 API를 호출 할때 필요한 정보를 enum으로 관래해준다.

    ReactorKit도 그렇고 Moya도 그렇고 enum을 정말 잘 쓴 라이브러리다...
    나는 왜 이렇게 못쓰고 있었을까 ㅠㅜ 갈길이 멀다.

---
시간을 보여주는 이번 버전1은 곰튀김님의 유튜브에서 참고했습니다.

https://www.youtube.com/watch?v=M58LqynqQHc

버전2에서는 테이블뷰를 만들어보겠습니다.
