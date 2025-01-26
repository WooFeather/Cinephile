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
    
    @objc
    private func movieButtonTapped() {
        print(#function)
    }
}

extension CinemaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
            cell.roundBackgroundView.addGestureRecognizer(tapGesture)
            cell.roundBackgroundView.isUserInteractionEnabled = true
            
            cell.movieBoxButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.id, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            // TODO: 검색어 리스트가 empty일 경우 collectionView랑 clear버튼 hidden처리
            
            return cell
        } else {
            guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: TodayMovieTableViewCell.id, for: indexPath) as? TodayMovieTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .green
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
