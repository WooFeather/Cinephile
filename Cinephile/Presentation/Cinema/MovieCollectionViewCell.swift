//
//  MovieCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/27/25.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: BaseCollectionViewCell {
    
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
        posterImageView.backgroundColor = .brown
        DispatchQueue.main.async {
            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.height / 24
        }
        
        titleLebel.text = "테스트"
        titleLebel.font = .boldSystemFont(ofSize: 16)
        
        // TODO: configureData에 들어갈 내용
        // let name = item.like ? "heart.fill" : "heart"
        // let btn = UIImage(systemName: name)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .cineAccent
        
        overviewLabel.text = "안녕하세요 선생님 안녕 친구야 인사하는 어린이 착한 어린이 안녕하세요 선생님 안녕 친구야 인사하는 어린이 착한 어린이"
        overviewLabel.font = .systemFont(ofSize: 12)
        overviewLabel.numberOfLines = 2
        overviewLabel.textColor = .cinePrimaryGray
    }
}
