//
//  MovieDetailViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/29/25.
//

import UIKit

final class MovieDetailViewController: BaseViewController {
    
    private var movieDetailView = MovieDetailView()
    var titleContents: String?
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func configureEssential() {
        navigationItem.title = titleContents
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        // TODO: 좋아요 기능 구현
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeButtonTapped)), animated: true)
        movieDetailView.tableView.delegate = self
        movieDetailView.tableView.dataSource = self
        movieDetailView.tableView.register(BackdropTableViewCell.self, forCellReuseIdentifier: BackdropTableViewCell.id)
        movieDetailView.tableView.register(SynopsisTableViewCell.self, forCellReuseIdentifier: SynopsisTableViewCell.id)
        movieDetailView.tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.id)
        movieDetailView.tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
    }
    
    override func configureView() {
        movieDetailView.tableView.separatorStyle = .none
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        // TODO: 좋아요버튼 기능구현
        print(#function)
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            // BackdropTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BackdropTableViewCell.id, for: indexPath) as? BackdropTableViewCell else { return UITableViewCell() }
            
            cell.backdropCollectionView.tag = indexPath.row
            cell.backdropCollectionView.delegate = self
            cell.backdropCollectionView.dataSource = self
            cell.backdropCollectionView.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.id)
            
            return cell
        } else if indexPath.row == 1 {
            // SynopsisTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.id, for: indexPath) as? SynopsisTableViewCell else { return UITableViewCell() }
            
            return cell
        } else if indexPath.row == 2 {
            // CastTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            cell.castCollectionView.tag = indexPath.row
            cell.castCollectionView.delegate = self
            cell.castCollectionView.dataSource = self
            cell.castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
            
            return cell
        } else {
            // PosterTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
            
            cell.posterCollectionView.tag = indexPath.row
            cell.posterCollectionView.delegate = self
            cell.posterCollectionView.dataSource = self
            cell.posterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
            
            return cell
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // TODO: 각 collectionView의 데이터 배열 요소 개수만큼 분기처리
        if collectionView.tag == 0 {
            return 5
        } else if collectionView.tag == 2 {
            return 10
        } else if collectionView.tag == 3 {
            return 10
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as? BackdropCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else if collectionView.tag == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else if collectionView.tag == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else {
            // TODO: 각 CollectionView 분기처리
            return UICollectionViewCell()
        }
    }
}
