//
//  CinemaViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class CinemaViewController: BaseViewController {

    private var cinemaView = CinemaView()
    
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
    }
    
    @objc
    private func backgroundViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print(#function)
        }
    }
    
//    @objc
//    private func movieButtonTapped() {
//        print(#function)
//    }
    
    @objc
    private func removeButtonTapped() {
        print(#function)
    }
}

extension CinemaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
            cell.roundBackgroundView.addGestureRecognizer(tapGesture)
            cell.roundBackgroundView.isUserInteractionEnabled = true
            
            // cell.movieBoxButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.id, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            cell.searchWordsCollectionView.delegate = self
            cell.searchWordsCollectionView.dataSource = self
            cell.searchWordsCollectionView.register(RecentWordsCollectionViewCell.self, forCellWithReuseIdentifier: RecentWordsCollectionViewCell.id)
            cell.searchWordsCollectionView.showsHorizontalScrollIndicator = false
//            cell.searchWordsCollectionView.reloadData()
            
            // TODO: 검색어 리스트가 empty일 경우 collectionView랑 clear버튼 hidden처리
            // TODO: 검색어 리스트가 있을경우 emptyLabel hidden처리
            cell.emptyLabel.isHidden = true
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayMovieTableViewCell.id, for: indexPath) as? TodayMovieTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .green
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

extension CinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentWordsCollectionViewCell.id, for: indexPath) as? RecentWordsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.searchTextLabel.text = "테스트임"
        cell.backgroundColor = .cineSecondaryGray
        DispatchQueue.main.async {
            cell.layer.cornerRadius = cell.frame.height / 2
        }
        cell.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
        return cell
    }
}
