//
//  ProfileSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class ProfileSettingViewController: BaseViewController {
    private var profileSettingView = ProfileSettingView()
    
    override func loadView() {
        view = profileSettingView
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 설정"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingView.profileImageView.addGestureRecognizer(tapGesture)
        profileSettingView.profileImageView.isUserInteractionEnabled = true
        profileSettingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        profileSettingView.nicknameTextField.addTarget(self, action: #selector(validateText), for: .editingChanged)
        profileSettingView.nicknameTextField.delegate = self
        receiveImage()
    }
    
    @objc
    private func profileImageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let vc = ImageSettingViewController()
            vc.imageContents = profileSettingView.profileImageView.image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    private func validateText() {
        guard let trimmingText = profileSettingView.nicknameTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        // 숫자가 포함되어있는지 확인하는법!
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = trimmingText.rangeOfCharacter(from: decimalCharacters)
        // 위의 코드에 영감을 받아 특수문자도 적용해봤습니당
        let spacialRange = trimmingText.rangeOfCharacter(from: ["@", "#", "$", "%"])
        
        if trimmingText.count < 2 || trimmingText.count > 10 {
            profileSettingView.statusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            profileSettingView.doneButton.isEnabled = false
        } else if spacialRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            profileSettingView.doneButton.isEnabled = false
        } else if decimalRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            profileSettingView.doneButton.isEnabled = false
        } else {
            profileSettingView.statusLabel.text = "사용할 수 있는 닉네임이에요"
            profileSettingView.doneButton.isEnabled = true
        }
    }
    
    @objc
    private func doneButtonTapped() {
        let vc = TabBarController()
        UserDefaultsManager.shared.nickname = profileSettingView.nicknameTextField.text ?? ""
        UserDefaultsManager.shared.joinDate = Date().toJoinString()
        if let imageData = profileSettingView.profileImageView.image?.pngData() {
            UserDefaultsManager.shared.profileImage = imageData
        }
        changeRootViewController(vc: vc, isSigned: true)
    }
    
    @objc
    private func imageReceivedNotification(value: NSNotification) {
        if let image = value.userInfo!["image"] as? UIImage {
            profileSettingView.profileImageView.image = image
        }
    }
    
    private func receiveImage() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(imageReceivedNotification),
            name: NSNotification.Name("ImageReceived"),
            object: nil
        )
    }
}

extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
