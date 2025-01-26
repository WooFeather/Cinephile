//
//  ProfileTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit
import SnapKit

//protocol profileTableViewDelegate {
//    func backgroundViewTapped()
//}

final class ProfileTableViewCell: BaseTableViewCell {

    static let id = "ProfileTableViewCell"
    
    private let dateLabel = UILabel()
    private let chevronImageView = UIImageView()
    let roundBackgroundView = UIView()
    let profileImageView = ProfileImageView()
    let nicknameLabel = UILabel()
    let movieBoxButton = MovieBoxButton(like: 0)

    override func configureHierarchy() {
        addSubview(roundBackgroundView)
        [profileImageView, nicknameLabel, dateLabel, movieBoxButton, chevronImageView].forEach {
            roundBackgroundView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        roundBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
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
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileTableViewCell.tapEdit))
//        roundBackgroundView.addGestureRecognizer(tapGesture)
//        roundBackgroundView.isUserInteractionEnabled = true
        
        profileImageView.image = ProfileImage.image1.image
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
        
        nicknameLabel.text = "추후에 수정 예정이지롱"
        nicknameLabel.font = .boldSystemFont(ofSize: 16)
        
        dateLabel.text = "88.88.88 가입"
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .cinePrimaryGray
        
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .cinePrimaryGray
    }
    
//    @objc
//    private func backgroundViewTapped(sender: UITapGestureRecognizer) {
//        if sender.state == .ended {
//            print(#function)
//        }
//    }
}
