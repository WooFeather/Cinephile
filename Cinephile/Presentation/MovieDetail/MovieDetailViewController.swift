//
//  MovieDetailViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/29/25.
//

import UIKit

final class MovieDetailViewController: BaseViewController {
    
    private var movieDetailView = MovieDetailView()
    private var backdropList: [Backdrop] = []
    private var posterList: [Poster] = []
    private var castList: [CastDetail] = []
    var idContents: Int?
    var titleContents: String?
    var synopsisContents: String?
    var releaseDateContents: String?
    var firstGenreContents: String?
    var secondGenreContents: String?
    var ratingContents: Double?
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
    }
    
    override func configureEssential() {
        navigationItem.title = titleContents
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        if let idContents {
            setNavigationBarButton(id: idContents)
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
    
    private func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.callTMDBAPI(api: .images(id: idContents ?? 0), type: Images.self) { value in
            if value.backdrops.count >= 5 {
                for item in 0..<5 {
                    self.backdropList.append(value.backdrops[item])
                }
            } else {
                self.backdropList = value.backdrops
            }
            self.posterList = value.posters
            group.leave()
        } failHandler: {
            print("네트워킹 실패")
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.callTMDBAPI(api: .credit(id: idContents ?? 0), type: Credit.self) { value in
            self.castList = value.cast
            group.leave()
        } failHandler: {
            print("네트워킹 실패")
            group.leave()
        }

        
        group.notify(queue: .main) {
            self.movieDetailView.tableView.reloadData()
        }
    }
    
    private func setNavigationBarButton(id: Int) {
        let name = LikeMovie.likeMovieIdList.contains(id) ? "heart.fill" : "heart"
        let image = UIImage(systemName: name)
        navigationItem.setRightBarButton(UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped)), animated: true)
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        // TODO: 좋아요버튼 기능구현
        guard let idContents else { return }
        if LikeMovie.likeMovieIdList.contains(idContents) {
            if let index = LikeMovie.likeMovieIdList.firstIndex(of: idContents) {
                LikeMovie.likeMovieIdList.remove(at: index)
                UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
                UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
            }
        } else {
            LikeMovie.likeMovieIdList.append(idContents)
            UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
            UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
        }
        
        print(LikeMovie.likeMovieIdList)
        print(LikeMovie.likeMovieIdList.count)
        
        // tableView.reloadData() 하듯이 navigationBarButton도 refrash하고 싶은데 딱히 방법이 없어서 다시 세팅하는 방식을 택함
        setNavigationBarButton(id: idContents)
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
            
            cell.releaseDateButton.setTitle(releaseDateContents, for: .normal)
            cell.ratingButton.setTitle(String(format: "%.1f", ratingContents ?? 0.0), for: .normal)
            if let firstGenreContents {
                if let secondGenreContents {
                    cell.genreButton.setTitle("\(firstGenreContents), \(secondGenreContents)", for: .normal)
                } else {
                    cell.genreButton.setTitle("\(firstGenreContents)", for: .normal)
                }
            } else {
                cell.genreButton.setTitle("장르없음", for: .normal)
            }
            
            return cell
        } else if indexPath.row == 1 {
            // SynopsisTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.id, for: indexPath) as? SynopsisTableViewCell else { return UITableViewCell() }
            
            if synopsisContents == "" {
                cell.synopsisLabel.text = "줄거리 제공되지 않음"
            } else {
                cell.synopsisLabel.text = synopsisContents
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
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return backdropList.count
        } else if collectionView.tag == 2 {
            return castList.count
        } else if collectionView.tag == 3 {
            return posterList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as? BackdropCollectionViewCell else { return UICollectionViewCell() }
            
            let data = backdropList[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else if collectionView.tag == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            
            let data = castList[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else if collectionView.tag == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            
            let data = posterList[indexPath.item]
            cell.configureData(data: data)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
