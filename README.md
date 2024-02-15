# ZZIM

## 주요 기능
- 네이버 쇼핑 API를 활용한 상품 검색
- Realm을 이용한 좋아요 추가/제거 기능 구현
- Realm DB에 저장된 좋아요 목록 가져오기
- WebKit을 이용한 제품 상세 페이지 조회
- URLSession을 활용한 네트워크 통신 구현

## 구현 기능 

## 사용 기술
- UIKit(CodeBase UI), URL Session, WebKit
- Realm
- MVC, Repository pattern

  
## 작업 환경
- iOS 최소 버전: 13.0
- 개발 기간: 2023년 9월 7일 ~ 2023년 9월 11일(5일)
  
## 트러블 슈팅
### 1. 뷰의 생명주기 문제
- B화면에서 좋아요를 누르거나 취소하고 A화면으로 돌아오면 좋아요가 공유가 안되는 현상이 생김
- A화면에서 viewWillApear에 collectionViewReloadData 메서드를 사용해서 다시 서버와 통신을 해서 갱신

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

### 3. 
