//
//  OnboardingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    private var onboardingView = OnboardingView()
    private let viewModel = OnboardingViewModel()
    
    override func loadView() {
        view = onboardingView
    }
    
    override func bindData() {
        viewModel.output.startButtonTapped.lazyBind { [weak self] _ in
            let vc = ProfileSettingViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func configureEssential() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func startButtonTapped() {
        viewModel.input.startButtonTapped.value = ()
    }
}

