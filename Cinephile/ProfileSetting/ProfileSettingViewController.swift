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
        profileSettingView.imageSettingButton.addTarget(self, action: #selector(imageSettingButtonTapped), for: .touchUpInside)
        profileSettingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func imageSettingButtonTapped() {
        let vc = ImageSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func doneButtonTapped() {
        print(#function)
    }
}
