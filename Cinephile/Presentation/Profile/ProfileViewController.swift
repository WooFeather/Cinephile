//
//  ProfileViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    private var profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func configureEssential() {
        navigationItem.title = "설정"
        profileView.testButton.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func testButtonTapped() {
        // TODO: 알럿 띄우기 / 데이터 삭제하기
        
        let vc = UINavigationController(rootViewController: OnboardingViewController())
        changeRootViewController(vc: vc, isSigned: false)
    }
}
