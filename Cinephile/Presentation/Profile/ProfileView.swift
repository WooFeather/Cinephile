//
//  ProfileView.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {

    let testButton = UIButton()

    override func configureHierarchy() {
        addSubview(testButton)
    }
    
    override func configureLayout() {
        testButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(100)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        testButton.setTitle("탈퇴하기", for: .normal)
        testButton.setTitleColor(.cineAccent, for: .normal)
    }
}
