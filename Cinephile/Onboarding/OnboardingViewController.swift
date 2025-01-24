//
//  OnboardingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    private var onboardingView = OnboardingView()
    
    override func loadView() {
        view = onboardingView
    }
    
    override func configureEssential() {
        onboardingView.startButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
    }
    
    @objc func starButtonTapped() {
        print(#function)
        let vc = ProfileSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

