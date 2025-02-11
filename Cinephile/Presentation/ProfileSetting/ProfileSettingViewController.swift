//
//  ProfileSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class ProfileSettingViewController: BaseViewController {
    
    private var profileSettingView = ProfileSettingView()
    let viewModel = ProfileSettingViewModel()
    var imageContents: UIImage?
    var nicknameContents: String?
    
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
        viewModel.input.viewDidLoadTrigger.value = ()
        
        viewModel.output.profileImage.lazyBind { image in
            self.profileSettingView.profileImageView.image = image
        }
        
        viewModel.output.imageViewTapped.lazyBind { _ in
            print("outputImageViewTapped bind")
            let vc = ImageSettingViewController()
            vc.viewModel.output.profileImage.value = self.profileSettingView.profileImageView.image
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 상태레이블 텍스트
        viewModel.output.statusLabelText.lazyBind { text in
            self.profileSettingView.statusLabel.text = text
        }
        
        // 상태레이블 색상
        viewModel.output.statusLabelTextColor.lazyBind { status in
            self.profileSettingView.statusLabel.textColor = status ? .cineConditionBlue : .cineConditionRed
        }
        
        viewModel.output.doneButtonEnabled.lazyBind { status in
            self.profileSettingView.doneButton.isEnabled = status
            if UserDefaultsManager.shared.isSigned {
                self.navigationItem.rightBarButtonItem?.isEnabled = status
            }
        }
        
        viewModel.output.doneButtonTapped.lazyBind { _ in
            if UserDefaultsManager.shared.isSigned {
                self.dismiss(animated: true)
            } else {
                let vc = TabBarController()
                self.changeRootViewController(vc: vc, isSigned: true)
            }
        }
        
        viewModel.output.closeButtonTapped.lazyBind { _ in
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - Actions
    @objc
    private func profileImageTapped(sender: UITapGestureRecognizer) {
        viewModel.input.imageViewTapped.value = ()
    }
    
    @objc
    private func nicknameTextFieldEditingChanged() {
        viewModel.input.nicknameTextFieldEditingChanged.value = profileSettingView.nicknameTextField.text
    }
    
    @objc
    private func doneButtonTapped() {
        viewModel.input.nicknameTextFieldText.value = profileSettingView.nicknameTextField.text
        viewModel.input.profileImage.value = profileSettingView.profileImageView.image
        viewModel.input.doneButtonTapped.value = ()
    }
    
    @objc
    private func closeButtonTapped() {
        viewModel.input.closeButtonTapped.value = ()
    }
    
    @objc
    private func mbtiEButtonTapped(_ sender: UIButton) {
        viewModel.input.eButton.value = sender
    }
    
    @objc
    private func mbtiIButtonTapped(_ sender: UIButton) {
        viewModel.input.iButton.value = sender
    }
    
    @objc
    private func mbtiSButtonTapped(_ sender: UIButton) {
        viewModel.input.sButton.value = sender
    }
    
    @objc
    private func mbtiNButtonTapped(_ sender: UIButton) {
        viewModel.input.nButton.value = sender
    }
    
    @objc
    private func mbtiTButtonTapped(_ sender: UIButton) {
        viewModel.input.tButton.value = sender
    }
    
    @objc
    private func mbtiFButtonTapped(_ sender: UIButton) {
        viewModel.input.fButton.value = sender
    }
    
    @objc
    private func mbtiJButtonTapped(_ sender: UIButton) {
        viewModel.input.jButton.value = sender
    }
    
    @objc
    private func mbtiPButtonTapped(_ sender: UIButton) {
        viewModel.input.pButton.value = sender
    }
}

// MARK: - Extension
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
