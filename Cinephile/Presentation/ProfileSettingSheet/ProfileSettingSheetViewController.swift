//
//  ProfileSettingSheetViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/31/25.
//

import UIKit

final class ProfileSettingSheetViewController: BaseViewController {
    
    private var profileSettingSheetView = ProfileSettingSheetView()
    
    override func loadView() {
        view = profileSettingSheetView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 설정"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingSheetView.profileImageView.addGestureRecognizer(tapGesture)
        profileSettingSheetView.profileImageView.isUserInteractionEnabled = true
        profileSettingSheetView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        profileSettingSheetView.nicknameTextField.addTarget(self, action: #selector(validateText), for: .editingChanged)
        receiveImage()
    }
    
    @objc
    private func profileImageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let vc = ImageSettingSheetViewController()
            vc.imageContents = profileSettingSheetView.profileImageView.image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    private func validateText() {
        print(#function)
        guard let trimmingText = profileSettingSheetView.nicknameTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        // 숫자가 포함되어있는지 확인하는법!
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = trimmingText.rangeOfCharacter(from: decimalCharacters)
        // 위의 코드에 영감을 받아 특수문자도 적용해봤습니당
        let spacialRange = trimmingText.rangeOfCharacter(from: ["@", "#", "$", "%"])
        
        if trimmingText.count < 2 || trimmingText.count > 10 {
            profileSettingSheetView.statusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            profileSettingSheetView.doneButton.isEnabled = false
        } else if spacialRange != nil {
            profileSettingSheetView.statusLabel.text = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            profileSettingSheetView.doneButton.isEnabled = false
        } else if decimalRange != nil {
            profileSettingSheetView.statusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            profileSettingSheetView.doneButton.isEnabled = false
        } else {
            profileSettingSheetView.statusLabel.text = "사용할 수 있는 닉네임이에요"
            profileSettingSheetView.doneButton.isEnabled = true
        }
    }
    
    @objc
    private func doneButtonTapped() {
        let vc = TabBarController()
        UserDefaultsManager.shared.nickname = profileSettingSheetView.nicknameTextField.text ?? ""
        UserDefaultsManager.shared.joinDate = Date().toJoinString()
        setImage(UIImage: profileSettingSheetView.profileImageView.image ?? UIImage(), "profileImage")
        changeRootViewController(vc: vc, isSigned: true)
    }
    
    @objc
    private func imageReceivedNotification(value: NSNotification) {
        if let image = value.userInfo!["image"] as? UIImage {
            profileSettingSheetView.profileImageView.image = image
        }
    }
    
    // 이미지를 UserDefaults에 저장하기
    private func setImage(UIImage value: UIImage, _ key: String) {
        let imageData = value.pngData()
        UserDefaults.standard.set(imageData, forKey: key)
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
