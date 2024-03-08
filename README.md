
<img src="https://github.com/Han-hih/secondRecapAssignment/assets/109748526/105ac916-1579-46a5-a877-07f01e755b24" width="75" height="75">

# ZZIM

<img width="1314" alt="image" src="https://github.com/Han-hih/secondRecapAssignment/assets/109748526/b044aaaa-f791-456c-893a-cadbaa9f79f7">

## 작업 환경
- 개발 기간: 2023년 09월 07일 ~ 2023년 09월 11일(5일)
- 개발 인원: 1인
- 최소 지원버전: iOS 13.0

## 앱 기능
- 네이버 쇼핑 검색
- 기준별 정렬
- 좋아요 목록 생성 및 제거
- 웹뷰에서 상세페이지 보기

## 구현 기능 
- 네이버 쇼핑 API를 활용한 상품 검색
- Realm을 이용한 좋아요 추가/제거 기능 구현
- Realm DB에 저장된 좋아요 목록 가져오기
- WebKit을 이용한 제품 상세 페이지 조회
- URLSession을 활용한 네트워크 통신 구현

## 사용 기술
- UIKit(CodeBase UI), URL Session, WebKit
- Realm
- MVC, Repository pattern

## 트러블 슈팅
### 1. 뷰의 생명주기 문제
- B화면에서 좋아요를 누르거나 취소하고 A화면으로 돌아오면 좋아요가 공유가 안되는 현상이 생김
- A화면에서 viewWillApear에 테이블뷰/컬렉션뷰 갱신
### 2. prepareForReuse를 이용한 셀 초기화
- 스크롤을 하면 새로운 데이터를 불러올 때마다 기존 셀에 데이터가 남아있는 현상이 생김
- 셀 재사용시 이미지와 좋아요 버튼에 관한 동작에 초기화를 해줘서 로딩에 관련된 문제를 해결 
```swift
 override func prepareForReuse() {
     super.prepareForReuse()
     shoppingImageView.image = nil
     heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
  }
```
