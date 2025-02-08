//
//  ActionButton.swift
//  Cinephile
//
//  Created by 조우현 on 2/8/25.
//

import UIKit

// 프로필 설정화면의 완료버튼으로 사용
class ActionButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.cinaWhite, for: .normal)
        setTitleColor(.cineSecondaryGray, for: .disabled)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        layer.cornerRadius = 22
        layer.borderWidth = 1.5
    }
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                backgroundColor = .cineConditionBlue
            } else {
                backgroundColor = .cineConditionGray
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
