//
//  OnboardingView.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    
    private let mainImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let startButton = PointButton(title: "시작하기")
    
    override func configureHierarchy() {
        [mainImageView, titleLabel, descriptionLabel, startButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(500)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(-18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(35)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(40)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        mainImageView.image = .onboarding
        mainImageView.contentMode = .scaleAspectFill
        
        titleLabel.text = "Onboarding"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        
        descriptionLabel.text = "당신만의 영화 세상,\nCinephile을 시작해보세요."
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .cinePrimaryGray
    }
}
