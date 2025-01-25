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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 설정"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingView.profileImageView.addGestureRecognizer(tapGesture)
        profileSettingView.profileImageView.isUserInteractionEnabled = true
        profileSettingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
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
    private func doneButtonTapped() {
        print(#function)
    }
}
