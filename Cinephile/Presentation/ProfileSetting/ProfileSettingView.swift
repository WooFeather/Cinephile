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
    private let mbtiLabel = UILabel()
    private let mbtiESTJStackView = UIStackView()
    private let mbtiINFPStackView = UIStackView()
    let doneButton = ActionButton(title: "완료")
    let statusLabel = UILabel()
    let profileImageView = ProfileImageView()
    let nicknameTextField = UITextField()
    
    let mbtiEButton = MBTIButton(title: "E")
    let mbtiIButton = MBTIButton(title: "I")
    
    let mbtiSButton = MBTIButton(title: "S")
    let mbtiNButton = MBTIButton(title: "N")
    
    let mbtiTButton = MBTIButton(title: "T")
    let mbtiFButton = MBTIButton(title: "F")
    
    let mbtiJButton = MBTIButton(title: "J")
    let mbtiPButton = MBTIButton(title: "P")
    
    override func configureHierarchy() {
        [doneButton, textFieldUnderline, statusLabel, profileImageView, cameraImageView, nicknameTextField, mbtiLabel, mbtiESTJStackView, mbtiINFPStackView].forEach {
            addSubview($0)
        }
        
        [mbtiEButton, mbtiSButton, mbtiTButton, mbtiJButton].forEach {
            mbtiESTJStackView.addArrangedSubview($0)
        }
        
        [mbtiIButton, mbtiNButton, mbtiFButton, mbtiPButton].forEach {
            mbtiINFPStackView.addArrangedSubview($0)
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
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        mbtiESTJStackView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(36)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        mbtiINFPStackView.snp.makeConstraints { make in
            make.top.equalTo(mbtiESTJStackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        [mbtiEButton, mbtiIButton, mbtiSButton, mbtiNButton, mbtiTButton, mbtiFButton, mbtiJButton, mbtiPButton].forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(50)
            }
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
        
        mbtiLabel.text = "MBTI"
        mbtiLabel.font = .boldSystemFont(ofSize: 16)
        
        mbtiESTJStackView.spacing = 10
        mbtiINFPStackView.spacing = 10
        
        // TODO: MBTI버튼의 isSelected상태를 UserDefaults에 저장해서 UserDefaultsManager.shared.isSigned일때 뷰에 선택된 상태 표시하기
        
        if !UserDefaultsManager.shared.isSigned {
            doneButton.isEnabled = false
        }
    }
}
