#      🎥 CINEPHILE
#### 좋아하는 영화를 쉽게 찾고, 한곳에서 보관하세요.
<img width="250" alt="Onboarding" src="https://github.com/user-attachments/assets/154a1c4d-17d8-4679-9eda-a1ec0def4459">  <img width="250" alt="Main" src="https://github.com/user-attachments/assets/0dd7e292-1131-4040-b045-81d9c619bb34">  <img width="250" alt="Detail" src="https://github.com/user-attachments/assets/1f642c64-07a1-4fe6-b084-23350071d17d">


## 🎥 앱 소개
### Cinephile은 어떤 앱인가요?
영화를 쉽게 검색하고, 좋아하는 영화를 나만의 Movie Box에 보관할 수 있는 앱입니다.
더 나아가 오늘의 영화를 추천받고, 곧 개봉하는 영화를 미리 살펴보세요!


## ⭐️ 주요 기능
### 오늘의 영화
메인화면에서 오늘의 영화를 추천해드려요!
하루동안의 영화 조회수를 집계해 매일 새로운 영화를 소개합니다. 메인화면에서 영화의 포스터와 간단한 줄거리를 한눈에 확인할 수 있으며, 마음에 드는 경우 좋아요를 눌러서 무비박스에 보관할 수 있습니다.

<img width="250" alt="Main" src="https://github.com/user-attachments/assets/1739eebc-a28d-409e-85d4-f6213a660a7a">

### 영화 검색
영화 검색 기능을 통해 원하는 영화를 쉽게 찾아보세요!
검색 결과에서 영화의 포스터, 이름, 개봉일자를 비롯해 장르도 한눈에 확인할 수 있습니다. 마찬가지로 마음에 드는 영화에 좋아요를 누르거나 , 메인화면에서 최근검색어를 통해 다시 검색할수도 있습니다.

<img width="250" alt="Main" src="https://github.com/user-attachments/assets/4af3bc19-058f-4031-ad74-5cb72b543a4e">

### 영화 상세 보기
영화에 대한 더 자세한 정보도 제공해드려요!
영화 상세보기 화면에선 대표 사진, 평점을 비롯해 출연진과 포스터 등을 한눈에 확인할 수 있습니다. 더 자세한 줄거리를 확인할수도 있으며, 역시 좋아요를 누를수도 있습니다.

<img width="250" alt="Main" src="https://github.com/user-attachments/assets/2542d97b-20ec-4fb5-8826-108ed2ea6ea3">

### 무비박스
무비박스에서 좋아하는 영화를 한눈에 확인하세요!
-추후 기능 추가 예정입니다.-

### 개봉박두
곧 개봉하는 영화를 미리 만나보세요!
-추후 기능 추가 예정입니다.-
  
   
#      ⚙️ Project
## 🧑‍💻 개발 인원 및 기간
### 개발 인원
- 1인 개발
    - https://github.com/WooFeather

### 개발 기간
- 9일(1차 MVP 기준):
    - 25/01/24 ~ 25/02/01

## 💻 기술 스택
### 사용한 기술
- Framework
  - UIKit
- Library
  - Alamofire
  - Kinfisher
  - Snapkit


### 기술설명
- 화면
  - UIKit Framework를 기반으로, LaunchScreen을 제외한 모든 화면을 코드베이스로 구성했습니다.
  - SnpKit Library를 사용해 각 뷰객체들간의 Constraints를 설정했습니다.
  - BaseView, BaseCollectionViewCell 등의 커스텀뷰를 통해 중복되는 코드를 줄였습니다.
  - `UIPageControl`을 통해 PageControl 기능을 구현했습니다.
- 비동기 처리
  - GCD와 CompletionHandler를 통해 비동기 처리를 했습니다.
  - 여러 개의 API 요청이 있는 경우에 DispatchGroup을 이용해 뷰 업데이트 사용성을 개선했습니다.
  - 뷰 객체의 cornerRadius를 계산하는 로직을 `DispatchQueue.main.async{ }`를 통해 뷰를 그리는 시점을 조정하였습니다.
- 네트워크 통신
  - Alamofire Library를 통해 네트워크 통신 기능을 구현했습니다.
  - APIKey는 gitignore를 통해 Remote에 올라가지 않도록 처리했습니다.
  - RouterPattern을 도입해 여러 개의 API를 요청할 때 간편하게 처리했습니다.
  - `UITableViewDataSourcePrefetching`를 이용해 Pagination 처리를 함으로써, API 호출을 최적화했습니다.
  - NetworkManager의 경우 singleton 객체를 이용해서 다른곳에서의 인스턴스 생성을 방지했습니다.
  - 이미지는 Kingfisher Libarary를 이용해서 표현했습니다.
- 데이터 전달과 저장
   - `NotificatationCenter`의 post와 addOberver 기능을 통해 데이터 전달 기능을 구현했습니다.
   - Modal로 동작하는 뷰에서 데이터 전달을 위해 클로저를 통한 데이터 전달 기능을 구현했습니다.
   - UserDefaults를 통해 사용자의 닉네임, 가입 여부, 좋아요한 영화 등의 데이터를 영구저장했습니다.

## 😈 트러블 슈팅

### Push로 이동했을 때 View의 비정상적 동작

- 문제
    - 프로필 설정화면에서 선택된 이미지를 프로필 이미지 선택뷰로 넘기면서 push로 화면전환을 하는 과정에서 화면이 버벅거리는 문제가 발생
    
    ```swift
    // ProfileSettingViewController => 이미지를 전달하는 View
    @objc
    private func imageSettingButtonTapped() {
        let vc = ImageSettingViewController()
        vc.imageContents = profileSettingView.imageSettingButton.image(for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
    ```
    
    ```swift
    // ImageSettingViewController => 이미지를 받아서 이동되는 View
    import UIKit
    
    class ImageSettingViewController: BaseViewController {
        private var imageSettingView = ImageSettingView()
        var imageContents: UIImage?
        
        override func loadView() {
            view = imageSettingView
        }
        
        override func configureEssential() {
            navigationItem.title = "프로필 이미지 설정"
        }
        
        override func configureView() {
            imageSettingView.previewImage.setImage(imageContents, for: .normal)
        }
    }
    ```
    
- 해결 시도
    - 이미지를 전달하는 과정에서 문제가 있다고 판단해서 ViewController로 이미지 데이터를 전달하는게 아니라 BaseView를 상속받는 ImageSettingView로 바로 넘겨보기 시도
    
    ```swift
    @objc
    private func imageSettingButtonTapped() {
        let vc = ImageSettingViewController()
        vc.imageSettingView.imageContents = profileSettingView.imageSettingButton.image(for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
    ```
    
    ⇒ 실패
    
    - BaseView와 BaseViewController를 사용하는 과정에서 데이터 전달에 문제가 있다고 판단해서 이러한 커스텀뷰를 사용하지 않고 ViewController에서만 구성
    
    ⇒ 실패
    
- 문제 발견
    - ImageSettingViewController는 다음과 같은 BaseViewController라는 커스텀뷰를 상속받은 구조
    
    ```swift
    import UIKit
    
    class BaseViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configureView()
            configureEssential()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        func configureView() {
            view.backgroundColor = .cineBlack
        }
        
        func configureEssential() { }
    }
    ```
    
    - 여기서 view의 backgroundColor을 결정해주는 코드가 configureView()라는 메서드에 작성된 상태
    - 그러나, ImageSettingView에서 configureView라는 메서드를 재정의해서 사용할 때 다음과 같이 `super.configureView()`를 하지 않은 상태로 사용
    
    ```swift
    override func configureView() {
        imageSettingView.previewImage.image = imageContents
    }
    ```
    
    - 결론적으로 view의 backgroundColor가 세팅되지 않아서 view가 로드될 때 정상적으로 표시되지 않고 버벅거리는 현상이 발생
- 해결
    - 앞으로 BaseViewController를 상속받는 모든 뷰에서 `super.configureView()` 를 해주기엔 비효율적이라고 생각해서, 다음과 같이 BaseViewController의 `viewDidLoad()` 에 기본으로 적용해놓는 방식으로 해결
    
    ```swift
    class BaseViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .cineBlack
            
            configureView()
            configureEssential()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        func configureView() { }
        
        func configureEssential() { }
    }
    ```
    

### TableView Cell 안의 버튼과의 상호작용
- 문제
- 해결 시도
- 문제 발견
- 해결

### CollectionViewCell의 분기처리
- 문제
- 해결 시도
- 문제 발견
- 해결

### UserDefaults와 역 값전달
- 문제
- 해결 시도
- 문제 발견
- 해결

### TableViewCell의 재사용 문제
- 문제
- 해결 시도
- 문제 발견
- 해결


## 📓 프로젝트 회고

### 추가로 학습해야 할 내용
- TableView와 CollectionView의 셀의 재사용 원리
- 싱글톤패턴과 메모리 관리
- Alamofire의 URLRequestConvertible

### 리펙토링 및 추가 기능개발 계획
- MVVM 적용(적용완료)
- 좋아하는 영화 관리 수정
- NetworkManager에서 상태코드에 따른 분기처리
- 네트워킹 코드에 comopletionHandler를 Result타입으로 변경
- 네트워킹 예외처리 및 디코딩 전략 적용
