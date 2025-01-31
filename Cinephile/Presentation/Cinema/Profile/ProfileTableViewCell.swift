//
//  ProfileTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit
import SnapKit

final class ProfileTableViewCell: BaseTableViewCell {

    static let id = "ProfileTableViewCell"
    
    private let chevronImageView = UIImageView()
    let roundBackgroundView = UIView()
    let profileImageView = ProfileImageView()
    let dateLabel = UILabel()
    let nicknameLabel = UILabel()
    let movieBoxButton = MovieBoxButton()

    override func configureHierarchy() {
        contentView.addSubview(roundBackgroundView)
        [profileImageView, nicknameLabel, dateLabel, movieBoxButton, chevronImageView].forEach {
            roundBackgroundView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        roundBackgroundView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(12)
            make.bottom.equalTo(contentView)
            make.height.equalTo(140)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.size.equalTo(56)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.height.equalTo(16)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-12)
            make.size.equalTo(20)
        }
        
        movieBoxButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        roundBackgroundView.backgroundColor = .cineBackgroundGray
        DispatchQueue.main.async {
            self.roundBackgroundView.layer.cornerRadius = self.roundBackgroundView.frame.width / 20
        }
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
        
        nicknameLabel.font = .boldSystemFont(ofSize: 16)
        
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .cinePrimaryGray
        
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .cinePrimaryGray
    }
}
