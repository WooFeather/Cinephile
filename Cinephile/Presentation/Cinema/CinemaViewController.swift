//
//  CinemaViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit
import Kingfisher

final class CinemaViewController: BaseViewController {

    private var cinemaView = CinemaView()
    private var searchList: [String] = []
    private var movieList: [MovieDetail] = []
    
    override func loadView() {
        view = cinemaView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        receiveSearchText()
        searchList = UserDefaultsManager.shared.searchList
    }
    
    // TODO: reload시점 수정(시트가 내려갈때?)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cinemaView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
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
            
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let image = UIImage(data: imageData) {
                vc.imageContents = image
            }
            vc.nicknameContents = UserDefaultsManager.shared.nickname
            
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
        // TODO: 좋아요버튼 기능구현
        // movieList[sender.tag].like.toggle()
        // movieList의 sender의 tag의 id를 가져와서 해당 id를 좋아요리스트에 등록
        print(sender.tag)
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
            
            // UserDefaults에 저장된 프로필 이미지 적용
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let image = UIImage(data: imageData) {
                cell.profileImageView.image = image
            }
            cell.nicknameLabel.text = UserDefaultsManager.shared.nickname
            cell.dateLabel.text = UserDefaultsManager.shared.joinDate
            // TODO: movieBoxButton에 좋아요 개수 반영
            
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
