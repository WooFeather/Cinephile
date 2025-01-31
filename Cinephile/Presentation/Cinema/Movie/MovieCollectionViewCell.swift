//
//  MovieCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "MovieCollectionViewCell"
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let likeButton = UIButton()
    let overviewLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(overviewLabel)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.equalTo(contentView)
            make.width.equalTo(180)
            make.height.equalTo(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalTo(contentView)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        posterImageView.backgroundColor = .cineBackgroundGray
        DispatchQueue.main.async {
            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.height / 24
        }
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        likeButton.tintColor = .cineAccent
        
        overviewLabel.font = .systemFont(ofSize: 12)
        overviewLabel.numberOfLines = 2
        overviewLabel.textColor = .cinePrimaryGray
    }
    
    func configureData(data: MovieDetail) {
        // TMDB 이미지를 불러올때는 앞에 추가 url이 필요함
        if let image = data.posterImage {
            let url = URL(string: "https://image.tmdb.org/t/p/original\(image)")
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "questionmark")
            posterImageView.tintColor = .cineAccent
        }
        
        titleLabel.text = data.title
        
        if data.overview == "" {
            overviewLabel.text = "줄거리 제공되지 않음"
        } else {
            overviewLabel.text = data.overview
        }
        
        // TODO: 좋아요 기능 UI 구현
        // 조건이 data의 like가 아니라, 해당 영화의 id가 좋아요리스트에 등록되어있는가가 기준이 될듯
        
        if LikeMovie.likeMovieIdList.contains(data.id) {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
