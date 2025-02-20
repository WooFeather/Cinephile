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

---

### TableView Cell안의 버튼과의 상호작용

- 문제
    - 다음 뷰는 TableView로 이루어져 있으며, 프로필을 보여주는 영역이 첫번째 cell
    - 해당 cell의 imageView나 button은 tapAction을 가지고 있는데, 인식을 하지 못함

    <img width="250" alt="Main" src="https://github.com/user-attachments/assets/254a0eb1-e9b3-4b23-9790-5b70332dbfc4">
    
- 해결 시도
    - 탭을 했다는 데이터를 전달하는 과정에서 문제가 있다고 판단해서 클로저, 델리게이트, tag를 사용해서 탭을 했다는 사실을 넘겨주려고 함
    - 클로저를 통해 시도
    
    ```swift
    //  ProfileTableViewCell.swift
    
    var buttonTapped: (() -> Void)?
    
    movieBoxButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
    
    @objc
    private func movieButtonTapped() {
        print(#function)
        buttonTapped?()
    }
    
    //  CinemaViewController.swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                
                cell.imageViewTapped = {
                    print("버튼 탭")
                }
                
                //...
    }
    ```
    
    ⇒ 실패
    
    - 델리게이트를 통해 시도
    
    ```swift
    //  ProfileTableViewCell.swift
    
    var delegate: ButtonTappedDelegate?
    
    movieBoxButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
    
    @objc
    private func movieButtonTapped() {
        print(#function)
        delegate?.movieBoxButtonTapped()
    }
    
    //  CinemaViewController.swift
    
    protocol ButtonTappedDelegate {
        func movieBoxButtonTapped()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
                cell.backgroundColor = .clear
                
                cell.delegate = self
                //...
    }
    
    extension CinemaViewController: ButtonTappedDelegate {
        func movieBoxButtonTapped() {
            print("버튼 탭")
        }
    }
    ```
    
    ⇒ 실패
    
    - tag를 사용
    
    ```swift
    //  CinemaViewController.swift
    
    @objc
    private func movieBoxButtonTapped(sender: UIButton) {
        print("이건될라나아ㅏ")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          if indexPath.row == 0 {
              guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
              cell.backgroundColor = .clear
              
              cell.movieBoxButton.tag = indexPath.row
              cell.movieBoxButton.addTarget(self, action: #selector(movieBoxButtonTapped), for: .touchUpInside)
    }
    ```
    
    ⇒ 실패
    
- 문제 발견
    - tapAction이나 데이터를 전달하는 것의 문제가 아니고, tableView Cell 안에서 addSubView를 해줄 때 contentView가 아닌 cell 자체에 addSubView를 해주고 있었음
    
    ```swift
    //  ProfileTableViewCell.swift
    
    override func configureHierarchy() {
    			// addUbView가 문제!!
          addSubview(roundBackgroundView)
    }
    
    movieBoxButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
    
    @objc
    private func movieButtonTapped() {
        print(#function)
    }
    ```
    
- 해결
    - contentView에 addSubView를 해주면서 해결
    
    ```swift
    //  ProfileTableViewCell.swift
    
    override func configureHierarchy() {
          contentView.addSubview(roundBackgroundView)
    }
    
    movieBoxButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
    
    @objc
    private func movieButtonTapped() {
        print(#function)
    }
    ```
    
    - tableView나 collectionViewCell의 view의 위계관계에 대해 알게 되었다.

    <img width="1512" alt="Main" src="https://github.com/user-attachments/assets/f8149f3c-2594-49f6-ba5b-b67d16292b9b">
    
- 학습한 것
    - tableView의 View의 위계 ⇒ CellContentView 안에 View가 있는 형태를 기억

---

### TableView Cell안의 버튼과의 상호작용

- 문제
    - 각 tableViewCell에 collectionView를 넣어주고, delegate에서 각 collectionView를 분기처리를 해준 이후, 셀을 움직이면 런타임 에러 발생

  <img width="1512" alt="Main" src="https://github.com/user-attachments/assets/b0b3c81c-d1fe-45fc-a38d-41fd45b004ca">
    
    - register를 잘 한것들도 확인했고, 분기처리는 다음과 같이 함
    
    ```swift
    extension CinemaViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            tableView.tag = indexPath.row
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                cell.roundBackgroundView.addGestureRecognizer(tapGesture)
                cell.roundBackgroundView.isUserInteractionEnabled = true
                
                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.id, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
                
                cell.searchWordsCollectionView.delegate = self
                cell.searchWordsCollectionView.dataSource = self
                cell.searchWordsCollectionView.register(RecentWordsCollectionViewCell.self, forCellWithReuseIdentifier: RecentWordsCollectionViewCell.id)
                cell.searchWordsCollectionView.showsHorizontalScrollIndicator = false
                cell.searchWordsCollectionView.reloadData()
    
                cell.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
                
                if searchList.isEmpty {
                    cell.emptyLabel.isHidden = false
                    cell.searchWordsCollectionView.isHidden = true
                    cell.clearButton.isHidden = true
                } else {
                    cell.emptyLabel.isHidden = true
                    cell.searchWordsCollectionView.isHidden = false
                    cell.clearButton.isHidden = false
                }
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayMovieTableViewCell.id, for: indexPath) as? TodayMovieTableViewCell else { return UITableViewCell() }
                
                cell.movieCollectionView.delegate = self
                cell.movieCollectionView.dataSource = self
                cell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
                cell.movieCollectionView.showsHorizontalScrollIndicator = false
                cell.movieCollectionView.reloadData()
                
                return cell
            }
        }
    }
    
    extension CinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if cinemaView.tableView.tag == 1 {
                return searchList.count
            } else {
                return 20
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if cinemaView.tableView.tag == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentWordsCollectionViewCell.id, for: indexPath) as? RecentWordsCollectionViewCell else { return UICollectionViewCell() }
                let item = searchList[indexPath.item]
                
                cell.configureData(item: item)
                
                cell.removeButton.tag = indexPath.item
                cell.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
        }
    }
    ```
    
- 해결 시도
    - 런타임 에러가 나는 경우: 두 번째 스크롤뷰를 움직이려고 할 때
    - 셀을 재사용할 일이 없는 경우에는 문제가 되지 않았음
    - BreakPoint를 통해 두 번째 셀을 움직였을 때, 세 번째 셀의 guard문에 잡히는 것을 확인

    <img width="1512" alt="Main" src="https://github.com/user-attachments/assets/42f932bf-db76-43e9-a32a-794aaa1dc17d">


    - 즉, indexPath.row가 1에 해당하는 셀을 움직였는데 indexPath.row가 2에 해당하는 셀에 잡힘
    - 각 셀을 탭했을 때 태그값을 확인해보니 전부 2가 찍힘
    
    ```swift
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.tag)
    }
    ```
    
- 문제 발견
    - 현재 tableView의 tag에 indexPath.row값을 넣어주는 식으로 한게 문제
    - 현재 분기처리로는 cell이 그려질때마다 맨 마지막에 그려진 시점의 indexPath.row가 tableView.tag에 할당이 됨으로 모든 cell의 tag가 같은 값을 가지게 된것임
- 해결
    - 각 collectionView의 tag에 tableView의 index값을 넣어주고, collectionView의 tag값에 따라 분기처리를 해줬어야 함
    
    ```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 이렇게 하는게 아니라
        // tableView.tag = indexPath.row
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
            cell.roundBackgroundView.addGestureRecognizer(tapGesture)
            cell.roundBackgroundView.isUserInteractionEnabled = true
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.id, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            
            // 이렇게 각 collectionView의 tag에 indexPath값을 넣어줌
            cell.searchWordsCollectionView.tag = indexPath.row
            cell.searchWordsCollectionView.delegate = self
            cell.searchWordsCollectionView.dataSource = self
            cell.searchWordsCollectionView.register(RecentWordsCollectionViewCell.self, forCellWithReuseIdentifier: RecentWordsCollectionViewCell.id)
            cell.searchWordsCollectionView.showsHorizontalScrollIndicator = false
            cell.searchWordsCollectionView.reloadData()
    
            cell.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            
            if searchList.isEmpty {
                cell.emptyLabel.isHidden = false
                cell.searchWordsCollectionView.isHidden = true
                cell.clearButton.isHidden = true
            } else {
                cell.emptyLabel.isHidden = true
                cell.searchWordsCollectionView.isHidden = false
                cell.clearButton.isHidden = false
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayMovieTableViewCell.id, for: indexPath) as? TodayMovieTableViewCell else { return UITableViewCell() }
            
            // 이렇게 각 collectionView의 tag에 indexPath값을 넣어줌
            cell.movieCollectionView.tag = indexPath.row
            cell.movieCollectionView.delegate = self
            cell.movieCollectionView.dataSource = self
            cell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
            cell.movieCollectionView.showsHorizontalScrollIndicator = false
            cell.movieCollectionView.reloadData()
            
            return cell
        }
    }
    ```
    
    ```swift
    extension CinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            // 이게 아니라
            // if cinemaView.tableView.tag == 1 { ... }
            
            // 이렇게 collectionView의 tag값으로 분기처리
            if collectionView.tag == 1 {
                return searchList.count
            } else {
                return 20
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            // 이게 아니라
            // if cinemaView.tableView.tag == 1 { ... }
            
            // 이렇게 collectionView의 tag값으로 분기처리
            if collectionView.tag == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentWordsCollectionViewCell.id, for: indexPath) as? RecentWordsCollectionViewCell else { return UICollectionViewCell() }
                let item = searchList[indexPath.item]
                
                cell.configureData(item: item)
                
                cell.removeButton.tag = indexPath.item
                cell.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
            
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
        }
    }
    ```
    
- 학습한 것
    - TableView 안에 CollectionView가 들어왔을 경우 분기처리 방법

---

### UserDefaults와 역 값전달

- 문제
    - 모달 시트가 올라온 상태에서 특정 값을 UserDefaults에 저장하고, 해당 시트를 닫았을 때의 View의 tableView에 저장된 값을 보여주고 싶었음
    - 처음에는 시트가 dismiss될 때 UserDefaults에 저장하고, 밑바탕뷰가 viewWillAppear될 때 reloadData를 하는 방식으로 했는데, 시트를 내리면 viewWillAppear가 호출이 안되는 생명주기상의 문제가 있었음
    
    ```swift
    // sheet
    
    @objc
    private func doneButtonTapped() {
        UserDefaultsManager.shared.nickname = profileSettingSheetView.nicknameTextField.text ?? ""
        UserDefaultsManager.shared.saveImage(UIImage: profileSettingSheetView.profileImageView.image ?? UIImage(), "profileImage")
        dismiss(animated: true)
    }
    ```
    
    ```swift
    // ViewController
    
    // sheet를 닫으면 viewWillAppear기 실행이 안돼서 업데이트가 바로 안됨
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cinemaView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    ```
    
- 해결 시도
    - 값 전달하는 방식을 NotificationCenter으로 변경해서 시도했으나
    - NotificationCenter 역시 옵저버를 add하는 시점이 있어야 하는데, 그 시점을 정하지 못하는 동일한 문제 존재
    
    ```swift
    // sheet
    
    private func reSaveValue() {
        guard let imageValue = profileSettingSheetView.profileImageView.image,
        let nicknameValue = profileSettingSheetView.nicknameTextField.text else { return }
        
        NotificationCenter.default.post(
            name: NSNotification.Name("ReSaveValue"),
            object: nil,
            userInfo: [
                "image": imageValue,
                "nickname": nicknameValue
            ]
        )
    }
    
    @objc
    private func doneButtonTapped() {
        reSaveValue()
        dismiss(animated: true)
    }
    ```
    
    ```swift
    // ViewController
    
    // 어차피 얘를 어디선가 호출해야할텐데
    private func receiveReSaveValue() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reSaveValueReceivedNotification),
            name: Notification.Name("ReSaveValue"),
            object: nil
        )
    }
    
    @objc
    private func reSaveValueReceivedNotification(value: NSNotification) {
        if let image = value.userInfo!["image"] as? UIImage,
           let nickname = value.userInfo!["nickname"] as? String{
            UserDefaultsManager.shared.setImage(UIImage: image, "profileImage")
            UserDefaultsManager.shared.nickname = nickname
            
            cinemaView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    ```
    
- 문제 발견
    - NotificationCenter나 단순히 UserDefaults에 값을 저장하는 방식으로 sheet를 dismiss하면 해당 저장된 값을 적용하는 순간을 지정하기가 까다로움
- 해결
    - 클로저를 통한 값전달을 활용함으로써, 애초에 sheet를 띄우면서 값을 받을 준비를 해서, 해당 시점에 값을 넘겨받는 방법을 선택
    - 동시에 원래는 UserDefaults에 저장된 데이터를 TableView의 cell에 바로 넣어줬었는데, 별도의 프로퍼티를 만들어서 한 번 더 거치게 만들어줌 ⇒ tableView 밖에서도 사용하기 위해
    
    ```swift
    //  CinemaViewController.swift
    
    import UIKit
    import Kingfisher
    
    final class CinemaViewController: BaseViewController {
    
        private var cinemaView = CinemaView()
        private var searchList: [String] = []
        private var movieList: [MovieDetail] = []
        // 아래와같이 클래스의 프로퍼티로 만들어줌
        private var imageContents: UIImage?
        private var nicknameContents: String?
        
        override func loadView() {
            view = cinemaView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            callRequest()
            receiveSearchText()
            searchList = UserDefaultsManager.shared.searchList
            // 이 함수!
            saveUserDefaultsValue()
        }
        
        //...
        
        // 여기서 UserDefaults의 값을 위의 프로퍼티에 담음
        private func saveUserDefaultsValue() {
            // UserDefaults에 저장된 이미지, 닉네임 데이터 담기
            if let imageData = UserDefaults.standard.data(forKey: "profileImage") {
                imageContents = UIImage(data: imageData)
            }
            nicknameContents = UserDefaultsManager.shared.nickname
        }
    ```
    
    ```swift
    @objc
    private func backgroundViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let vc = ProfileSettingSheetViewController()
            
            // 기존의 이미지, 닉네임을 sheet로 옮기기
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let image = UIImage(data: imageData) {
                vc.imageContents = image
            }
            vc.nicknameContents = UserDefaultsManager.shared.nickname
            
            let group = DispatchGroup()
            
            // 다시 저장한 닉네임 데이터 받기
            group.enter()
            vc.reSaveImage = { value in
                UserDefaultsManager.shared.saveImage(UIImage: value, "profileImage")
                self.imageContents = value
                group.leave()
            }
            
            // 다시 저장한 이미지 데이터 받기
            group.enter()
            vc.reSaveNickname = { value in
                UserDefaultsManager.shared.nickname = value
                self.nicknameContents = value
                group.leave()
            }
            
            // 한번에 UI업데이트를 위해 DispatchGroup 사용
            group.notify(queue: .main) {
                self.cinemaView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
            
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        }
    }
    ```
    
    ⇒ 모든 데이터를 받았을 때 바로 UI 업데이트를 해주기 위해 DispatchGroup를 이용해줌
    
    - sheet뷰에선 매개변수를 통해 새로 저장할 이미지와 닉네임을 VC로 넘겨줌
    
    ```swift
    import UIKit
    
    final class ProfileSettingSheetViewController: BaseViewController {
        
        private var profileSettingSheetView = ProfileSettingSheetView()
        var imageContents: UIImage?
        var nicknameContents: String?
        // 이 두개의 프로퍼티로 값 넘겨줌!
        var reSaveNickname: ((String) -> Void)?
        var reSaveImage: ((UIImage) -> Void)?
        
        //...
      
    @objc
    private func doneButtonTapped() {
        // 완료버튼을 눌렀을 때 값을 매개변수로 넘겨주면서 VC에서 정의한 클로저를 실행
        reSaveImage?(profileSettingSheetView.profileImageView.image ?? UIImage())
        reSaveNickname?(profileSettingSheetView.nicknameTextField.text ?? "")
        dismiss(animated: true)
    }
    ```
    
- 학습한 것
    - 각 상황에 맞는 역값전달 방법 사용

---

### TableViewCell의 재사용 문제

- 문제
    - 검색 화면에서 TableView를 사용하고 있는데, 장르 태그라는 UILabel의 데이터가 올바르지 않거나, cell 안의 버튼을 누를때마다 변하는 문제
    
    <img width="250" alt="Main" src="https://github.com/user-attachments/assets/05b82edd-3d66-4d7a-8fe7-d39e17eabd9c">

- 해결 시도
    - genreList.count 즉, 장르의 개수에 따라서 장르 Label을 표시하는 조건이 다른데, 이 조건문을 여러 형태로 변형 시도
    
    ```swift
    if data.genreList.count == 1 {
        firstGenreLabel.text = SearchTableViewCell.genre[data.genreList[0]]
        genreStackView.addArrangedSubview(firstGenreLabel)
    } else if data.genreList.count >= 2 {
        firstGenreLabel.text = SearchTableViewCell.genre[data.genreList[0]]
        secondGenreLabel.text = SearchTableViewCell.genre[data.genreList[1]]
        genreStackView.addArrangedSubview(firstGenreLabel)
        genreStackView.addArrangedSubview(secondGenreLabel)
    } else {
    		// ...
    }
    ```
    
- 문제 발견
    - 현재 로직은 조건문에 걸릴때마다 addArrangedSubview를 통해 데이터를 계속 추가해주고 있었음
- 해결
    - 조건문마다 이전에 추가된 것들을 remove해줘야 함
    
    ```swift
    if data.genreList.count == 1 {
    		// 이렇게
        firstGenreLabel.removeFromSuperview()
        secondGenreLabel.removeFromSuperview()
        
        firstGenreLabel.text = SearchTableViewCell.genre[data.genreList[0]]
        genreStackView.addArrangedSubview(firstGenreLabel)
    } else if data.genreList.count >= 2 {
    		// 이렇게
        firstGenreLabel.removeFromSuperview()
        secondGenreLabel.removeFromSuperview()
        
        firstGenreLabel.text = SearchTableViewCell.genre[data.genreList[0]]
        secondGenreLabel.text = SearchTableViewCell.genre[data.genreList[1]]
        genreStackView.addArrangedSubview(firstGenreLabel)
        genreStackView.addArrangedSubview(secondGenreLabel)
    } else {
    		// 이렇게
        firstGenreLabel.removeFromSuperview()
        secondGenreLabel.removeFromSuperview()
    }
    ```
    
- 학습한 것
    - `removeFromSuperview()` 키워드 학습


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
