//
//  ProfileSettingView.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit
import SnapKit

class ProfileSettingView: BaseView {
    
    private let doneButton = PointButton(title: "완료")
    private let textFieldUnderline = UIView()
    let statusLabel = UILabel()
    let imageSettingButton = UIButton()
    let nicknameTextField = UITextField()
    let cameraImageView = UIImageView()
    
    override func configureHierarchy() {
        [doneButton, textFieldUnderline, statusLabel, imageSettingButton, cameraImageView, nicknameTextField].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        imageSettingButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(36)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.top.equalTo(imageSettingButton.snp.bottom).offset(-30)
            make.trailing.equalTo(imageSettingButton.snp.trailing)
            make.size.equalTo(25)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageSettingButton.snp.bottom).offset(48)
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
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        // 추후 커스텀뷰로 빼놓기
        // 이미지 랜덤으로 설정하기
        imageSettingButton.setImage(.profile0, for: .normal)
        DispatchQueue.main.async {
            self.imageSettingButton.layer.cornerRadius = self.imageSettingButton.frame.width / 2
            self.imageSettingButton.imageView?.layer.cornerRadius = self.imageSettingButton.frame.width / 2
        }
        imageSettingButton.layer.borderColor = UIColor.cineAccent.cgColor
        imageSettingButton.layer.borderWidth = 3
        
        // 이미지뷰 안의 이미지의 inset을 정할 수 있음
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .cineAccent
        cameraImageView.tintColor = .cinaWhite
        DispatchQueue.main.async {
            self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.width / 2
        }
        
        nicknameTextField.borderStyle = .none
        nicknameTextField.textColor = .cineSecondaryGray
        nicknameTextField.tintColor = .cineSecondaryGray
        textFieldUnderline.backgroundColor = .cinePrimaryGray
        
        statusLabel.text = "이건 추후에 변경해야됩니다롱"
        statusLabel.textColor = .cineAccent
        statusLabel.font = .systemFont(ofSize: 14)
    }
}
