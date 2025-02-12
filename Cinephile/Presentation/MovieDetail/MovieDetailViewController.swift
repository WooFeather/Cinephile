//
//  MovieDetailViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/29/25.
//

import UIKit

final class MovieDetailViewController: BaseViewController {
    
    private var movieDetailView = MovieDetailView()
    let viewModel = MovieDetailViewModel()
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input.viewDidLoadTrigger.value = ()
    }
    
    override func bindData() {
        viewModel.output.viewDidLoadTrigger.lazyBind { _ in
            self.movieDetailView.tableView.reloadData()
        }
        
        viewModel.output.likeButtonTapped.lazyBind { [weak self] _ in
            guard let id = self?.viewModel.output.movieData.value?.id else { return }
            self?.setNavigationBarButton(id: id)
        }
    }
    
    override func configureEssential() {
        navigationItem.title = viewModel.output.movieData.value?.title
        navigationController?.navigationBar.barStyle = .black
        // navigationBar 반투명 효과 제거
        navigationController?.navigationBar.isTranslucent = false
        if let id = viewModel.output.movieData.value?.id {
            setNavigationBarButton(id: id)
        }
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
    
    private func setNavigationBarButton(id: Int) {
        let name = LikeMovie.likeMovieIdList.contains(id) ? "heart.fill" : "heart"
        let image = UIImage(systemName: name)
        navigationItem.setRightBarButton(UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped)), animated: true)
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        viewModel.input.likeButtonTapped.value = ()
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
            cell.backdropCollectionView.reloadData()
            
            cell.releaseDateButton.setTitle(viewModel.output.movieData.value?.releaseDate, for: .normal)
            cell.ratingButton.setTitle(String(format: "%.1f", viewModel.output.movieData.value?.rating ?? 0.0), for: .normal)
            if let firstGenre = self.viewModel.output.firstGenre {
                if let secondGenre = self.viewModel.output.secondGenre {
                    cell.genreButton.setTitle("\(firstGenre), \(secondGenre)", for: .normal)
                } else {
                    cell.genreButton.setTitle("\(firstGenre)", for: .normal)
                }
            } else {
                cell.genreButton.setTitle("장르없음", for: .normal)
            }
            
            BackdropTableViewCell.pageControl.currentPage = 0
            BackdropTableViewCell.pageControl.numberOfPages =  viewModel.output.backdropList.value.count
            
            return cell
        } else if indexPath.row == 1 {
            // SynopsisTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.id, for: indexPath) as? SynopsisTableViewCell else { return UITableViewCell() }
            
            if self.viewModel.output.movieData.value?.overview == "" {
                cell.synopsisLabel.text = "줄거리 제공되지 않음"
            } else {
                cell.synopsisLabel.text = self.viewModel.output.movieData.value?.overview
            }
            
            return cell
        } else if indexPath.row == 2 {
            // CastTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            cell.castCollectionView.tag = indexPath.row
            cell.castCollectionView.delegate = self
            cell.castCollectionView.dataSource = self
            cell.castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
            cell.castCollectionView.reloadData()
            
            return cell
        } else {
            // PosterTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
            
            cell.posterCollectionView.tag = indexPath.row
            cell.posterCollectionView.delegate = self
            cell.posterCollectionView.dataSource = self
            cell.posterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
            cell.posterCollectionView.reloadData()
            
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 0 {
            let width = scrollView.frame.width
            let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
            BackdropTableViewCell.pageControl.currentPage = currentPage
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return viewModel.output.backdropList.value.count
        } else if collectionView.tag == 2 {
            return viewModel.output.castList.value.count
        } else if collectionView.tag == 3 {
            return viewModel.output.posterList.value.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as? BackdropCollectionViewCell else { return UICollectionViewCell() }
            
            let data = viewModel.output.backdropList.value[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else if collectionView.tag == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            
            let data = viewModel.output.castList.value[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else if collectionView.tag == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            
            let data = viewModel.output.posterList.value[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
