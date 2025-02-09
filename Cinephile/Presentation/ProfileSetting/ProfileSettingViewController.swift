//
//  ProfileSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class ProfileSettingViewController: BaseViewController {
    
    private var profileSettingView = ProfileSettingView()
    private let viewModel = ProfileSettingViewModel()
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
    
    // MARK: - Functions
    override func loadView() {
        view = profileSettingView
    }
    
    override func configureEssential() {
        profileSettingView.nicknameTextField.delegate = self
        receiveImage()
    }
    
    override func configureAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingView.profileImageView.addGestureRecognizer(tapGesture)
        profileSettingView.profileImageView.isUserInteractionEnabled = true
        
        profileSettingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        profileSettingView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingChanged), for: .editingChanged)
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
        navigationItem.title = "프로필 설정"
        
        if UserDefaultsManager.shared.isSigned {
            sheetPresentationController?.prefersGrabberVisible = true
            navigationItem.setRightBarButton(UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(doneButtonTapped)), animated: true)
            navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonTapped)), animated: true)
        }
        
        if UserDefaultsManager.shared.isSigned {
            profileSettingView.profileImageView.image = imageContents
            profileSettingView.nicknameTextField.text = nicknameContents
        }
    }
    
    override func bindData() {
        viewModel.outputImageViewTapped.lazyBind { _ in
            print("outputImageViewTapped bind")
            let vc = ImageSettingViewController()
            vc.imageContents = self.profileSettingView.profileImageView.image
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 상태레이블 텍스트
        viewModel.outputStatusLabelText.lazyBind { text in
            self.profileSettingView.statusLabel.text = text
        }
        
        // 상태레이블 색상 및 isNicknameValidate
        viewModel.outputNicknameValidate.lazyBind { status in
            self.profileSettingView.statusLabel.textColor = status ? .cineConditionBlue : .cineConditionRed
            self.isNicknameValidate = status
        }
        
        // TODO: 이 안의 로직도 VM으로 빼기
        viewModel.outputMbtiEIButtonTapped.lazyBind { sender in
            print("outputMbtiEIButtonTapped bind")
            self.toggleButton(sender ?? UIButton(), array: self.mbtiEIButtonArray)
            self.validateButton()
            self.profileSettingView.doneButton.isEnabled = self.isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                self.navigationItem.rightBarButtonItem?.isEnabled = self.isDoneButtonEnabled()
            }
        }
        
        viewModel.outputMbtiSNButtonTapped.lazyBind { sender in
            print("outputMbtiSNButtonTapped bind")
            self.toggleButton(sender ?? UIButton(), array: self.mbtiSNButtonArray)
            self.validateButton()
            self.profileSettingView.doneButton.isEnabled = self.isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                self.navigationItem.rightBarButtonItem?.isEnabled = self.isDoneButtonEnabled()
            }
        }
        
        viewModel.outputMbtiTFButtonTapped.lazyBind { sender in
            print("outputMbtiTFButtonTapped bind")
            self.toggleButton(sender ?? UIButton(), array: self.mbtiTFButtonArray)
            self.validateButton()
            self.profileSettingView.doneButton.isEnabled = self.isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                self.navigationItem.rightBarButtonItem?.isEnabled = self.isDoneButtonEnabled()
            }
        }
        
        viewModel.outputMbtiJPButtonTapped.lazyBind { sender in
            print("outputMbtiJPButtonTapped bind")
            self.toggleButton(sender ?? UIButton(), array: self.mbtiJPButtonArray)
            self.validateButton()
            self.profileSettingView.doneButton.isEnabled = self.isDoneButtonEnabled()
            if UserDefaultsManager.shared.isSigned {
                self.navigationItem.rightBarButtonItem?.isEnabled = self.isDoneButtonEnabled()
            }
        }
        
        viewModel.outputDoneButtonTapped.lazyBind { _ in
            if UserDefaultsManager.shared.isSigned {
                self.dismiss(animated: true)
            } else {
                let vc = TabBarController()
                self.changeRootViewController(vc: vc, isSigned: true)
            }
        }
        
        viewModel.outputCloseButtonTapped.lazyBind { _ in
            self.dismiss(animated: true)
        }
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
    
    // MARK: - Actions
    @objc
    private func profileImageTapped(sender: UITapGestureRecognizer) {
        viewModel.inputImageViewTapped.value = ()
    }
    
    @objc
    private func nicknameTextFieldEditingChanged() {
        viewModel.inputNicknameTextFieldEditingChanged.value = profileSettingView.nicknameTextField.text
    }
    
    @objc
    private func doneButtonTapped() {
        viewModel.inputNicknameTextFieldText.value = profileSettingView.nicknameTextField.text
        viewModel.inputProfileImage.value = profileSettingView.profileImageView.image
        viewModel.inputDoneButtonTapped.value = ()
    }
    
    @objc
    private func closeButtonTapped() {
        viewModel.inputCloseButtonTapped.value = ()
    }
    
    @objc
    private func imageReceivedNotification(value: NSNotification) {
        if let image = value.userInfo!["image"] as? UIImage {
            profileSettingView.profileImageView.image = image
        }
    }
    
    @objc
    private func mbtiEIButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiEIButtonTapped.value = sender
    }
    
    @objc
    private func mbtiSNButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiSNButtonTapped.value = sender
    }
    
    @objc
    private func mbtiTFButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiTFButtonTapped.value = sender
    }
    
    @objc
    private func mbtiJPButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiJPButtonTapped.value = sender
    }
}

// MARK: - Extension
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
