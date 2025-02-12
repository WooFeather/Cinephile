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
        
        viewModel.output.profileImageData.lazyBind { data in
            guard let data = data else { return }
            self.profileSettingView.profileImageView.image = UIImage(data: data)
        }
        
        viewModel.output.imageViewTapped.lazyBind { _ in
            print("outputImageViewTapped bind")
            let vc = ImageSettingViewController()
            vc.viewModel.output.profileImageData.value = self.profileSettingView.profileImageView.image?.pngData()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 상태레이블 텍스트
        viewModel.output.statusLabelText.lazyBind { text in
            self.profileSettingView.statusLabel.text = text
        }
        
        // 상태레이블 색상 및 완료버튼 활성화
        viewModel.output.nicknameValidation.lazyBind { status in
            self.profileSettingView.statusLabel.textColor = status ? .cineConditionBlue : .cineConditionRed
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
        viewModel.input.profileImageData.value = profileSettingView.profileImageView.image?.pngData()
        viewModel.input.doneButtonTapped.value = ()
    }
    
    @objc
    private func closeButtonTapped() {
        viewModel.input.closeButtonTapped.value = ()
    }
}

// MARK: - Extension
extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
