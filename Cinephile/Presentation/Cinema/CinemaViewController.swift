//
//  CinemaViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class CinemaViewController: BaseViewController {

    private var cinemaView = CinemaView()
    private var searchList: [String] = []
    private var movieList: [MovieDetail] = []
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
        LikeMovie.likeMovieIdList = UserDefaultsManager.shared.likeMovieIdList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        saveUserDefaultsValue()
    }
    
    override func configureEssential() {
        navigationItem.title = "CINEPHILE"
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped)), animated: true)
        cinemaView.tableView.delegate = self
        cinemaView.tableView.dataSource = self
        cinemaView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        cinemaView.tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.id)
        cinemaView.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.id)
    }
    
    override func configureView() {
        cinemaView.tableView.separatorStyle = .none
    }
    
    private func callRequest() {
        NetworkManager.shared.callTMDBAPI(api: .trending, type: Movie.self) { value in
            self.movieList = value.results
            self.cinemaView.tableView.reloadData()
        } failHandler: {
            print("네트워킹 실패")
        }
    }
    
    private func receiveSearchText() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(searchTextReceivedNotification),
            name: NSNotification.Name("SearchTextReceived"),
            object: nil
        )
    }
    
    private func saveUserDefaultsValue() {
        // UserDefaults에 저장된 이미지, 닉네임 데이터 담기
        let imageData = UserDefaultsManager.shared.profileImage
        imageContents = UIImage(data: imageData)
        nicknameContents = UserDefaultsManager.shared.nickname
        
        self.cinemaView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    @objc
    private func searchTextReceivedNotification(value: NSNotification) {
        if let searchText = value.userInfo!["searchText"] as? String {
            searchList.insert(searchText, at: 0)
            UserDefaultsManager.shared.searchList = searchList
            cinemaView.tableView.reloadData()
        } else {
            return
        }
    }
    
    @objc
    private func searchButtonTapped() {
        let vc = SearchMovieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func backgroundViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let vc = ProfileSettingSheetViewController()
            
            // 기존의 이미지, 닉네임을 sheet로 전달
            let imageData = UserDefaultsManager.shared.profileImage

            if let image = UIImage(data: imageData) {
                vc.imageContents = image
            }
            vc.nicknameContents = UserDefaultsManager.shared.nickname
            
            let group = DispatchGroup()
            
            // sheet에서 다시 저장한 닉네임 데이터 받기
            group.enter()
            vc.reSaveImage = { value in
                if let imageData = value.pngData() {
                    UserDefaultsManager.shared.profileImage = imageData
                }
                self.imageContents = value
                group.leave()
            }
            
            // sheet에서 다시 저장한 이미지 데이터 받기
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
    
    @objc
    private func removeButtonTapped(sender: UIButton) {
        searchList.remove(at: sender.tag)
        UserDefaultsManager.shared.searchList = searchList
        cinemaView.tableView.reloadData()
    }
    
    @objc
    private func clearButtonTapped(sender: UIButton) {
        searchList.removeAll()
        UserDefaultsManager.shared.searchList = searchList
        cinemaView.tableView.reloadData()
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        // likeMovieIdList라는 배열에 선택한 영화의 id가 있으면 삭제하고, 없으면 등록하는 toggle형식의 동작
        // 동시에 LikeCount도 반영
        let item = movieList[sender.tag]
        if LikeMovie.likeMovieIdList.contains(item.id) {
            if let index = LikeMovie.likeMovieIdList.firstIndex(of: item.id) {
                LikeMovie.likeMovieIdList.remove(at: index)
                UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
                UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
            }
        } else {
            LikeMovie.likeMovieIdList.append(item.id)
            UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
            UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
        }
        
        print(LikeMovie.likeMovieIdList)
        print(LikeMovie.likeMovieIdList.count)
        
        cinemaView.tableView.reloadData()
    }
}

extension CinemaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
            cell.roundBackgroundView.addGestureRecognizer(tapGesture)
            cell.roundBackgroundView.isUserInteractionEnabled = true
            
            cell.profileImageView.image = imageContents
            cell.nicknameLabel.text = nicknameContents
            cell.dateLabel.text = UserDefaultsManager.shared.joinDate
            cell.movieBoxButton.setTitle("\(UserDefaultsManager.shared.likeMovieIdList.count)개의 무비박스 보관중", for: .normal)
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.id, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            
            cell.recentSearchCollectionView.tag = indexPath.row
            cell.recentSearchCollectionView.delegate = self
            cell.recentSearchCollectionView.dataSource = self
            cell.recentSearchCollectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.id)
            cell.recentSearchCollectionView.showsHorizontalScrollIndicator = false
            cell.recentSearchCollectionView.reloadData()

            cell.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            
            if searchList.isEmpty {
                cell.emptyLabel.isHidden = false
                cell.recentSearchCollectionView.isHidden = true
                cell.clearButton.isHidden = true
            } else {
                cell.emptyLabel.isHidden = true
                cell.recentSearchCollectionView.isHidden = false
                cell.clearButton.isHidden = false
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
            
            cell.movieCollectionView.tag = indexPath.row
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
        
        if collectionView.tag == 1 {
            return searchList.count
        } else {
            return movieList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.id, for: indexPath) as? RecentSearchCollectionViewCell else { return UICollectionViewCell() }
            let data = searchList[indexPath.item]
            
            cell.configureData(data: data)
            
            cell.removeButton.tag = indexPath.item
            cell.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let data = movieList[indexPath.item]
            
            cell.configureData(data: data)
            
            cell.likeButton.tag = indexPath.item
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let data = searchList[indexPath.item]
            
            let vc = SearchMovieViewController()
            vc.searchTextContents = data
            vc.callRequest(query: data)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let data = movieList[indexPath.item]
            
            let vc = MovieDetailViewController()
            vc.idContents = data.id
            vc.titleContents = data.title
            vc.synopsisContents = data.overview
            vc.releaseDateContents = data.releaseDate
            vc.ratingContents = data.rating
            
            if data.genreList.count == 1 {
                vc.firstGenreContents = SearchTableViewCell.genre[data.genreList[0]]
            } else if data.genreList.count >= 2 {
                vc.firstGenreContents = SearchTableViewCell.genre[data.genreList[0]]
                vc.secondGenreContents = SearchTableViewCell.genre[data.genreList[1]]
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
