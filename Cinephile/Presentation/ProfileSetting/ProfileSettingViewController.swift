//
//  ProfileSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class ProfileSettingViewController: BaseViewController {
    
    private var profileSettingView = ProfileSettingView()
    private var isNicknameValidate = false
    private var isButtonValidate = false
    private lazy var mbtiEIButtonArray: [UIButton] = [profileSettingView.mbtiEButton, profileSettingView.mbtiIButton]
    private lazy var mbtiSNButtonArray: [UIButton] = [profileSettingView.mbtiSButton, profileSettingView.mbtiNButton]
    private lazy var mbtiTFButtonArray: [UIButton] = [profileSettingView.mbtiTButton, profileSettingView.mbtiFButton]
    private lazy var mbtiJPButtonArray: [UIButton] = [profileSettingView.mbtiJButton, profileSettingView.mbtiPButton]
    var imageContents: UIImage?
    var nicknameContents: String?
    var reSaveNickname: ((String) -> Void)?
    var reSaveImage: ((UIImage) -> Void)?
    
    override func loadView() {
        view = profileSettingView
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 설정"
        if UserDefaultsManager.shared.isSigned {
            sheetPresentationController?.prefersGrabberVisible = true
            navigationItem.setRightBarButton(UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(doneButtonTapped)), animated: true)
            navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonTapped)), animated: true)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingView.profileImageView.addGestureRecognizer(tapGesture)
        profileSettingView.profileImageView.isUserInteractionEnabled = true
        profileSettingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        profileSettingView.nicknameTextField.addTarget(self, action: #selector(validateText), for: .editingChanged)
        profileSettingView.nicknameTextField.delegate = self
        receiveImage()
        
        profileSettingView.mbtiEButton.addTarget(self, action: #selector(mbtiEIButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiIButton.addTarget(self, action: #selector(mbtiEIButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiSButton.addTarget(self, action: #selector(mbtiSNButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiNButton.addTarget(self, action: #selector(mbtiSNButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiTButton.addTarget(self, action: #selector(mbtiTFButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiFButton.addTarget(self, action: #selector(mbtiTFButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiJButton.addTarget(self, action: #selector(mbtiJPButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiPButton.addTarget(self, action: #selector(mbtiJPButtonTapped), for: .touchUpInside)
    }
    
    override func configureView() {
        if UserDefaultsManager.shared.isSigned {
            profileSettingView.profileImageView.image = imageContents
            profileSettingView.nicknameTextField.text = nicknameContents
        }
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
        
        // 숫자가 포함되어있는지 확인하는법
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = trimmingText.rangeOfCharacter(from: decimalCharacters)
        // 위의 코드를 참고해 특수문자도 적용
        let spacialRange = trimmingText.rangeOfCharacter(from: ["@", "#", "$", "%"])
        
        // TODO: statusLabel TextColor도 조건처리
        // TODO: 모든 MBTI버튼을 선택하지 않았을 때도 조건처리
        if trimmingText.count < 2 || trimmingText.count > 10 {
            profileSettingView.statusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            profileSettingView.statusLabel.textColor = .cineConditionRed
            isNicknameValidate = false
            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
            }
        } else if spacialRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            profileSettingView.statusLabel.textColor = .cineConditionRed
            isNicknameValidate = false
            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
            }
        } else if decimalRange != nil {
            profileSettingView.statusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            profileSettingView.statusLabel.textColor = .cineConditionRed
            isNicknameValidate = false
            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
            }
        } else {
            profileSettingView.statusLabel.text = "사용할 수 있는 닉네임이에요"
            profileSettingView.statusLabel.textColor = .cineConditionBlue
            isNicknameValidate = true
            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
            }
        }
    }
    
    @objc
    private func doneButtonTapped() {
        if UserDefaultsManager.shared.isSigned {
            reSaveImage?(profileSettingView.profileImageView.image ?? UIImage())
            reSaveNickname?(profileSettingView.nicknameTextField.text ?? "")
            dismiss(animated: true)
        } else {
            let vc = TabBarController()
            UserDefaultsManager.shared.nickname = profileSettingView.nicknameTextField.text ?? ""
            UserDefaultsManager.shared.joinDate = Date().toJoinString()
            if let imageData = profileSettingView.profileImageView.image?.pngData() {
                UserDefaultsManager.shared.profileImage = imageData
            }
            changeRootViewController(vc: vc, isSigned: true)
        }
    }
    
    @objc
    private func closeButtonTapped() {
        if UserDefaultsManager.shared.isSigned {
            dismiss(animated: true)
        }
    }
    
    @objc
    private func imageReceivedNotification(value: NSNotification) {
        if let image = value.userInfo!["image"] as? UIImage {
            profileSettingView.profileImageView.image = image
        }
    }
    
    @objc
    private func mbtiEIButtonTapped(_ sender: UIButton) {
        toggleButton(sender, array: mbtiEIButtonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    @objc
    private func mbtiSNButtonTapped(_ sender: UIButton) {
        toggleButton(sender, array: mbtiSNButtonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    @objc
    private func mbtiTFButtonTapped(_ sender: UIButton) {
        toggleButton(sender, array: mbtiTFButtonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    @objc
    private func mbtiJPButtonTapped(_ sender: UIButton) {
        toggleButton(sender, array: mbtiJPButtonArray)
        validateButton()
        profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
    }
    
    private func toggleButton(_ sender: UIButton, array: [UIButton]) {
        for i in array {
            // 조건1: 하나의 버튼이 true이면 다른 버튼은 false여야 함
            // 조건2: 이미 true인 버튼을 탭하면 false로 바뀌어야 함
            if i == sender {
                if !i.isSelected {
                    i.isSelected = true
                } else {
                    i.isSelected = false
                }
            } else {
                i.isSelected = false
            }
        }
    }
    
    private func validateButton() {
        if (profileSettingView.mbtiEButton.isSelected || profileSettingView.mbtiIButton.isSelected) &&
            (profileSettingView.mbtiSButton.isSelected || profileSettingView.mbtiNButton.isSelected) &&
            (profileSettingView.mbtiTButton.isSelected || profileSettingView.mbtiFButton.isSelected) &&
            (profileSettingView.mbtiJButton.isSelected || profileSettingView.mbtiPButton.isSelected) {
            isButtonValidate = true
        } else {
            isButtonValidate = false
        }
    }
    
    private func isDoneButtonEnabled() -> Bool {
        if isNicknameValidate && isButtonValidate {
            return true
        } else {
            return false
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
