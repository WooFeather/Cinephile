//
//  CinemaViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class CinemaViewController: BaseViewController {

    private var cinemaView = CinemaView()
    // TODO: 실제 검색 데이터로 교체 예정
    private var searchList = ["해리포터", "소방관", "현빈", "크리스마스", "기생충"]
    
    override func loadView() {
        view = cinemaView
    }
    
    override func configureEssential() {
        navigationItem.title = "CINEPHILE"
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped)), animated: true)
        cinemaView.tableView.delegate = self
        cinemaView.tableView.dataSource = self
        cinemaView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        cinemaView.tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.id)
        cinemaView.tableView.register(TodayMovieTableViewCell.self, forCellReuseIdentifier: TodayMovieTableViewCell.id)
    }
    
    override func configureView() {
        cinemaView.tableView.separatorStyle = .none
    }
    
    @objc
    private func searchButtonTapped() {
        print(#function)
        // TODO: SearchView로 push
    }
    
    @objc
    private func backgroundViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print(#function)
            // TODO: 프로필 닉네임 수정화면으로 sheet present
        }
    }
    
    @objc
    private func removeButtonTapped(sender: UIButton) {
        print(sender.tag)
        searchList.remove(at: sender.tag)
        print(searchList)
        cinemaView.tableView.reloadData()
    }
    
    @objc
    private func clearButtonTapped(sender: UIButton) {
        searchList.removeAll()
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
                print(image)
                cell.profileImageView.image = image
            }
            cell.nicknameLabel.text = UserDefaultsManager.shared.nickname
            cell.dateLabel.text = UserDefaultsManager.shared.joinDate
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.id, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            
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
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 최근검색어 cell을 탭했을 때 값전달과 함께 검색뷰로 이동
    }
}
