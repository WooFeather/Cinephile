//
//  ProfileSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

// MARK: - MBTI 버튼을 두번씩 눌러야되는 문제 발생........

import UIKit

final class ProfileSettingViewController: BaseViewController {
    
    private var profileSettingView = ProfileSettingView()
    private let viewModel = ProfileSettingViewModel()
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
    }
    
    override func configureAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingView.profileImageView.addGestureRecognizer(tapGesture)
        profileSettingView.profileImageView.isUserInteractionEnabled = true
        
        profileSettingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        profileSettingView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingChanged), for: .editingChanged)
        profileSettingView.mbtiEButton.addTarget(self, action: #selector(mbtiEButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiIButton.addTarget(self, action: #selector(mbtiIButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiSButton.addTarget(self, action: #selector(mbtiSButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiNButton.addTarget(self, action: #selector(mbtiNButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiTButton.addTarget(self, action: #selector(mbtiTButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiFButton.addTarget(self, action: #selector(mbtiFButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiJButton.addTarget(self, action: #selector(mbtiJButtonTapped), for: .touchUpInside)
        profileSettingView.mbtiPButton.addTarget(self, action: #selector(mbtiPButtonTapped), for: .touchUpInside)
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
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputProfileImage.lazyBind { image in
            self.profileSettingView.profileImageView.image = image
        }
        
        viewModel.outputImageViewTapped.lazyBind { _ in
            print("outputImageViewTapped bind")
            let vc = ImageSettingViewController()
            vc.viewModel.outputProfileImage.value = self.profileSettingView.profileImageView.image
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 상태레이블 텍스트
        viewModel.outputStatusLabelText.lazyBind { text in
            self.profileSettingView.statusLabel.text = text
        }
        
        // 상태레이블 색상
        viewModel.outputStatusLabelTextColor.lazyBind { status in
            self.profileSettingView.statusLabel.textColor = status ? .cineConditionBlue : .cineConditionRed
        }
        
        viewModel.outputDoneButtonEnabled.lazyBind { status in
            self.profileSettingView.doneButton.isEnabled = status
            if UserDefaultsManager.shared.isSigned {
                self.navigationItem.rightBarButtonItem?.isEnabled = status
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
    private func mbtiEButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiEIButtonTapped.value = sender
        viewModel.inputEButton.value = sender
    }
    
    @objc
    private func mbtiIButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiEIButtonTapped.value = sender
        viewModel.inputIButton.value = sender
    }
    
    @objc
    private func mbtiSButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiSNButtonTapped.value = sender
        viewModel.inputSButton.value = sender
    }
    
    @objc
    private func mbtiNButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiSNButtonTapped.value = sender
        viewModel.inputNButton.value = sender
    }
    
    @objc
    private func mbtiTButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiTFButtonTapped.value = sender
        viewModel.inputTButton.value = sender
    }
    
    @objc
    private func mbtiFButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiTFButtonTapped.value = sender
        viewModel.inputFButton.value = sender
    }
    
    @objc
    private func mbtiJButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiJPButtonTapped.value = sender
        viewModel.inputJButton.value = sender
    }
    
    @objc
    private func mbtiPButtonTapped(_ sender: UIButton) {
        viewModel.inputMbtiJPButtonTapped.value = sender
        viewModel.inputPButton.value = sender
    }
}

// MARK: - Extension
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
