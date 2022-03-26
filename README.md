
# MisoWeather
> 커뮤니티 기반의 날씨 앱 
> 일기예보 보다 친구의 한 마디를 더 믿는다면 

![](https://i.imgur.com/5WDGLBg.jpg)

<br/>

<img src="https://img.shields.io/badge/Platform-iOS-blue?style=flat&logo=ios&logoColor=white/"> <img src="https://img.shields.io/badge/Language-Swift-red?style=flat&logo=swift&logoColor=white/"> ![Swift](https://img.shields.io/badge/swift-v5.5.2-orange?logo=swift) ![Xcode](https://img.shields.io/badge/xcode-v13.1-blue?logo=xcode)


#### 기간 : 2022.01.03 - 2022.03.23  
#### 개발 인원 : iOS 1명, Android 1명, Backend 1명, Design 1명
#### 라이브러리 : Snapkit, Lottie
#### App Store : [MisoWeather](https://apps.apple.com/kr/app/misoweather/id1611374496)


<br/>

## 목표
- 프로젝트를 직접 기획하고 앱스토어에 배포까지 끝마친다.
- 외부 라이브러리를 사용하지 않는다. (UI 제외)
- 스토리보드를 사용하지 않고 코드만으로 프로젝트를 진행한다.
- 이슈를 정리하고 feature branch를 각 이슈별로 생성해 작업한다. 
- Swift Lint를 적용하여 코드 컨벤션을 지킨다.

<br/>

## Table of contents 🌳

>1. [**Member**](#member-)
>2. [**Preview**](#preview-)
>3. [**Feature**](#feature-)
>4. [**Architecture**](#architecture-)
>5. [**DevOps**](#devops-)
>6. [**Challenges**](#challenges-)


<br/>

## Member 👨🏻‍💻 

#### MisoBuild: 미소짓다

  |       iOS       |      Android   |    Backend    | UX/UI Design |
  | :-------------: | :-------------:| :-------------:| :-----------:|
  |     **허지인**    |     **허현성**  |     **강승연**   | **정한나**
  |    [@JIINHEO](https://github.com/JIINHEO)   |      [@gjgustjd](https://github.com/gjgustjd)     |     [@tmddusgood](https://github.com/tmddusgood)   | [@HannaChung](https://shadow-doll-9bb.notion.site/a0753965f865412eaef69d1c2aa0ccdc)|

<br/>

## Preview 📱
> 앱의 미리보기 화면입니다. 
    
<br/>

| <img width="250" height="360" alt="image" src="https://user-images.githubusercontent.com/39071796/160230737-c1ddf15b-9d36-49c9-b4f3-804b397c30f1.gif"> | <img width="250" height="360" src="https://user-images.githubusercontent.com/39071796/160230735-ce321627-66f6-439a-88d0-54d1be4be80c.gif"> | <img width="250" height="360" src="https://user-images.githubusercontent.com/39071796/160230733-5bd1497f-1a6c-43f1-8779-002cd5de2f49.gif"> | <img width="250" height="360" src="https://user-images.githubusercontent.com/39071796/160230945-4a7b9f94-cfc1-467b-b643-8dd3c7598543.gif"> |<img width="250" height="360" src="https://user-images.githubusercontent.com/39071796/160230738-ea21d77c-2ea6-4725-9d2b-8cdd18d86333.gif"> |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |:----------------------------------------------------------: |
|  `온보딩`   |  `둘러보기`  | `애플로그인`  | `닉네임선택`  | `날씨이야기` |

<br/>



## Feature ✨
> 화면별 기능 목록입니다. ✨

| <img width="331" height="470" alt="image" src="https://user-images.githubusercontent.com/39071796/160231244-a02f571b-f41e-4d3d-af51-05090980c32c.PNG"> | <img width="331" height="470" src="https://user-images.githubusercontent.com/39071796/160231242-89b2036c-158a-49fe-8128-32cd289939dc.PNG"> | <img width="331" height="470"  src="https://user-images.githubusercontent.com/39071796/160231239-ce556b3f-f956-41c5-92d5-96b4e3795100.PNG"> | <img width="331" height="470" src="https://user-images.githubusercontent.com/39071796/160231254-254c497b-9392-4c22-a3db-e70a505dc12b.png"> |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|                     `로그인`                     |                      `둘러보기`                      |                        `비로그인`                        |                        `랜덤 닉네임`                        |
| <img width="331" height="470" alt="image" src="https://user-images.githubusercontent.com/39071796/160231248-dcf2cec1-f383-4552-91b9-1e2a858eb43e.PNG"> | <img width="331" height="470" src="https://user-images.githubusercontent.com/39071796/160231247-2355e9d6-84ee-41c1-849d-05746121e48d.PNG"> | <img width="240" height="470" src="https://user-images.githubusercontent.com/39071796/160231234-b6d21309-101d-4b38-b453-b085458561fc.PNG"> | <img width="240" height="470" src="https://user-images.githubusercontent.com/39071796/160231245-c2771e84-9f46-46de-8538-ca4312fa83ec.PNG">| 
|                     `날씨 이야기`                     |                      `오늘의 사람들`                      |                        `날씨 한 줄 평`                        |                        `설정`                       |
#### 회원가입 및 로그인 
- Apple Login 
- 비회원을 위한 둘러보기 기능 적용
- 비회원 기능 제한 및 로그인 유도
- 대분류, 중분류, 소분류 지역 선택
- 랜덤 닉네임 및 이모지 선택 및 부여

#### 메인
- 현재 지역의 날씨, 한 줄 평, 설문을 간략히 제공
- 지역 변경

#### 날씨 예보
- 선택한 지역의 시간대별, 주간 일기예보 제공 
- 미세먼지, 강수, 풍속, 습도 제공


#### 날씨 이야기
- 오늘의 사람들 
    - 최초 1회 화면 진입 시 무작위 날씨에 대한 설문 및 답변 유도
    - 지역별 설문 답변에 대한 통계 애니메이션 그래프 제공
    - 질문 선택 및 답변
    - 답변 시 애니메이션 적용
- 한 줄 평
    - 한 줄 평 남기기
    - 다른 지역 사람들의 의견 공유를 위한 지역명과 닉네임 제공 
        - ex)**서울**의 흐뭇한 종이유니콘
    - 댓글 40자 제한 적용
    - 댓글 무한 스크롤 적용

<br/>

## Architecture 🏛
- MVVM
- Service Flow Diagram
<img width="1383" alt="image" src="https://user-images.githubusercontent.com/39071796/160237472-ff2dc929-17c2-445c-8cdb-2c157f66b97d.png">

<br/>


## DevOps 🐱
-  Github : 이슈를 작성하고, 이슈별 브랜치를 생성하여 진행 
- Swagger : REST API Documnet
- Figma : [UI Design, flow Diagram](https://www.figma.com/file/joQWrIUBet2AZjZOZIFupM/%EC%95%B1-%EB%94%94%EC%9E%90%EC%9D%B8?node-id=0%3A1)
- Discord : 매주 일요일 오후 2시 회의 진행
- Notion : 문서 정리 및 회의록 작성

    
<br/>

## Challenges 💪

### 후기

iOS 첫 프로젝트로 많이 부족했지만 이 프로젝트로 인해 정말 많이 성장했다고 느꼈습니다.    
디자이너와 협업하면서 H.I.G를 찾아보며 서로 의견을 나누기도 했고, 백엔드와 Swagger 문서로 API에 대해 같이 고민하기도 했습니다.   
Android 개발자와도 기획할때 시간내에 구현이 가능한 기능인지에 대한 고민과, 각 기능 비즈니스 로직에 대해 얘기를 나눈게 기억에 남습니다.   
소셜로그인을 구현해보면서 토큰에 대한 이해도를 높였으며, kakao API를 사용하면서 블로그보단 개발 문서를 읽는 습관이 생겼습니다.    
필요한 기능과 디자인이 기대한것과 동일하게 나와서 뿌듯한 마음도 있지만 개인적으로 첫 프로젝트라 아키텍처나 객체간의 결합 대해 많이 생각해보지 못했던것 같아 아쉽습니다. 앞으로 재사용 가능하고 유지보수가 용이한 코드에 대해 고민해보며 리팩토링을 할 계획입니다.
