# Ably
### 개발 환경
- 프로그램 <img src="https://img.shields.io/badge/xcode-v13.4.1-white?logo=xcode&logoColor=skyblue"/>
- 언어 <img src="https://img.shields.io/badge/Swift-F05138?style=round-square&logo=swift&logoColor=white"/>
- 도구 <img src="https://img.shields.io/badge/SPM-F15148?style=round-square">
- 라이브러리
    - <img src="https://img.shields.io/badge/RxSwift-6.5.0-orange">
    - <img src="https://img.shields.io/badge/SnapKit-5.6.0-skyblue">
    - <img src="https://img.shields.io/badge/SDWebImage-5.9.5-green">
    - <img src="https://img.shields.io/badge/RealmSwift-master_branch-white">
        
        - SPM이슈로 인한 버전 설치 불가

### 구현 화면
|시작 화면|홈 화면|
|:---:|:---:|
|<img src="https://i.imgur.com/YPuKmBL.jpg" width="300">|<img src="https://i.imgur.com/BNcbCeQ.gif" width="300">|

|좋아요 화면|좋아요 취소|
|:---:|:---:|
|<img src="https://i.imgur.com/nKZ2w5r.gif" width="300">|<img src="https://i.imgur.com/LieeGrG.gif" width="300">|

### 구현 내용
- UICollectionViewCompositionalLayout
    - 배너, 상품리스트 두가지 section을 가진 CollectionView를 구현하기 위해 적용
- UICollectionViewDiffableDataSource
    - 데이터 변화에 따른 자연스러운 반영을 위해 적용
- RealmSwift
    - 데이터를 로컬에 저장하고 불러와서 사용하기 위해 적용
    - 좋아요 누른 상품을 저장하고 앱을 껐다 키더라도 좋아요 한 목록을 받을 수 있도록 하기 위해 사용
- MVVM+C
    - MVVM + CleanArchitecture를 적용하여 설계 및 파일 분리
    - 파일트리
        - ![](https://i.imgur.com/sUm5BTf.png)
