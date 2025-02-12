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
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonTapped)), animated: true)
        }
        
        if UserDefaultsManager.shared.isSigned {
            profileSettingView.profileImageView.image = UIImage(data: viewModel.output.imageDataContents.value)
            profileSettingView.nicknameTextField.text = viewModel.output.nicknameContents.value
        }
    }
    
    override func bindData() {
        viewModel.input.viewDidLoadTrigger.value = ()
        
        viewModel.output.imageDataContents.lazyBind { [weak self] data in
            self?.profileSettingView.profileImageView.image = UIImage(data: data)
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
        viewModel.output.imageViewTapped.lazyBind { [weak self] _ in
            print("outputImageViewTapped bind")
            let vc = ImageSettingViewController()
            vc.viewModel.output.profileImageData.value = self?.profileSettingView.profileImageView.image?.pngData()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 상태레이블 텍스트
        viewModel.output.statusLabelText.lazyBind { [weak self] text in
            self?.profileSettingView.statusLabel.text = text
        }
        
        // 상태레이블 색상 및 완료버튼 활성화
        viewModel.output.nicknameValidation.lazyBind { [weak self] status in
            self?.profileSettingView.statusLabel.textColor = status ? .cineConditionBlue : .cineConditionRed
            self?.profileSettingView.doneButton.isEnabled = status
            if UserDefaultsManager.shared.isSigned {
                self?.navigationItem.rightBarButtonItem?.isEnabled = status
            }
        }
        
        viewModel.output.doneButtonTapped.lazyBind { [weak self] _ in
            if UserDefaultsManager.shared.isSigned {
                self?.dismiss(animated: true)
            } else {
                let vc = TabBarController()
                self?.changeRootViewController(vc: vc, isSigned: true)
            }
        }
        
        viewModel.output.closeButtonTapped.lazyBind { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    // MARK: - Actions
    @objc
    private func profileImageTapped(sender: UITapGestureRecognizer) {
        viewModel.input.imageViewTapped.value = ()
    }
    
    @objc
    private func nicknameTextFieldEditingChanged() {
        guard let textFieldText = profileSettingView.nicknameTextField.text else { return }
        viewModel.input.nicknameTextFieldEditingChanged.value = textFieldText
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
