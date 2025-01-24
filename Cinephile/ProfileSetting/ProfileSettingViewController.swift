//
//  ProfileSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

class ProfileSettingViewController: BaseViewController {
    private var profileSettingView = ProfileSettingView()
    
    override func loadView() {
        view = profileSettingView
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 설정"
    }
}
