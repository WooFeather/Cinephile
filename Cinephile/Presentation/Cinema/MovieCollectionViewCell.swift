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
    let titleLebel = UILabel()
    let likeButton = UIButton()
    let overviewLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLebel)
        contentView.addSubview(likeButton)
        contentView.addSubview(overviewLabel)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(300)
        }
        
        titleLebel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.equalTo(contentView)
            make.height.equalTo(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLebel.snp.centerY)
            make.trailing.equalTo(contentView)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLebel.snp.bottom).offset(4)
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
        
        titleLebel.text = "테스트"
        titleLebel.font = .boldSystemFont(ofSize: 16)
        
        // TODO: configureData에 들어갈 내용
        
        likeButton.tintColor = .cineAccent
        
        overviewLabel.text = "안녕하세요 선생님 안녕 친구야 인사하는 어린이 착한 어린이 안녕하세요 선생님 안녕 친구야 인사하는 어린이 착한 어린이"
        overviewLabel.font = .systemFont(ofSize: 12)
        overviewLabel.numberOfLines = 2
        overviewLabel.textColor = .cinePrimaryGray
    }
    
    func configureData(item: MovieDetail) {
        // TMDB 이미지를 불러올때는 앞에 추가 url이 필요함
        let url = URL(string: "https://image.tmdb.org/t/p/original\(item.posterImage)")
        posterImageView.kf.setImage(with: url)
        
        titleLebel.text = item.title
        overviewLabel.text = item.overview
        
        // 조건이 item의 like가 아니라, 해당 영화의 id가 좋아요리스트에 등록되어있는가가 기준이 될듯
//        let name = item.like ? "heart.fill" : "heart"
//        let btn = UIImage(systemName: name)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
