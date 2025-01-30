//
//  CastCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class CastCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "CastCollectionViewCell"
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let characterNameLabel = UILabel()
    
    override func configureHierarchy() {
        [profileImageView, nameLabel, characterNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView)
            make.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView)
            make.height.equalTo(20)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView)
            make.height.equalTo(16)
        }
    }
    
    override func configureView() {
        profileImageView.backgroundColor = .cineBackgroundGray
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        
        characterNameLabel.font = .systemFont(ofSize: 14)
        characterNameLabel.textColor = .cinePrimaryGray
    }
    
    func configureData(data: CastDetail) {
        if let image = data.profileImage {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle")
            profileImageView.tintColor = .cineAccent
        }
        nameLabel.text = data.name
        characterNameLabel.text = data.character
    }
}
