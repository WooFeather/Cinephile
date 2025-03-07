//
//  ProfileSettingView.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit
import SnapKit

final class ProfileSettingView: BaseView {
    
    private let textFieldUnderline = UIView()
    private let cameraImageView = UIImageView()
    private let imageList = ProfileImage.allCases
    let doneButton = ActionButton(title: "완료")
    let statusLabel = UILabel()
    let profileImageView = ProfileImageView()
    let nicknameTextField = UITextField()
    
    override func configureHierarchy() {
        [doneButton, textFieldUnderline, statusLabel, profileImageView, cameraImageView, nicknameTextField].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(36)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(-30)
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.size.equalTo(25)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(48)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        textFieldUnderline.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(1)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldUnderline.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(16)
        }
        
        if !UserDefaultsManager.shared.isSigned {
            doneButton.snp.makeConstraints { make in
                make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
                make.horizontalEdges.equalToSuperview().inset(12)
                make.height.equalTo(44)
            }
        }
    }
    
    override func configureView() {
        profileImageView.image = imageList.randomElement()?.image
        
        // 이미지뷰 안의 이미지의 inset을 정할 수 있음
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .cineAccent
        cameraImageView.tintColor = .cinaWhite
        DispatchQueue.main.async {
            self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.width / 2
        }
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.cinePrimaryGray])
        nicknameTextField.borderStyle = .none
        nicknameTextField.textColor = .cineSecondaryGray
        nicknameTextField.tintColor = .cineSecondaryGray
        nicknameTextField.returnKeyType = .done
        textFieldUnderline.backgroundColor = .cinePrimaryGray
        
        statusLabel.textColor = .cineAccent
        statusLabel.font = .systemFont(ofSize: 14)
        
        if !UserDefaultsManager.shared.isSigned {
            doneButton.isEnabled = false
        }
    }
}
