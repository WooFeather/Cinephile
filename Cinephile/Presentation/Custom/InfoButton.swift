//
//  InfoButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit

class InfoButton: UIButton {

    init(icon: UIImage) {
        super.init(frame: .zero)
        configuration = .infoButtonStyle(icon: icon)
        tintColor = .cinePrimaryGray
        titleLabel?.font = .systemFont(ofSize: 12)
        isUserInteractionEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
