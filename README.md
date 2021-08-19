# HustleReactorKit
ReactorKit으로 RxSwift와 놀아보기

1.0.0 - world time api를 호출해서 현재 시간을 화면에 보여준다.

<img src = "https://user-images.githubusercontent.com/50232474/130097492-a78fa6e1-ae79-4c38-ae5f-c50e56db83ab.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130101074-aea6e167-63b6-407b-a5ac-8bef16a1ef72.png" width = "30%" height = "30%"> <img src = "https://user-images.githubusercontent.com/50232474/130097512-545c58a7-0605-4123-91c8-d47af08ad74a.png" width = "30%" height = "30%">

1. 현재 시간을 누르면 API를 호출해서 시간을 가져온 후 화면에 보여준다.
2. API 호출 후 결과 같이 오기 전까지는 loading... 이라는 메시지를 띄운다.
3. 현재 시간을 짧은 시간 여러번 누를 경우에 대비해 **debounce**를 사용한다.
